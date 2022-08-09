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
        type = event["queryStringParameters"]["type"]
        body = json.loads(event["body"])

        post_fields = ("author_id", "channel_id", "type")
        post_values = [(body["author_id"], body["channel_id"], type)]

        post_id = postgres.insert_item(PostgresTable.POST.value, post_fields, 
                                       post_values)

        if type == PostType.TEXT.value:
            text_fields = ("post_id", "title", "text")
            text_values = [(post_id, body["title"] ,body["text"])]

            postgres.insert_item(PostgresTable.POST_TEXT.value, text_fields, 
                                text_values)
        elif type == PostType.SURVEY.value:
            survey_fields = ("post_id", "name", "description", "url")
            survey_values = [(post_id, body["name"], body["description"], body["url"])]

            postgres.insert_item(PostgresTable.POST_SURVEY.value, survey_fields, 
                                survey_values)
        elif type == PostType.PETITION.value:
            survey_fields = ("post_id", "name", "description")
            survey_values = [(post_id, body["name"], body["description"])]

            postgres.insert_item(PostgresTable.POST_PETITION.value, 
                                 survey_fields, survey_values)
        else:
            logger.debug("Invalid post type")
            return get_gateway_response(sc.BAD_REQUEST.value, "Invalid post type")
        
        image_fields = ("post_id", "img_url")
        image_values = [(post_id, url) for url in body["img_url"]]

        postgres.insert_item(PostgresTable.POST_IMAGE.value, image_fields, image_values)
        
        return get_gateway_response(sc.SUCCESS.value, 
                                        "Create new post successfully")
    except Exception as err:
        return get_gateway_response(sc.INTERNAL_ERROR.value, "Create post failed")
