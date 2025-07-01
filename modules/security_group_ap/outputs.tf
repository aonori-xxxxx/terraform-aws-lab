output "sg_ids_output" {
  value = {
    sg_common_web_LBexternal_id = aws_security_group.common_web_LBexternal.id
    sg_common_web_LBinternal_id = aws_security_group.common_web_LBinternal.id
    sg_unique_ping_srv_id       = aws_security_group.unique_ping_srv.id
    sg_common_maint_srv_id      = aws_security_group.common_maint_srv.id
    sg_common_app_srv_id        = aws_security_group.common_app_srv.id
  }
}