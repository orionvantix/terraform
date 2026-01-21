#! /bin/bash

rm -rf .tfstate*

ENV=$1

if [ -z "$ENV" ]; then
    echo "Usage: $0 <env>"
    exit1
fi

sed -i '' "s/_env_/$ENV/g" backend.tf

echo "Environment is set to $ENV"

terraform init -reconfigure
terraform destroy -var-file=$ENV.tfvars --auto-approve

sed -i '' "s/$ENV/_env_/g" backend.tf

echo "Infra is deployed to $ENV and backend.tf is rolled back"