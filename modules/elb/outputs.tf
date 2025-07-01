#arnはcloudwatchで使用
output "target_group_lb1_arn" {
  value = aws_lb_target_group.target_group_lb1.arn
}
output "target_group_pd1_arn" {
  value = aws_lb_target_group.target_group_pd1.arn
}
output "alb_pd1_arn" {
  value = aws_lb.alb_pd1.arn
}
output "alb_lb1_arn" {
  value = aws_lb.alb_lb1.arn
}
#arn_suffixはcloudwatchで使用
output "target_group_lb1_arn_suffix" {
  value = aws_lb_target_group.target_group_lb1.arn_suffix
}
output "target_group_pd1_arn_suffix" {
  value = aws_lb_target_group.target_group_pd1.arn_suffix
}
output "alb_lb1_arn_suffix" {
  value = aws_lb.alb_lb1.arn_suffix
}
output "alb_pd1_arn_suffix" {
  value = aws_lb.alb_pd1.arn_suffix
}
