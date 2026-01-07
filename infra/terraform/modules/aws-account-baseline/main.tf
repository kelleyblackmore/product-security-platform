# This module is a starter for org/account baseline patterns.
# In real deployments, these are often managed in org-level repos.

resource "aws_cloudtrail" "org_trail" {
  name                          = var.trail_name
  s3_bucket_name                = var.cloudtrail_bucket
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_logging                = true
}

resource "aws_config_configuration_recorder" "this" {
  name     = var.config_recorder_name
  role_arn  = var.config_role_arn

  recording_group {
    all_supported = true
  }
}

resource "aws_config_delivery_channel" "this" {
  name           = var.config_channel_name
  s3_bucket_name = var.config_bucket
  depends_on     = [aws_config_configuration_recorder.this]
}

resource "aws_config_configuration_recorder_status" "this" {
  name       = aws_config_configuration_recorder.this.name
  is_enabled = true
  depends_on = [aws_config_delivery_channel.this]
}
