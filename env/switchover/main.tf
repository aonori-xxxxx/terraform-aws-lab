# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# Global Accelerator Endpoint Group Tokyo
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

module "accelerator_endpoint_group" {
  source         = "../../modules/accelerator_endpoint"
  name_prefix    = var.name_prefix
  ga_listener_id = data.terraform_remote_state.common.outputs.ga_listener_id
  region         = var.region
  traffice_dial_percentage = 100
  elb_arns = [
    data.terraform_remote_state.tk_ap_A.outputs.alb_pd1_arn,
    data.terraform_remote_state.tk_ap_B.outputs.alb_pd1_arn,
  ]

  endpoint_configurations = [
    #Tokyo ap A
    {
      endpoint_id = data.terraform_remote_state.tk_ap_A.outputs.alb_pd1_arn
      weight      = 100
    },
    #Tokyo ap B
    
    # {
    #   endpoint_id = data.terraform_remote_state.tk_ap_B.outputs.alb_pd1_arn
    #   weight      = 0
    # }
  ]
}

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# Global Accelerator Endpoint Group Osaka
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

# module "accelerator_endpoint_group_osaka" {
#   source = "../../modules/accelerator_endpoint"
#   name_prefix    = var.name_prefix
#   region         = "ap-northeast-3"
#   traffice_dial_percentage = 0
#   providers = {
#     aws = aws.osaka
#   }
  
#   ga_listener_id = data.terraform_remote_state.common.outputs.ga_listener_id
#   elb_arns = [
#     data.terraform_remote_state.os_ap.outputs.alb_pd1_arn
#   ]
#    endpoint_configurations = [
#     {
#       endpoint_id = data.terraform_remote_state.os_ap.outputs.alb_pd1_arn
#       weight      = 100
#     }
#   ]
# }
