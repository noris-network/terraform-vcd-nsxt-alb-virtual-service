output "nsxt_alb_virtual_service_id" {
  description = "ID of the created NSX-T ALB Virtual Service."
  value       = vcd_nsxt_alb_virtual_service.nsxt_alb_virtual_service.id
}

output "nsxt_alb_virtual_service_vip" {
  description = "IP Address of the created NSX-T ALB Virtual Service."
  value       = var.virtual_ip_address
}

output "nsxt_alb_pool_id" {
  description = "ID of the NSX-T ALB Pool."
  value       = data.vcd_nsxt_alb_pool.nsxt_alb_pool.id
}

output "nsxt_alb_pool_name" {
  description = "Name of the NSX-T ALB Pool."
  value       = var.pool_name
}

output "nsxt_alb_application_profile_type" {
  description = "Type of application profile for the NSX-T ALB Virtual Service."
  value       = var.application_profile_type
}

output "nsxt_alb_virtual_service_service_ports" {
  description = "List of service ports configuration for the NSX-T ALB Virtual Service."
  value = [for i in range(length(var.service_ports)) : {
    start_port  = var.service_ports[i]["start_port"],
    end_port    = lookup(var.service_ports[i], "end_port", ""),
    type        = var.service_ports[i]["type"],
    ssl_enabled = lookup(var.service_ports[i], "ssl_enabled", false)
  }]
}
