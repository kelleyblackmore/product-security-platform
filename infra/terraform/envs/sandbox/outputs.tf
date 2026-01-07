output "cloudtrail_arn" {
  value = module.baseline.cloudtrail_arn
}

output "config_recorder" {
  value = module.baseline.config_recorder_name
}
