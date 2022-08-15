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

        query = (f"SELECT id, username, role FROM account "
                 f"WHERE email = '{email}' AND password = '{password}'")

        postgres.execute(query=query)

        result = postgres.cursor.fetchone()
        if result:
            (user_id, username, role) = result

            response = {
                "message": "Đăng nhập thành công",
                "user_id": user_id,
                "username": username,
                "role": role
            }
        else:
            response = {
                "message": "Tài khoản hoặc mật khẩu không chính xác.",
                "data": {}
            }

            return get_gateway_response(sc.BAD_REQUEST.value, json.dumps(response))
        
        return get_gateway_response(sc.SUCCESS.value, 
                                    json.dumps(response))
    except Exception as err:
        logger.debug(f"Exception: {str(err)}")

        response = {
            "message": "Hệ thống lỗi. Vui lòng thử lại sau.",
            "data": {}
        }
        return get_gateway_response(sc.INTERNAL_ERROR.value, json.dumps(response))
