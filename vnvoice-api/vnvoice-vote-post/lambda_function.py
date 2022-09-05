import json

from vnvoice.db.postgres.connector import PostgresConnector
from vnvoice.db.postgres.enums import PostgresTable as pgt
from vnvoice.enums import StatusCode
from vnvoice.util import get_gateway_response, get_logger

logger = get_logger(__name__)
postgres = PostgresConnector()

def lambda_handler(event, context):
    try:
        post_id = event["queryStringParameters"]["id"]
        type = event["queryStringParameters"]["type"]

        if type == "upvote":
            query = (f"UPDATE {pgt.POST.value} SET upvotes = upvotes + 1, "
                     f"has_liked = true WHERE id = '{post_id}'")
        elif type == "downvote":
            query = (f"UPDATE {pgt.POST.value} SET downvotes = downvotes + 1, "
                     f"has_liked = false WHERE id = '{post_id}'")
        else:
            logger.debug("Invalid action type")
            response = {
                "message": "Action type không hợp lệ",
                "data": {}
            }
            return get_gateway_response(StatusCode.BAD_REQUEST.value, 
                                        json.dumps(response))

        postgres.execute(query=query)
        postgres.commit_changes()

        response = {
            "message": "Thành công",
            "data": {}
        }

        return get_gateway_response(StatusCode.SUCCESS.value, json.dumps(response))

    except Exception as err:
        logger.error(f"Exception: {str(err)}")

        response = {
            "message": "Hệ thống đang xảy ra lỗi. Vui lòng thử lại sau",
            "data": {}
        }
        return get_gateway_response(StatusCode.INTERNAL_ERROR.value, 
                                    json.dumps(response))
