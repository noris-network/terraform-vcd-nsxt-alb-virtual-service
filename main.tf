data "vcd_vdc_group" "vdc_group" {
  name = var.vdc_group_name
}

data "vcd_nsxt_edgegateway" "nsxt_edgegateway" {
  org      = var.vdc_org_name
  owner_id = data.vcd_vdc_group.vdc_group.id
  name     = var.vdc_edgegateway_name
}

data "vcd_nsxt_alb_edgegateway_service_engine_group" "nsxt_alb_edgegateway_service_engine_group" {
  edge_gateway_id           = data.vcd_nsxt_edgegateway.nsxt_edgegateway.id
  service_engine_group_name = var.service_engine_group_name
}

data "vcd_nsxt_alb_pool" "nsxt_alb_pool" {
  name            = var.pool_name
  edge_gateway_id = data.vcd_nsxt_edgegateway.nsxt_edgegateway.id
}

data "vcd_library_certificate" "library_certificate" {
  for_each = var.ca_certificate_required ? { cert_alias = var.cert_alias } : {}
  alias    = each.value
}

resource "vcd_nsxt_alb_virtual_service" "nsxt_alb_virtual_service" {
  name                        = var.virtual_service_name
  edge_gateway_id             = data.vcd_nsxt_edgegateway.nsxt_edgegateway.id
  description                 = var.virtual_service_description
  pool_id                     = data.vcd_nsxt_alb_pool.nsxt_alb_pool.id
  service_engine_group_id     = data.vcd_nsxt_alb_edgegateway_service_engine_group.nsxt_alb_edgegateway_service_engine_group.service_engine_group_id
  application_profile_type    = var.application_profile_type
  virtual_ip_address          = var.virtual_ip_address
  is_transparent_mode_enabled = var.is_transparent_mode_enabled
  ca_certificate_id           = var.ca_certificate_required ? data.vcd_library_certificate.library_certificate["cert_alias"].id : null

  dynamic "service_port" {
    for_each = var.service_ports
    content {
      start_port  = service_port.value["start_port"]
      type        = service_port.value["type"]
      ssl_enabled = lookup(service_port.value, "ssl_enabled", false)
      end_port    = lookup(service_port.value, "end_port", null)
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}
