#!bin/bash

#curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
#unzip awscliv2.zip
#y|./aws/install

#aws --version


echo iam elements creation

awslocal iam create-policy \
    --policy-name s3-dynamo-policy \
    --policy-document file:///docker-entrypoint-initaws.d/policies/s3-dynamo-policy.json
    
awslocal iam create-role \
    --role-name lambda-role \
    --permissions-boundary arn:aws:iam::000000000000:policy/s3-dynamo-policy \
    --assume-role-policy-document file:///docker-entrypoint-initaws.d/roles/lambda-execution-role.json

echo s3 elements creation

awslocal s3api create-bucket --bucket bucket-lambda-execution

echo dynamodb elements creation

# error An error occurred (ValidationException) when calling the CreateTable operation: No provisioned throughput specified for the table

awslocal dynamodb create-table \
    --table-name s3-document-names \
    --attribute-definitions AttributeName=DocumentName,AttributeType=S \
    --key-schema AttributeName=DocumentName,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5

echo lambda elements create

# why this configuration doesn't work? it's because of the order?
#awslocal lambda create-function \
#    --function-name s3-lambda-triggered \
#    --runtime python3.9 \
#    --role arn:aws:iam::000000000000:role/lambda-role \ 
#    --handler lambda-function.lambda_handler \
#    --zip-file fileb:///docker-entrypoint-initaws.d/lambda-function.zip

awslocal lambda create-function \
    --function-name s3-lambda-triggered \
    --role arn:aws:iam::000000000000:role/lambda-role \
    --runtime python3.9 \
    --zip-file fileb:///docker-entrypoint-initaws.d/lambda-function.zip \
    --handler lambda-function.lambda_handler

echo trigger elements create

awslocal s3api put-bucket-notification-configuration \
    --bucket bucket-lambda-execution \
    --notification-configuration file:///docker-entrypoint-initaws.d/triggers/trigger-config.json

#awslocal lambda create-event-source-mapping \
#    --function-name bucket-trigger \
#    --enabled true \


# missing:
# - create the bucket
# - create the lambda
# - create the trigger
# - create the table

awslocal s3 mb s3://test-localstack-bucket
awslocal s3 ls