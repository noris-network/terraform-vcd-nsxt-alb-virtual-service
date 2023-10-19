# terraform-vcd-nsxt-alb-virtual-service

Terraform module which manages NSX-T ALB loadbalancer ressources on VMWare Cloud Director.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.9 |
| <a name="requirement_vcd"></a> [vcd](#requirement\_vcd) | >= 3.9.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_vcd"></a> [vcd](#provider\_vcd) | 3.9.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [vcd_nsxt_alb_virtual_service.nsxt_alb_virtual_service](https://registry.terraform.io/providers/vmware/vcd/latest/docs/resources/nsxt_alb_virtual_service) | resource |
| [vcd_library_certificate.library_certificate](https://registry.terraform.io/providers/vmware/vcd/latest/docs/data-sources/library_certificate) | data source |
| [vcd_nsxt_alb_edgegateway_service_engine_group.nsxt_alb_edgegateway_service_engine_group](https://registry.terraform.io/providers/vmware/vcd/latest/docs/data-sources/nsxt_alb_edgegateway_service_engine_group) | data source |
| [vcd_nsxt_alb_pool.nsxt_alb_pool](https://registry.terraform.io/providers/vmware/vcd/latest/docs/data-sources/nsxt_alb_pool) | data source |
| [vcd_nsxt_edgegateway.nsxt_edgegateway](https://registry.terraform.io/providers/vmware/vcd/latest/docs/data-sources/nsxt_edgegateway) | data source |
| [vcd_vdc_group.vdc_group](https://registry.terraform.io/providers/vmware/vcd/latest/docs/data-sources/vdc_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_profile_type"></a> [application\_profile\_type](#input\_application\_profile\_type) | The type of application profile for the NSX-T ALB Virtual Service. | `string` | n/a | yes |
| <a name="input_ca_certificate_required"></a> [ca\_certificate\_required](#input\_ca\_certificate\_required) | Defines if a CA certificate is required for the virtual service. Set to true for HTTPS and L4\_TLS types, and to false for HTTP and L4 types. | `bool` | n/a | yes |
| <a name="input_pool_name"></a> [pool\_name](#input\_pool\_name) | The name of the NSX-T ALB Pool. | `string` | n/a | yes |
| <a name="input_service_engine_group_name"></a> [service\_engine\_group\_name](#input\_service\_engine\_group\_name) | The name of the NSX-T ALB Service Engine Group. | `string` | n/a | yes |
| <a name="input_service_ports"></a> [service\_ports](#input\_service\_ports) | List of service ports configuration for the NSX-T ALB Virtual Service. | <pre>list(object({<br>    start_port  = number<br>    end_port    = optional(number)<br>    type        = string<br>    ssl_enabled = optional(bool)<br>  }))</pre> | n/a | yes |
| <a name="input_vdc_edgegateway_name"></a> [vdc\_edgegateway\_name](#input\_vdc\_edgegateway\_name) | Edge Gateway of Customer. | `string` | n/a | yes |
| <a name="input_vdc_group_name"></a> [vdc\_group\_name](#input\_vdc\_group\_name) | Default Virtual Data Center Group of Customer. | `string` | n/a | yes |
| <a name="input_vdc_org_name"></a> [vdc\_org\_name](#input\_vdc\_org\_name) | The name of the organization to use. | `string` | n/a | yes |
| <a name="input_virtual_ip_address"></a> [virtual\_ip\_address](#input\_virtual\_ip\_address) | IP Address for the service to listen on. | `string` | n/a | yes |
| <a name="input_virtual_service_name"></a> [virtual\_service\_name](#input\_virtual\_service\_name) | The name of the NSX-T ALB Virtual Service. | `string` | n/a | yes |
| <a name="input_cert_alias"></a> [cert\_alias](#input\_cert\_alias) | The alias of the certificate from the VCD library. | `string` | `null` | no |
| <a name="input_is_transparent_mode_enabled"></a> [is\_transparent\_mode\_enabled](#input\_is\_transparent\_mode\_enabled) | Whether the transparent mode is enabled for the NSX-T ALB Virtual Service. | `bool` | `false` | no |
| <a name="input_virtual_service_description"></a> [virtual\_service\_description](#input\_virtual\_service\_description) | The description of the NSX-T ALB Virtual Service. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nsxt_alb_application_profile_type"></a> [nsxt\_alb\_application\_profile\_type](#output\_nsxt\_alb\_application\_profile\_type) | Type of application profile for the NSX-T ALB Virtual Service. |
| <a name="output_nsxt_alb_pool_id"></a> [nsxt\_alb\_pool\_id](#output\_nsxt\_alb\_pool\_id) | ID of the NSX-T ALB Pool. |
| <a name="output_nsxt_alb_pool_name"></a> [nsxt\_alb\_pool\_name](#output\_nsxt\_alb\_pool\_name) | Name of the NSX-T ALB Pool. |
| <a name="output_nsxt_alb_virtual_service_id"></a> [nsxt\_alb\_virtual\_service\_id](#output\_nsxt\_alb\_virtual\_service\_id) | ID of the created NSX-T ALB Virtual Service. |
| <a name="output_nsxt_alb_virtual_service_service_ports"></a> [nsxt\_alb\_virtual\_service\_service\_ports](#output\_nsxt\_alb\_virtual\_service\_service\_ports) | List of service ports configuration for the NSX-T ALB Virtual Service. |
| <a name="output_nsxt_alb_virtual_service_vip"></a> [nsxt\_alb\_virtual\_service\_vip](#output\_nsxt\_alb\_virtual\_service\_vip) | IP Address of the created NSX-T ALB Virtual Service. |
<!-- END_TF_DOCS -->

## Examples

```
module "webserver_loadbalancer" {
  source                    = "git::https://github.com/noris-network/terraform-vcd-alb-virtual-service?ref=1.0.0"
  vdc_org_name              = "myORG"
  vdc_group_name            = "myDCGroup"
  vdc_edgegateway_name      = "T1-myORG"
  service_engine_group_name = "mySEG"
  virtual_service_name      = "webserver_lb"
  pool_name                 = "webserver_alb_pool"
  application_profile_type  = "HTTPS"
  ca_certificate_required   = true
  cert_alias                = "www.example.net"
  virtual_ip_address        = "123.234.123.234"
  service_ports             = [
    {
      start_port  = 443
      ssl_enabled = true
      type        = "TCP_PROXY"
    }
  ]
}
```
