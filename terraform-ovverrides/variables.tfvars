# tags variables
common_resource_tags = {}

# dynamodb variables
client_application_table_name  = "VAuthenticator_ClientApplication_Local_Staging"
role_table_name                = "VAuthenticator_Role_Local_Staging"
account_table_name             = "VAuthenticator_Account_Local_Staging"
account_role_table_name        = "VAuthenticator_Account_Role_Local_Staging"
ticket_table_name              = "VAuthenticator_Ticket_Local_Staging"
mfa_keys_table_name            = "VAuthenticator_Mfa_Keys_Local_Staging"
signature_keys_table_name      = "VAuthenticator_Signature_Keys_Local_Staging"
mfa_account_methods_table_name = "VAuthenticator_Mfa_Account_Methods_Local_Staging"

# s3 variables
document_s3_bucket_name = "vauthenticator"

# kms variables
key_name                      = "master_key"
key_administrator_account_ids = []

key_user_account_ids = []

key_alias               = "vauthenticator-key"
key_description         = "vauthenticator-key"
deletion_window_in_days = 7
