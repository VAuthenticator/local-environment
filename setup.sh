VAUTHENTICATOR_BUCKET="vauthenticator"
TEMPLATES=("welcome.html" "mail-verify-challenge.html" "reset-password.html" "successful-mail-verify.html" "mfa-challenge.html")

export AWS_ACCESS_KEY_ID=xxx
export AWS_SECRET_ACCESS_KEY=xxx
export AWS_DEFAULT_REGION=us-east-1

export DYNAMO_DB_ENDPOINT=http://localhost:4566
export KMS_ENDPOINT=http://localhost:8000

rm -rf tenant-installer

sudo chown -R  $USER *
chmod 775 -R docker/dynamodb

git clone https://github.com/VAuthenticator/tenant-installer.git
cd tenant-installer/terraform/resources

cat ../../../terraform-ovverrides/terraform.tf > terraform.tf
cat ../../../terraform-ovverrides/s3.tf > s3.tf
aws s3api create-bucket --bucket $VAUTHENTICATOR_BUCKET --endpoint http://localhost:4566 2>&1 > ../../../s3.logs

terraform init
terraform plan -var-file=../../../terraform-ovverrides/variables.tfvars
terraform apply -var-file=../../../terraform-ovverrides/variables.tfvars -auto-approve

terraform state show  'module.kms.aws_kms_key.this[0]' | grep key_id | awk  '{print $3}' | sed  s/\"//g  > ../../../kms.logs
MASTER_KEY=$(cat ../../../kms.logs)

cd ../../document/template/mail
for TEMPLATE in ${TEMPLATES[@]}
do
  aws s3 cp $TEMPLATE s3://$VAUTHENTICATOR_BUCKET/mail/templates/$TEMPLATE --endpoint http://localhost:4566
done


cd ../../../scripts
pip3 install -r requirements.txt
python3 setup.py admin@email.com $MASTER_KEY  VAuthenticator_Signature_Keys_Local_Staging  VAuthenticator_Role_Local_Staging VAuthenticator_Account_Local_Staging  VAuthenticator_Account_Role_Local_Staging VAuthenticator_ClientApplication_Local_Staging