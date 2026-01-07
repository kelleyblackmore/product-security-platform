provider "aws" {
  region = var.aws_region
}

module "baseline" {
  source               = "../../modules/aws-account-baseline"
  trail_name           = "psp-org-trail"
  cloudtrail_bucket    = var.cloudtrail_bucket
  config_recorder_name = "psp-config"
  config_channel_name  = "psp-config-channel"
  config_bucket        = var.config_bucket
  config_role_arn      = var.config_role_arn
}
