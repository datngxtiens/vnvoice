import json

from vnvoice.db.postgres.connector import PostgresConnector
from vnvoice.enums import StatusCode
from vnvoice.util import get_gateway_response, get_logger

logger = get_logger(__name__)
postgres = PostgresConnector()

def lambda_handler(event, context):
    try:
        channel_id = event["queryStringParameters"]["id"]
        posts = []

        query = ("SELECT t_posts.*, c_comments.total_comment FROM "
                 "(SELECT post.id, post.type, post.author_id, post.channel_id, post.status, "
                 "post.upvotes, post.downvotes, account.username, channel.name as channelname, "
                 "account.img_url FROM post "
                 "JOIN account ON account.id = post.author_id "
                 "JOIN channel ON channel.id = post.channel_id "
                 f"WHERE post.is_deleted = false AND post.channel_id='{channel_id}') t_posts "
                 "JOIN "
                 "(SELECT post.id, COUNT(post_comment.id) as total_comment "
                 "FROM post LEFT JOIN post_comment ON post.id = post_comment.post_id "
                 "GROUP BY post.id) c_comments "
                 "ON (t_posts.id = c_comments.id)")

        postgres.execute(query=query)
        for row in postgres.cursor.fetchall():
            (p_id, p_type, au_id, ch_id, status, upv, downv, uname, cname, a_url ,t_com) = row

            post = {
                "post_id": p_id,
                "type": p_type,
                "author_id": au_id,
                "author_img_url": a_url,
                "username": uname,
                "channel_id": ch_id,
                "channel_name": cname,
                "status": status,
                "upvotes": upv,
                "downvotes": downv,
                "total_comments": t_com
            }

            if p_type == "text":
                text_query = ("SELECT post_text.title, post_text.text "
                              "FROM post JOIN post_text "
                              "ON post.id = post_text.post_id "
                              f"WHERE post.id='{p_id}'")
                postgres.execute(query=text_query)

                (title, text) = postgres.cursor.fetchone()
                post["title"] = title
                post["text"] = text

                img_query = (f"SELECT img_url FROM post_image "
                             f"WHERE post_id = '{p_id}'")
                postgres.execute(query=img_query)
            
                post["images"] = [f"{img[0]}" for img in postgres.cursor.fetchall()]
            if p_type == "petition":
                petition_query = ("SELECT post_petition.name, "
                                  "post_petition.description, post_petition.total_signature "
                                  "FROM post JOIN post_petition "
                                  "ON post.id = post_petition.post_id ")
                postgres.execute(query=petition_query)
                (name, description, total) = postgres.cursor.fetchone()
                post["title"] = name
                post["text"] = description
                post["total_signature"] = total
            if p_type == "survey":
                survey_query = ("SELECT post_survey.description, "
                                "post_survey.name, post_survey.url "
                                "FROM post JOIN post_survey "
                                "ON post.id = post_survey.post_id ")
                postgres.execute(query=survey_query)
                (name, description, url) = postgres.cursor.fetchone()
                post["title"] = f"{name}"
                post["text"] = f"{description}"
                post["url"] = f"{url}"
            posts.append(post)

        response = {
            "message": "Lấy tất cả bài đăng thành công",
            "data": posts
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
