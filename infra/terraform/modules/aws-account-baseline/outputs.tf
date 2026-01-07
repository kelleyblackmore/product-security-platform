output "cloudtrail_arn" {
  value = aws_cloudtrail.org_trail.arn
}

output "config_recorder_name" {
  value = aws_config_configuration_recorder.this.name
}
