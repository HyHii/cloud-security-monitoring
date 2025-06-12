import sys
import os

sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..', 'backend', 'lambda_functions')))

from process_cloudtrail import lambda_handler

def test_lambda():
    event = {
        "Records": [
            {
                "Sns": {
                    "Message": "ConsoleLogin Failed for user test-user"
                }
            }
        ]
    }
    result = lambda_handler(event, None)
    print("Lambda handler returned:", result)

if __name__ == "__main__":
    test_lambda()
