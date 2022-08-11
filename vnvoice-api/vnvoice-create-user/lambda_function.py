import json

from vnvoice.db.postgres.connector import PostgresConnector
from vnvoice.enums import StatusCode as sc
from vnvoice.util import (get_gateway_response, get_logger)

logger = get_logger(__name__)
postgres = PostgresConnector()

def lambda_handler(event, context):
    try:
        body = json.loads(event["body"])

        email = body["email"]
        password = body["password"]

        if body["username"]:
            username = body["username"]
        else:
            username = body["email"]

        query = ("INSERT INTO account (username, password, email) VALUES "
                 f"('{username}', '{password}', '{email}') RETURNING id")

        logger.debug(f"Query: {query}")

        postgres.execute(query=query)
        user_id = postgres.cursor.fetchone()[0]
        postgres.commit_changes()

        if "role" in body.keys():
            r_query = f"UPDATE account SET role = '{body['role']}' WHERE id = '{user_id}'"
            postgres.execute(query=r_query)
            postgres.commit_changes()
        if "img_url" in body.keys():
            i_query = f"UPDATE account SET img_url = '{body['img_url']}' WHERE id = '{user_id}'"
            postgres.execute(query=i_query)
            postgres.commit_changes()

        response = {
            "message": "Tạo tài khoản thành công",
            "data": {
                "user_id": user_id
            }
        }
        
        return get_gateway_response(sc.SUCCESS.value, 
                                    json.dumps(response))
    except Exception as err:
        logger.debug(f"Exception: {str(err)}")

        response = {
            "message": "Tạo tài khoản không thành công.",
            "data": {}
        }
        return get_gateway_response(sc.INTERNAL_ERROR.value, json.dumps(response))
