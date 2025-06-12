#!/bin/bash

cd backend/lambda_functions || exit
zip -r ../lambda_deploy.zip .

cd ../..

# Thông tin cấu hình Lambda
FUNCTION_NAME="CloudTrailSecurityMonitor"
ROLE_ARN="arn:aws:iam::369683261967:role/lambda_basic_execution_with_sns"
SNS_TOPIC_ARN="arn:aws:sns:ap-southeast-1:369683261967:cloud-security-alerts:edf3baae-eaaf-44a5-be24-1274aeda1b8b"
RUNTIME="python3.9"
HANDLER="process_cloudtrail.lambda_handler"

# Kiểm tra Lambda function 
aws lambda get-function --function-name $FUNCTION_NAME >/dev/null 2>&1

if [ $? -eq 0 ]; then
  echo "Updating existing Lambda function..."
  aws lambda update-function-code --function-name $FUNCTION_NAME --zip-file fileb://backend/lambda_deploy.zip
  aws lambda update-function-configuration --function-name $FUNCTION_NAME --environment Variables="{SNS_TOPIC_ARN=$SNS_TOPIC_ARN}"
else
  echo "Creating new Lambda function..."
  aws lambda create-function --function-name $FUNCTION_NAME \
    --runtime $RUNTIME --role $ROLE_ARN --handler $HANDLER \
    --zip-file fileb://backend/lambda_deploy.zip \
    --environment Variables="{\"SNS_TOPIC_ARN\":\"$SNS_TOPIC_ARN\"}"
fi

echo "Deployment complete."
