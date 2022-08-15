import json

from vnvoice.db.postgres.connector import PostgresConnector
from vnvoice.db.postgres.enums import PostgresTable
from vnvoice.enums import PostType
from vnvoice.enums import StatusCode as sc
from vnvoice.util import (get_gateway_response, get_logger)

logger = get_logger(__name__)
postgres = PostgresConnector()

def lambda_handler(event, context):
    try:
        post_type = event["queryStringParameters"]["type"]
        body = json.loads(event["body"])

        post_fields = "(author_id, channel_id, type)"
        post_values = (body["author_id"], body["channel_id"], post_type)

        query = (f"INSERT INTO {PostgresTable.POST.value} {post_fields} VALUES "
                 f"{post_values} RETURNING id") 

        postgres.execute(query=query)
        post_id = postgres.cursor.fetchone()[0]

        postgres.commit_changes()

        if post_type == PostType.TEXT.value:
            detail_fields = "(post_id, title, text)"
            detail_values = (post_id, body["title"] ,body["text"])
            post_table = PostgresTable.POST_TEXT.value

            image_fields = "(post_id, img_url)"
            images = [(post_id, url) for url in body["img_url"]]
            image_values = str(images).strip('[]')

            query = (f"INSERT INTO {PostgresTable.POST_IMAGE.value} {image_fields} VALUES {image_values}")

            postgres.execute(query=query)
            postgres.commit_changes()
        elif post_type == PostType.SURVEY.value:
            detail_fields = "(post_id, name, description, url)"
            detail_values = (post_id, body["name"], body["description"], body["url"])
            post_table = PostgresTable.POST_SURVEY.value
        elif post_type == PostType.PETITION.value:
            detail_fields = "(post_id, name, description)"
            detail_values = (post_id, body["name"], body["description"])
            post_table = PostgresTable.POST_PETITION.value
        else:
            logger.debug("Invalid post type")

            response = {
                "message": "Loại bài đăng không hợp lệ",
                "data": {}
            }
            return get_gateway_response(sc.BAD_REQUEST.value, 
                                        json.dumps(response))

        query = (f"INSERT INTO {post_table} {detail_fields} VALUES {detail_values}")

        postgres.execute(query=query)
        postgres.commit_changes()

        response = {
            "message": "Tạo bài đăng thành công",
            "data": {
                "post_id": post_id
            }
        }
        
        return get_gateway_response(sc.SUCCESS.value, 
                                    json.dumps(response))
    except Exception as err:
        logger.debug(f"Exception: {str(err)}")

        response = {
            "message": "Tạo bài đăng không thành công. Vui lòng thử lại sau.",
            "data": {}
        }
        return get_gateway_response(sc.INTERNAL_ERROR.value, json.dumps(response))
