data "btp_subaccount_user" "this" {
  subaccount_id = var.btp_subaccount
  user_name     = var.btp_username
}
