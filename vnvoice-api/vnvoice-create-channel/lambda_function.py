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
        fields = "(name, creator_id)"
        values = (body["name"], body["creator_id"])
        returned_fields = "id, name, creator_id, status, created_date"

        query = (f"INSERT INTO {PostgresTable.CHANNEL.value} {fields} VALUES "
                 f"{values} RETURNING id")

        postgres.execute(query=query)
        channel_id = postgres.cursor.fetchone()[0]

        postgres.commit_changes()

        response = {
            "message": "Tạo channel thành công",
            "data": {
                "channel_id": channel_id,
            }
        }
        
        return get_gateway_response(StatusCode.SUCCESS.value, 
                                    json.dumps(response))
    except Exception as err:
        logger.error(f"Exception: {str(err)}")

        response = {
            "message": "Tạo channel không thành công",
            "data": {}
        }
        return get_gateway_response(StatusCode.INTERNAL_ERROR.value, 
                                    json.dumps(response))
