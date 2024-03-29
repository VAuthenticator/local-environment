function copy_tf_variables() {
  echo $ACCOUNT_ID
  sed 's/ACCOUNT_ID/'$ACCOUNT_ID'/g' ../../../terraform-ovverrides/variables.tfvars | sed 's/VAUTHENTICATOR_BUCKET/'$VAUTHENTICATOR_BUCKET'/g'  > variables.tfvars
}

rm -rf tenant-installer
source .env

TEMPLATES=("welcome.html" "mail-verify-challenge.html" "reset-password.html" "successful-mail-verify.html" "mfa-challenge.html")

cd tenant-installer/terraform/

# IAM
cd iam
copy_tf_variables

terraform init -backend-config="bucket=$TF_STATE_BUCKET" -backend-config="region=$AWS_REGION"
terraform plan -var-file=./variables.tfvars
terraform apply --auto-approve -var-file=variables.tfvars

cd ../resources
copy_tf_variables

terraform init -backend-config="bucket=$TF_STATE_BUCKET" -backend-config="region=$AWS_REGION"
terraform plan -var-file=variables.tfvars
terraform apply -var-file=variables.tfvars -auto-approve

cd ../policy
copy_tf_variables

terraform init -backend-config="bucket=$TF_STATE_BUCKET" -backend-config="region=$AWS_REGION"
terraform plan -var-file=variables.tfvars
terraform apply -var-file=variables.tfvars -auto-approve


cd ../document/template/mail
for TEMPLATE in ${TEMPLATES[@]}
do
  aws s3 cp $TEMPLATE s3://$VAUTHENTICATOR_BUCKET/mail/templates/$TEMPLATE
done