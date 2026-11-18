output "cloud_logging_plans" {
  value = data.btp_subaccount_service_plans.cloud_logging.values[*].name
}

output "cloud_logging_credentials" {
  value     = btp_subaccount_service_binding.cloud_logging.credentials
  sensitive = true
}
