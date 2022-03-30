#!bin/bash

echo iam elements creation

#pwd

awslocal iam create-policy --policy-name s3-dynamo-policy --policy-document file:///docker-entrypoint-initaws.d/policies/s3-dynamo-policy.json
awslocal iam create-role --role-name lambda-role --permissions-boundary arn:aws:iam::000000000000:policy/s3-dynamo-policy --assume-role-policy-document file:///docker-entrypoint-initaws.d/roles/lambda-execution-role.json

# missing:
# - create the bucket
# - create the lambda
# - create the trigger
# - create the table

awslocal s3 mb s3://test-localstack-bucket
awslocal s3 ls