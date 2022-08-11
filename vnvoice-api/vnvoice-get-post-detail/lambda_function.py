import json

from vnvoice.db.postgres.connector import PostgresConnector
from vnvoice.db.postgres.enums import PostgresTable as pgt
from vnvoice.enums import StatusCode
from vnvoice.util import get_gateway_response, get_logger

logger = get_logger(__name__)
postgres = PostgresConnector()

def lambda_handler(event, context):
    try:
        channel_type = event["queryStringParameters"]["type"]
        post_id = event["queryStringParameters"]["id"]

        post = {}

        if channel_type == "text":
            query_text = (f"SELECT post.id as post_id, post.author_id, account.username, "
                          f"post.upvotes, post.downvotes, post.status, "
                          f"post_text.title, post_text.text "
                          f"FROM {pgt.POST.value} JOIN {pgt.POST_TEXT.value} "
                          f"ON {pgt.POST.value}.id = {pgt.POST_TEXT.value}.post_id "
                          f"JOIN {pgt.ACCOUNT.value} "
                          f"ON {pgt.ACCOUNT.value}.id = {pgt.POST.value}.author_id "
                          f"WHERE {pgt.POST.value}.id = '{post_id}' "
                          f"AND {pgt.POST.value}.type = 'text'")
            
            postgres.execute(query=query_text)
            (post_id, author_id, username, upvotes, downvotes, status, 
             title, text) = postgres.cursor.fetchone()

            post["post_id"] = post_id
            post["author_id"] = author_id
            post["username"] = username
            post["upvotes"] = upvotes
            post["downvotes"] = downvotes
            post["status"] = status
            post["title"] = title
            post["text"] = text
            
            img_query = (f"SELECT img_url FROM {pgt.POST_IMAGE.value} "
                         f"WHERE post_id = '{post_id}'")
            postgres.execute(query=img_query)
            
            post["images"] = [img[0] for img in postgres.cursor.fetchall()]
        elif channel_type == "petition":
            query_petition = (f"SELECT post.id as post_id, post.author_id, account.username, "
                              f"post.upvotes, post.downvotes, post.status, "
                              f"post_petition.description, post_petition.name, "
                              f"post_petition.total_signature "
                              f"FROM {pgt.POST.value} JOIN {pgt.POST_PETITION.value} "
                              f"ON {pgt.POST.value}.id = {pgt.POST_PETITION.value}.post_id "
                              f"JOIN {pgt.ACCOUNT.value} "
                              f"ON {pgt.ACCOUNT.value}.id = {pgt.POST.value}.author_id "
                              f"WHERE {pgt.POST.value}.id = '{post_id}' "
                              f"AND {pgt.POST.value}.type = 'petition'")

            postgres.execute(query=query_petition)
            (post_id, author_id, username, status, description, name, upvotes,
             downvotes, total_signature) = postgres.cursor.fetchone()

            post["post_id"] = post_id
            post["author_id"] = author_id
            post["username"] = username
            post["upvotes"] = upvotes
            post["downvotes"] = downvotes
            post["status"] = status
            post["name"] = name
            post["description"] = description
            post["total_signature"] = total_signature

        elif channel_type == "survey":
            query_survey = (f"SELECT post.id as post_id, post.author_id, "
                            f"account.username, post.upvotes, post.downvotes, "
                            f"post.status, post_petition.description, "
                            f"post_petition.name, post_petition.url "
                            f"FROM {pgt.POST.value} JOIN {pgt.POST_SURVEY.value} "
                            f"ON {pgt.POST.value}.id = {pgt.POST_SURVEY.value}.post_id "
                            f"JOIN {pgt.ACCOUNT.value} "
                            f"ON {pgt.ACCOUNT.value}.id = {pgt.POST.value}.author_id "
                            f"WHERE {pgt.POST.value}.id = '{post_id}' "
                            f"AND {pgt.POST.value}.type = 'survey'")

            postgres.execute(query=query_survey)
            (post_id, author_id, username, upvotes, downvotes, status, 
             description, name, url) = postgres.cursor.fetchone()

            post["post_id"] = post_id
            post["author_id"] = author_id
            post["username"] = username
            post["upvotes"] = upvotes
            post["downvotes"] = downvotes
            post["status"] = status
            post["name"] = name
            post["description"] = description
            post["url"] = url
        
        comment_query = (f"SELECT COUNT({pgt.COMMENT.value}.id) "
                         f"FROM {pgt.COMMENT.value} JOIN {pgt.POST.value} "
                         f"ON {pgt.COMMENT.value}.post_id = {pgt.POST.value}.id "
                         f"WHERE {pgt.POST.value}.id = '{post_id}' ")
        postgres.execute(comment_query)
        total_comment = postgres.cursor.fetchone()[0]

        post["total_comment"] = total_comment

        comment_query = (f"SELECT {pgt.COMMENT.value}.author_id, "
                         f"{pgt.ACCOUNT.value}.username, {pgt.COMMENT.value}.text, "
                         f"{pgt.COMMENT.value}.reply_to "
                         f"FROM {pgt.COMMENT.value} JOIN {pgt.ACCOUNT.value} "
                         f"ON {pgt.ACCOUNT.value}.id = {pgt.COMMENT.value}.author_id "
                         f"WHERE {pgt.COMMENT.value}.post_id = '{post_id}' ")
        postgres.execute(comment_query)
        post["comments"] = []

        for row in postgres.cursor.fetchall():
            (a_id, author, txt, reply_to) = row

            comment = {
                "author_id": a_id,
                "username": author,
                "text": txt,
                "reply_to": reply_to
            }
            post["comments"].append(comment)

        response = {
            "message": "Lấy thông tin bài đăng thành công",
            "body": post
        }

        return get_gateway_response(StatusCode.SUCCESS.value, json.dumps(response))

    except Exception as err:
        logger.error(f"Exception: {str(err)}")

        response = {
            "message": "Lấy thông tin bài đăng không thành công",
            "data": {}
        }
        return get_gateway_response(StatusCode.INTERNAL_ERROR.value, 
                                    json.dumps(response))
