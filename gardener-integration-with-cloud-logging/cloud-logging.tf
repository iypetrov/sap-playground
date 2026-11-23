locals {
  name = "cloud-logging"
}

data "btp_subaccount_service_plan" "cloud_logging" {
  name          = "standard"
  subaccount_id = var.btp_subaccount
  offering_name = "cloud-logging"
}

resource "btp_subaccount_service_instance" "cloud_logging" {
  name           = local.name
  subaccount_id  = var.btp_subaccount
  serviceplan_id = data.btp_subaccount_service_plan.cloud_logging.id
  parameters = jsonencode({
    ingest_otlp = {
      enabled = true
    }
  })
}

resource "btp_subaccount_service_binding" "cloud_logging" {
  name                = "${local.name}-binding"
  subaccount_id       = var.btp_subaccount
  service_instance_id = btp_subaccount_service_instance.cloud_logging.id
}
