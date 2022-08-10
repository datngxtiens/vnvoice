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
                          f"post.upvotes, post.downvotes, post.status, post.type, "
                          f"post_text.title, post_text.text "
                          f"FROM {pgt.POST.value} JOIN {pgt.POST_TEXT.value} "
                          f"ON {pgt.POST.value}.id = {pgt.POST_TEXT.value}.post_id "
                          f"JOIN {pgt.ACCOUNT.value} "
                          f"ON {pgt.ACCOUNT.value}.id = {pgt.POST.value}.author_id "
                          f"WHERE {pgt.POST.value}.channel_id = '{channel_id}' "
                          f"AND {pgt.POST.value}.type = 'text'")

            query_petition = (f"SELECT post.id as post_id, post.author_id, account.username, "
                              f"post.upvotes, post.downvotes, post.status, post.type, "
                              f"post_petition.description, post_petition.name, "
                              f"post_petition.total_signature "
                              f"FROM {pgt.POST.value} JOIN {pgt.POST_PETITION.value} "
                              f"ON {pgt.POST.value}.id = {pgt.POST_PETITION.value}.post_id "
                              f"JOIN {pgt.ACCOUNT.value} "
                              f"ON {pgt.ACCOUNT.value}.id = {pgt.POST.value}.author_id "
                              f"WHERE {pgt.POST.value}.channel_id = '{channel_id}' "
                              f"AND {pgt.POST.value}.type = 'petition'")

            postgres.execute(query=query_text)
            for row in postgres.cursor.fetchall():
                (post_id, author_id, username, upvotes, downvotes, status, p_type, 
                 title, text) = row
                post = {
                    "post_id": post_id,
                    "author_id": author_id,
                    "username": username,
                    "status": status,
                    "type": p_type,
                    "title": title,
                    "text": text,
                    "upvotes": upvotes,
                    "downvotes": downvotes
                }

                img_query = (f"SELECT img_url FROM {pgt.POST_IMAGE.value} "
                             f"WHERE post_id = '{post_id}'")
                postgres.execute(query=img_query)
                
                post["images"] = [img[0] for img in postgres.cursor.fetchall()]

                comment_query = (f"SELECT COUNT({pgt.COMMENT.value}.id) "
                                 f"FROM {pgt.COMMENT.value} JOIN {pgt.POST.value} "
                                 f"ON {pgt.COMMENT.value}.post_id = {pgt.POST.value}.id "
                                 f"WHERE {pgt.POST.value}.id = '{post_id}' ")
                postgres.execute(comment_query)
                total_comment = postgres.cursor.fetchone()[0]

                post["total_comment"] = total_comment

                channel_post["post_text"].append(post)
            postgres.execute(query=query_petition)
            for row in postgres.cursor.fetchall():
                (post_id, author_id, username, status, p_type, description, name, 
                 upvotes, downvotes, total_signature) = row
                post = {
                    "post_id": post_id,
                    "author_id": author_id,
                    "username": username,
                    "status": status,
                    "type": p_type,
                    "name": name,
                    "description": description,
                    "total_signature": total_signature,
                    "upvotes": upvotes,
                    "downvotes": downvotes
                }
                
                comment_query = (f"SELECT COUNT({pgt.COMMENT.value}.id) "
                                 f"FROM {pgt.COMMENT.value} JOIN {pgt.POST.value} "
                                 f"ON {pgt.COMMENT.value}.post_id = {pgt.POST.value}.id "
                                 f"WHERE {pgt.POST.value}.id = '{post_id}' ")
                postgres.execute(comment_query)
                total_comment = postgres.cursor.fetchone()[0]

                post["total_comment"] = total_comment

                channel_post["post_petition"].append(post)
        elif channel_type=="Read-only":
            query_survey = (f"SELECT post.id as post_id, post.author_id, "
                            f"account.username, post.upvotes, post.downvotes, "
                            f"post.status, post.type, post_petition.description, "
                            f"post_petition.name, post_petition.url "
                            f"FROM {pgt.POST.value} JOIN {pgt.POST_SURVEY.value} "
                            f"ON {pgt.POST.value}.id = {pgt.POST_SURVEY.value}.post_id "
                            f"JOIN {pgt.ACCOUNT.value} "
                            f"ON {pgt.ACCOUNT.value}.id = {pgt.POST.value}.author_id "
                            f"WHERE {pgt.POST.value}.channel_id = '{channel_id}' "
                            f"AND {pgt.POST.value}.type = 'survey'")

            postgres.execute(query=query_survey)
            for row in postgres.cursor.fetchall():
                (post_id, author_id, username, upvotes, downvotes, status, p_type, 
                 description, name, url) = row
                post = {
                    "post_id": post_id,
                    "author_id": author_id,
                    "username": username,
                    "status": status,
                    "type": p_type,
                    "name": name,
                    "description": description,
                    "url": url,
                    "upvotes": upvotes,
                    "downvotes": downvotes
                }

                comment_query = (f"SELECT COUNT({pgt.COMMENT.value}.id) "
                                 f"FROM {pgt.COMMENT.value} JOIN {pgt.POST.value} "
                                 f"ON {pgt.COMMENT.value}.post_id = {pgt.POST.value}.id "
                                 f"WHERE {pgt.POST.value}.id = '{post_id}' ")
                postgres.execute(comment_query)
                total_comment = postgres.cursor.fetchone()[0]

                post["total_comment"] = total_comment

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
