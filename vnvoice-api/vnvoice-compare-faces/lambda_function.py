import boto3


from vnvoice.util import get_logger
from vnvoice.enums import StatusCode

logger = get_logger(__name__)
client = boto3.client('rekognition')

def lambda_handler(event, context):
    citizenId = event["queryStringParameters"]["id"]

    response = client.compare_faces(
        SimilarityThreshold=80,
        SourceImage={
            "S3Object": { 
                "Bucket": "vnvoice-data",
                "Name": f"face_id/{citizenId}"
            }
        },
        TargetImage={
            "S3Object": { 
                "Bucket": "faceid65548-staging",
                "Name": f"public/faceIdAuthen/f{citizenId}"
            }
        }
    )

    logger.debug(response)
    
    if len(response["FaceMatches"]) > 0:
        logger.debug("Have a face match")
        
        if response["FaceMatches"][0]["Similarity"] > 90.0:
            return {
                "statusCode": StatusCode.SUCCESS.value,
                "body": "Face Match"
            }
            
        return {
                "statusCode": StatusCode.BAD_REQUEST.value,
                "body": "Please try again"
            }
    
    return {
        "statusCode": StatusCode.NOT_FOUND.value,
        "body": "Not match"
    }