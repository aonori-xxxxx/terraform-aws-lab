#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Global Accelerator Endpoint Group
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

resource "aws_globalaccelerator_endpoint_group" "stg" {
  listener_arn            = var.ga_listener_id
  endpoint_group_region   = var.region
  traffic_dial_percentage = var.traffice_dial_percentage
  dynamic "endpoint_configuration" {
    for_each = var.endpoint_configurations
    content {
      endpoint_id = endpoint_configuration.value.endpoint_id
      weight      = endpoint_configuration.value.weight
    }
  }
}
