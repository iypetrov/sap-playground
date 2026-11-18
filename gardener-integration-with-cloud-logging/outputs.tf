output "cloud_logging_credentials" {
  value     = btp_subaccount_service_binding.cloud_logging.credentials
  sensitive = true
}
