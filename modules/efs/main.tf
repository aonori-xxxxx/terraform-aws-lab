#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#EFS
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

# EFS を作成
resource "aws_efs_file_system" "efs_21" {
  tags = {
    Name = "${var.name_prefix}-efs-as21"
  }
}

# マウントターゲットを作成
resource "aws_efs_mount_target" "efs_21" {
  file_system_id  = aws_efs_file_system.efs_21.id
  security_groups = [var.sg_ids_output["sg_common_efs_efs_id"]]
  for_each = {
    subnet_private_srv_a = var.subnet_ids_output["subnet_private_srv_a"]
    subnet_private_srv_c = var.subnet_ids_output["subnet_private_srv_c"]
  }
  subnet_id = each.value
}
