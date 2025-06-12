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

---
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
---

## Deployment Instructions

1. Install and configure AWS CLI:

```bash
aws configure
Compress-Archive -Path backend/lambda_functions/* -DestinationPath backend/lambda_deploy.zip -Force
```
