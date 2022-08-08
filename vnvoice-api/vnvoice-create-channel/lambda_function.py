import json

from vnvoice.db.dynamo.connector import DynamoConnector
from vnvoice.db.dynamo.enums import DefaultValue as dv
from vnvoice.db.dynamo.enums import DynamoTable as dyt
from vnvoice.enums import StatusCode as sc
from vnvoice.util import generate_id, get_current_date, get_logger

logger = get_logger(__name__)
dynamo_connector = DynamoConnector()

def lambda_handler(event, context):
    body = json.loads(event["body"])
    body["status"] = dv.STATUS.value
    body["created_date"] = str(get_current_date())
    body["id"] = str(generate_id())
    body["reported_times"] = dv.REPORTED_TIMES.value

    (code, msg) = dynamo_connector.put_item(dyt.CHANNEL.value, body)
    
    if code is None:
        return {
            "statusCode": sc.SUCCESS.value,
            "body": "Create new channel successfully"
        }
    return {
            "statusCode": sc.INTERNAL_ERROR.value,
            "body": msg
        }
