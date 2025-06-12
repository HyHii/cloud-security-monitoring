# Cloud Security Monitoring System

## Project Description

This project implements a cloud security monitoring system on AWS that automatically detects failed login events via CloudTrail and sends immediate alerts through SNS (email or Slack).  
It leverages AWS Lambda for real-time event processing to enhance the security of your AWS accounts.

---

## Technologies Used

- AWS Lambda (Python 3.9)  
- AWS SNS (Simple Notification Service)  
- AWS CloudTrail & CloudWatch Event Rules  
- Python (boto3)  
- AWS CLI for Lambda deployment  
- PowerShell / Bash for deployment automation

`````
## Project Structure
cloud-security-monitoring/
├── backend/
│ ├── lambda_functions/
│ │ └── process_cloudtrail.py
│ ├── deploy_lambda.sh
│ ├── requirements.txt
│ └── lambda_deploy.zip
├── docs/
├── tests/
│ └── test_lambda.py
├── .gitignore
├── README.md
└── env.json
`````

## Deployment Instructions

1. Install and configure AWS CLI:

```bash
aws configure
```

2. Prepare the Lambda package:
   Using PowerShell:
```bash
Compress-Archive -Path backend/lambda_functions/* -DestinationPath backend/lambda_deploy.zip -Force
```

3. Create or update the Lambda function:
   Run the AWS CLI command (replace your Role ARN and SNS Topic ARN accordingly):
```bash
aws lambda create-function --function-name CloudTrailSecurityMonitor --runtime python3.9 --role arn:aws:iam::<ACCOUNT_ID>:role/<LAMBDA_ROLE> --handler process_cloudtrail.lambda_handler --zip-file fileb://backend/lambda_deploy.zip --environment file://env.json
```
or
```bash
aws lambda update-function-code --function-name CloudTrailSecurityMonitor --zip-file fileb://backend/lambda_deploy.zip
aws lambda update-function-configuration --function-name CloudTrailSecurityMonitor --e
```

4. Create a CloudWatch Event Rule to trigger the Lambda function on failed login events.

## Testing Instructions
Create a test event in AWS Lambda Console with the following payload:
```json
{
  "Records": [
    {
      "Sns": {
        "Message": "ConsoleLogin Failed for user test-user"
      }
    }
  ]
}
```
Run the test and check the Lambda logs and verify that alert notifications are received via email or Slack.

## License



