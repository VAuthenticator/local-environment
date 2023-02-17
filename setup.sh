#!/bin/bash

export AWS_REGION=us-east-1
export AWS_ACCESS_KEY_ID=xxxxx
export AWS_SECRET_ACCESS_KEY=xxxxx

chown -R  $USER *
chmod 775 -R docker/dynamodb

VAUTHENTICATOR_BUCKET=vauthenticator-bucket
TEMPLATES=("welcome.html" "mail-verify-challenge.html" "reset-password.html" "successful-mail-verify.html" "mfa-challenge.html")


aws s3api create-bucket --bucket "$VAUTHENTICATOR_BUCKET" --endpoint http://localhost:4566 --region us-east-1 2>&1 > /dev/null

cd configuration/templates
for TEMPLATE in ${TEMPLATES[@]}
do
  aws s3 cp $TEMPLATE s3://$VAUTHENTICATOR_BUCKET/mail/templates/$TEMPLATE --endpoint http://localhost:4566 --region us-east-1
done