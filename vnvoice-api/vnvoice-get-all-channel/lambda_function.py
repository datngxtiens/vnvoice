import json

from vnvoice.db.postgres.connector import PostgresConnector
from vnvoice.enums import StatusCode
from vnvoice.util import get_gateway_response, get_logger

logger = get_logger(__name__)
postgres = PostgresConnector()

def lambda_handler(event, context):
    try:
        channels = []

        query = ("SELECT id, creator_id, name, status FROM channel")

        postgres.execute(query=query)

        for row in postgres.cursor.fetchall():
            (cid, crid, cname, cstatus) = row
            channel = {
                "channel_id": cid,
                "creator_id": crid,
                "channel_name": cname,
                "channel_status": cstatus
            }
            channels.append(channel)
        
        response = {
            "message": "Lấy danh sách kênh thành công",
            "data": channels
        }

        return get_gateway_response(StatusCode.SUCCESS.value, json.dumps(response))

    except Exception as err:
        logger.error(f"Exception: {str(err)}")

        response = {
            "message": "Lấy danh sách kênh không thành công",
            "data": {}
        }
        return get_gateway_response(StatusCode.INTERNAL_ERROR.value, 
                                    json.dumps(response))
