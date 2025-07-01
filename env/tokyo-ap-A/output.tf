#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# ELB
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
output "alb_pd1_arn" {
  value = module.elb.alb_pd1_arn
}

output "alb_pd1_tokyo_ap_A_arn" {
  value = module.elb.alb_pd1_arn
}