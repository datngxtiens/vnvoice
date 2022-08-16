import json

from vnvoice.util import get_logger
import boto3


logger = get_logger(__name__)
client=boto3.client('rekognition')

def lambda_handler(event, context):
    file = event["queryStringParameters"]["file"]

    response = client.detect_text(
        Image = {
            "S3Object": {
                "Bucket": "faceid65548-staging",
                "Name": f"public/cardId/{file}_front"
            }
        }
    )
                        
    text_detections = response['TextDetections']
    
    logger.debug(f"Dectection: {text_detections}")
    
    citizen_id = None
    
    for text in text_detections:
        if text["Type"] == "LINE": 
            line = text["DetectedText"]
            if line.isdigit() and len(line) == 12:
                citizen_id = line
                
    if not citizen_id:
        return {
            "statusCode": 404,
            "body": json.dumps({
                "message": "Hệ thống không thể nhận dạng. Vui lòng thử lại.",
                "citizen_id": ""
            })
        }

    return {
        "statusCode": 200,
        "body": json.dumps({
            "message": "Nhận dạng thành công.",
            "citizen_id": citizen_id
        })
    }