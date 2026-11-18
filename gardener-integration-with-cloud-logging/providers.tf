provider "btp" {
  globalaccount  = var.btp_globalaccount
  cli_server_url = var.btp_cli_server_url
  username       = var.btp_username
  password       = var.btp_password
}
