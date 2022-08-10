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

        if not body["reply_to"]:
            fields = "(author_id, post_id, text)"
            values = (body["author_id"], body["post_id"], body["text"])
        else:
            fields = "(author_id, post_id, text, reply_to)"
            values = (body["author_id"], body["post_id"], body["text"],
                      body["reply_to"])

        query = (f"INSERT INTO {PostgresTable.COMMENT.value} {fields} VALUES "
                 f"{values} RETURNING id")

        postgres.execute(query=query)
        comment_id = postgres.cursor.fetchone()[0]

        postgres.commit_changes()

        response = {
            "message": "Đã tạo bình luận",
            "data": {
                "comment_id": comment_id,
            }
        }
        
        return get_gateway_response(StatusCode.SUCCESS.value, 
                                    json.dumps(response))
    except Exception as err:
        logger.error(f"Exception: {str(err)}")

        response = {
            "message": "Tạo bình luận không thành công",
            "data": {}
        }
        return get_gateway_response(StatusCode.INTERNAL_ERROR.value, 
                                    json.dumps(response))
