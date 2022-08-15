import json

import boto3

client=boto3.client('rekognition')

def lambda_handler(event, context):
    face_id = event["queryStringParameters"]["id"]

    response = client.detect_text(
        Image = {
            "S3Object": {
                "Bucket": "faceid65548-staging",
                "Name": f"public/{face_id}"
            }
        }
    )
                        
    text_detections = response['TextDetections']
    
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
                "data": {}
            })
        }

    return {
        "statusCode": 200,
        "body": json.dumps({
            "message": "Nhận dạng thành công.",
            "data": {
                "citizen_id": citizen_id
            }
        })
    }

    
