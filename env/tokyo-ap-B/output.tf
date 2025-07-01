#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# ELB
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
output "alb_pd1_arn" {
  value = module.elb.alb_pd1_arn
}

output "alb_pd1_tokyo_ap_B_arn" {
  value = module.elb.alb_pd1_arn
}