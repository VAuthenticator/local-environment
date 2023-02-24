VAUTHENTICATOR_BUCKET="vauthenticator"
TEMPLATES=("welcome.html" "mail-verify-challenge.html" "reset-password.html" "successful-mail-verify.html" "mfa-challenge.html")

rm -rf tenant-installer

sudo chown -R  $USER *
chmod 775 -R docker/dynamodb

git clone https://github.com/VAuthenticator/tenant-installer.git
cd tenant-installer/terraform/resources

cat ../../../terraform-ovverrides/terraform.tf > terraform.tf
cat ../../../terraform-ovverrides/s3.tf > s3.tf
aws s3api create-bucket --bucket $VAUTHENTICATOR_BUCKET --endpoint http://localhost:4566 --region us-east-1  2>&1 > ../../../s3.logs

terraform init
terraform plan -var-file=../../../terraform-ovverrides/variables.tfvars
terraform apply -var-file=../../../terraform-ovverrides/variables.tfvars -auto-approve

terraform state show  'module.kms.aws_kms_key.this[0]' | grep key_id | awk  '{print $3}' > ../../../kms.logs

cd ../../document/template/mail
for TEMPLATE in ${TEMPLATES[@]}
do
  aws s3 cp $TEMPLATE s3://$VAUTHENTICATOR_BUCKET/mail/templates/$TEMPLATE --endpoint http://localhost:4566 --region us-east-1
done

cd ../../../scripts
python setup.py admin@email.com