import json

from vnvoice.db.postgres.connector import PostgresConnector
from vnvoice.db.postgres.enums import PostgresTable
from vnvoice.enums import StatusCode
from vnvoice.util import get_gateway_response, get_logger

logger = get_logger(__name__)
postgres = PostgresConnector()

def lambda_handler(event, context):
    try:
        body = json.loads(event["body"])
        fields = ("name", "creator_id")
        values = [(body["name"], body["creator_id"])]

        postgres.insert_item(PostgresTable.CHANNEL.value, fields, values)
        
        return get_gateway_response(StatusCode.SUCCESS.value, 
                                    "Create new channel successfully")
    except Exception as err:
        logger.error(f"Exception: {str(err)}")
        return get_gateway_response(StatusCode.INTERNAL_ERROR.value, 
                                    "Cannot create channel")
