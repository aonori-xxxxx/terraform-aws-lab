#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#launch template
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

# lt-1
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

resource "aws_launch_template" "lt-1" {
  update_default_version = true
  name                   = "${var.name_prefix}-${var.name_lt_1}"
  key_name               = var.keypair_name
  instance_type          = "m5.large"
  image_id               = var.ami_id
  monitoring {
    enabled = true
  }
  iam_instance_profile {
    name = var.ec2_profile_name

  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.name_prefix}"
    }
  }

  network_interfaces {
    associate_public_ip_address = false
    delete_on_termination       = true
    security_groups = [
      var.sg_ids_output["sg_common_maint_srv_id"],
      var.sg_ids_output["sg_common_app_srv_id"]
    ]

    subnet_id = var.subnet_ids["subnet_private_srv_a"]
  }

  metadata_options {
    http_endpoint          = "enabled"
    instance_metadata_tags = "enabled"
  }
  instance_initiated_shutdown_behavior = "terminate"

  user_data = base64encode(<<-EOF
#!/bin/bash

mkdir /user_data_common
mkdir /user_data

mount -t nfs -o vers=4.1 10.10.202.217:/user_data /user_data_common
sh /user_data_common/common_userdata-amz23.sh &

mount -t nfs -o vers=4.1 10.10.202.237:/user_data /user_data
sh /user_data/prd-aws10-p1-xa21-user-data.sh

sleep 1800
umount /user_data_common
umount /user_data
  EOF
  )
}
