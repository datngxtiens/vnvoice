import json

from vnvoice.db.postgres.connector import PostgresConnector
from vnvoice.db.postgres.enums import PostgresTable as pgt
from vnvoice.enums import StatusCode
from vnvoice.util import get_gateway_response, get_logger

logger = get_logger(__name__)
postgres = PostgresConnector()

def lambda_handler(event, context):
    try:
        channel_id = event["queryStringParameters"]["id"]

        channel_fields = "name, status, type"
        query_channel = (f"SELECT {channel_fields} FROM {pgt.CHANNEL.value} "
                         f"WHERE id = '{channel_id}'")

        postgres.execute(query=query_channel)
        (channel_name, channel_status, channel_type) = postgres.cursor.fetchone()

        channel_post = {
            "channel_id": channel_id,
            "channel_name": channel_name,
            "channel_status": channel_status,
            "channel_type": channel_type,
            "post_text": [],
            "post_survey": [],
            "post_petition": []
        }

        if channel_type == "Interactive":
            query_text = (f"SELECT post.id as post_id, post.author_id, account.username, "
                          f"post.status, post_text.title, post_text.text "
                          f"FROM {pgt.POST.value} JOIN {pgt.POST_TEXT.value} "
                          f"ON {pgt.POST.value}.id = {pgt.POST_TEXT.value}.post_id "
                          f"JOIN {pgt.ACCOUNT.value} "
                          f"ON {pgt.ACCOUNT.value}.id = {pgt.POST.value}.author_id "
                          f"WHERE {pgt.POST.value}.channel_id = '{channel_id}' "
                          f"AND {pgt.POST.value}.type = 'text'")

            query_petition = (f"SELECT post.id as post_id, post.author_id, account.username, "
                              f"post.status, post_petition.description, "
                              f"post_petition.name, post_petition.total_signature "
                              f"FROM {pgt.POST.value} JOIN {pgt.POST_PETITION.value} "
                              f"ON {pgt.POST.value}.id = {pgt.POST_PETITION.value}.post_id "
                              f"JOIN {pgt.ACCOUNT.value} "
                              f"ON {pgt.ACCOUNT.value}.id = {pgt.POST.value}.author_id "
                              f"WHERE {pgt.POST.value}.channel_id = '{channel_id}' "
                              f"AND {pgt.POST.value}.type = 'petition'")

            postgres.execute(query=query_text)
            for row in postgres.cursor.fetchall():
                (post_id, author_id, username, status, title, text) = row
                post = {
                    "post_id": post_id,
                    "author_id": author_id,
                    "username": username,
                    "status": status,
                    "title": title,
                    "text": text,
                }

                img_query = (f"SELECT img_url FROM {pgt.POST_IMAGE.value} "
                             f"WHERE post_id = '{post_id}'")
                postgres.execute(query=img_query)
                
                post["images"] = [img[0] for img in postgres.cursor.fetchall()]

                channel_post["post_text"].append(post)

            postgres.execute(query=query_petition)
            for row in postgres.cursor.fetchall():
                (post_id, author_id, username, status, description, name, total_signature) = row
                post = {
                    "post_id": post_id,
                    "author_id": author_id,
                    "username": username,
                    "status": status,
                    "name": name,
                    "description": description,
                    "total_signature": total_signature
                }
                channel_post["post_petition"].append(post)
        elif channel_type=="Read-only":
            query_survey = (f"SELECT post.id as post_id, post.author_id, account.username, "
                            f"post.status, post_petition.description, "
                            f"post_petition.name, post_petition.url "
                            f"FROM {pgt.POST.value} JOIN {pgt.POST_SURVEY.value} "
                            f"ON {pgt.POST.value}.id = {pgt.POST_SURVEY.value}.post_id "
                            f"JOIN {pgt.ACCOUNT.value} "
                            f"ON {pgt.ACCOUNT.value}.id = {pgt.POST.value}.author_id "
                            f"WHERE {pgt.POST.value}.channel_id = '{channel_id}' "
                            f"AND {pgt.POST.value}.type = 'survey'")

            postgres.execute(query=query_survey)
            for row in postgres.cursor.fetchall():
                (post_id, author_id, username, status, description, name, url) = row
                post = {
                    "post_id": post_id,
                    "author_id": author_id,
                    "username": username,
                    "status": status,
                    "name": name,
                    "description": description,
                    "url": url
                }
                channel_post["post_survey"].append(post)

        response = {
            "message": "Lấy danh sách bài đăng thành công",
            "data": channel_post
        }

        logger.debug("Get all post successful")
        return get_gateway_response(StatusCode.SUCCESS.value, json.dumps(response))
    except Exception as err:
        logger.error(f"Exception: {str(err)}")

        response = {
            "message": "Lấy thông tin channel không thành công",
            "data": {}
        }
        return get_gateway_response(StatusCode.INTERNAL_ERROR.value, 
                                    json.dumps(response))
