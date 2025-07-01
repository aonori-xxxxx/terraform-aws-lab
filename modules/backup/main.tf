#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#AWS Backup
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

# AWS Backup Vault
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
resource "aws_backup_vault" "tokyo_vault" {
  provider = aws # 東京リージョン
  # name     = "aurora-backup-vault-tokyo"
  name = var.backup_input["backup_aurora_tk_vault"]

}

# 東京リージョンのバックアッププラン
resource "aws_backup_plan" "tokyo_backup_plan" {
  provider = aws # 東京リージョン
  name     = var.backup_input["backup_aurora_tk_plan"]
  rule {
    completion_window        = 180
    enable_continuous_backup = false
    # rule_name                = "daily-backup"
    # schedule          = "cron(35 7 * * ? *)"
    rule_name         = var.backup_input["backup_aurora_tk_rule_name"]
    schedule          = var.backup_input["backup_aurora_tk_schedule"]
    start_window      = var.backup_input["backup_aurora_tk_start_window"]
    target_vault_name = aws_backup_vault.tokyo_vault.name
    lifecycle {
      delete_after = 365
    }
    copy_action {
      destination_vault_arn = aws_backup_vault.osaka_vault.arn
      lifecycle {
        delete_after = 365
      }
    }
  }
}

resource "aws_backup_selection" "stg-env" {
  name         = var.name_prefix
  plan_id      = aws_backup_plan.tokyo_backup_plan.id
  iam_role_arn = var.backup_role_arn
  resources = [
    var.aurora_cluster_arn
  ]
}

#大阪リージョンのバックアップボールトを作成
resource "aws_backup_vault" "osaka_vault" {
  provider = aws.osaka
  name     = var.backup_input["backup_aurora_os_vault"]
  # name     = "aurora-backup-vault-osaka"
}
