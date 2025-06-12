import boto3
import json
import os

SNS_TOPIC_ARN = os.environ.get('SNS_TOPIC_ARN', 'arn:aws:sns:ap-southeast-1:369683261967:cloud-security-alerts')

def lambda_handler(event, context):
    sns_client = boto3.client('sns')
    alert_events = []

    for record in event.get('Records', []):
        message = record.get('Sns', {}).get('Message', '')
        if 'ConsoleLogin' in message and 'Failed' in message:
            alert_events.append(message)

    if alert_events:
        alert_text = f"Cảnh báo đăng nhập thất bại AWS:\n\n" + "\n\n".join(alert_events)
        sns_client.publish(
            TopicArn=SNS_TOPIC_ARN,
            Subject='AWS CloudTrail Security Alert',
            Message=alert_text
        )
        print("Sent alert.")
    else:
        print("No suspicious events found.")

    return {
        'statusCode': 200,
        'body': json.dumps('Processing done')
    }
