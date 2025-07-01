output "sg_ids_output" {
  value = {
    sg_unique_mysql_RDS_id = aws_security_group.unique_mysql_RDS.id
    sg_common_mysql_RDS_id = aws_security_group.common_mysql_RDS.id
    sg_unique_ping_srv_id  = aws_security_group.unique_ping_srv.id
    sg_common_maint_srv_id = aws_security_group.common_maint_srv.id
    sg_unique_maint_srv_id = aws_security_group.unique_maint_srv.id
    sg_common_efs_efs_id   = aws_security_group.common_efs_efs.id
  }
}


