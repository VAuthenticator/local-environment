rm -rf tenant-installer

sudo chown -R  $USER *
chmod 775 -R docker/dynamodb

git clone https://github.com/VAuthenticator/tenant-installer.git
cd tenant-installer/terraform/resources

cat ../../../terraform-ovverrides/terraform.tf > terraform.tf
cat ../../../terraform-ovverrides/s3.tf > s3.tf
aws s3api create-bucket --bucket vauthenticator --endpoint http://localhost:4566 --region us-east-1  2>&1 > s3.logs

terraform init
terraform plan -var-file=../../../terraform-ovverrides/variables.tfvars
terraform apply -var-file=../../../terraform-ovverrides/variables.tfvars -auto-approve