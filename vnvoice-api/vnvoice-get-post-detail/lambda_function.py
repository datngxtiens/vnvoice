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

        comments = []

        comment_query = (f"SELECT {pgt.COMMENT.value}.author_id, {pgt.COMMENT.value}.id, "
                         f"{pgt.ACCOUNT.value}.username, {pgt.COMMENT.value}.text, "
                         f"{pgt.ACCOUNT.value}.img_url "
                         f"FROM {pgt.COMMENT.value} JOIN {pgt.ACCOUNT.value} "
                         f"ON {pgt.ACCOUNT.value}.id = {pgt.COMMENT.value}.author_id "
                         f"WHERE {pgt.COMMENT.value}.post_id = '{post_id}' "
                         f"AND {pgt.COMMENT.value}.reply_to is null")

        postgres.execute(comment_query)
        for comment in postgres.cursor.fetchall():
            (author_id, comment_id, username, text, author_img_url) = comment

            comment = {
                "author_id": author_id,
                "comment_id": comment_id,
                "author": username,
                "author_img_url": author_img_url,
                "text": text
            }

            comment_query = (f"SELECT {pgt.COMMENT.value}.id, {pgt.ACCOUNT.value}.username, "
                             f"{pgt.ACCOUNT.value}.id as user_id,"
                             f"{pgt.COMMENT.value}.text, {pgt.ACCOUNT.value}.img_url "
                             f"FROM {pgt.COMMENT.value} "
                             f"JOIN {pgt.ACCOUNT.value} "
                             f"ON {pgt.ACCOUNT.value}.id = {pgt.COMMENT.value}.author_id "
                             f"WHERE {pgt.COMMENT.value}.reply_to = '{comment_id}' ")
            postgres.execute(comment_query)

            child_comments = []
            for child in postgres.cursor.fetchall():
                (cid, cauthor, aid, txt, aurl) = child
                ccomment = {
                    "author_id": aid,
                    "comment_id": cid,
                    "author": cauthor,
                    "author_img_url": aurl,
                    "text": txt
                }
                child_comments.append(ccomment)
            comment["child_comment"] = child_comments

            comments.append(comment)

        response = {
            "message": "Lấy thông tin bài đăng thành công",
            "data": comments
        }

        return get_gateway_response(StatusCode.SUCCESS.value, json.dumps(response))

    except Exception as err:
        logger.error(f"Exception: {str(err)}")

        response = {
            "message": "Lấy thông tin bài đăng không thành công",
            "data": []
        }
        return get_gateway_response(StatusCode.INTERNAL_ERROR.value, 
                                    json.dumps(response))
