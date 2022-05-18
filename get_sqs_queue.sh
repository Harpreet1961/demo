#!/bin/bash -x


export AWS_DEFAULT_REGION="us-east-1"
export AWS_ACCOUNT="080482353272"
export SQS_QUEUE="customer-alert-notification-stagging customer-alert-notification-dev"
export ENVIRONMENT ="Staging"

if [[ ${ENVIRONMENT} == "Staging" ]]; then
export AWS_SECRET_ACCESS_KEY=$(aws secretsmanager get-secret-value --secret-id STAGING_AWS_SECRET_ACCESS_KEY --query SecretString --output text | jq -r .STAGING_AWS_SECRET_ACCESS_KEY)
export AWS_ACCESS_KEY_ID=$(aws secretsmanager get-secret-value --secret-id STAGING_AWS_ACCESS_KEY_ID --query SecretString --output text | jq -r .STAGING_AWS_ACCESS_KEY_ID)
else
export AWS_SECRET_ACCESS_KEY=$(aws secretsmanager get-secret-value --secret-id AWS_SECRET_ACCESS_KEY --query SecretString --output text | jq -r .AWS_SECRET_ACCESS_KEY)
export AWS_ACCESS_KEY_ID=$(aws secretsmanager get-secret-value --secret-id AWS_ACCESS_KEY_ID --query SecretString --output text | jq -r .AWS_ACCESS_KEY_ID)
fi

for sqs in $SQS_QUEUE;
do

export QUEUE_COUNT=$(aws sqs get-queue-attributes --queue-url https://sqs.$AWS_DEFAULT_REGION.amazonaws.com/$AWS_ACCOUNT/$sqs--attribute-names ApproximateNumberOfMessages|grep 'ApproximateNumberOfMessages'|awk -F ':' '{print $2}'|sed 's/"//g')

if [ $QUEUE_COUNT == 0 ];then
        echo "INFO"
else
        echo "CRITICAL"
fi

done
