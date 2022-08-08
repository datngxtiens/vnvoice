import logging
from datetime import datetime, timezone
import bcrypt
import uuid


def get_logger(name: str) -> logging.Logger:
    logger = logging.getLogger(name)
    logger.setLevel(logging.DEBUG)

    logger_handler = logging.StreamHandler()
    logger_handler.setLevel(logging.DEBUG)

    logger_formatter = logging.Formatter("%(name)s:%(levelname)s.%(message)s")
    logger_handler.setFormatter(logger_formatter)

    return logger

def generate_id():
    return uuid.uuid1()

def get_current_date():
    return datetime.now(timezone.utc)

def hash_password(psw):
    return bcrypt.hashpw(psw.encode('utf-8'), bcrypt.gensalt())

def check_password(psw, hashed):
    return bcrypt.checkpw(psw.encode('utf-8'), hashed.encode('utf-8'))

def get_gateway_response(statusCode, body):
    return {
        "statusCode": statusCode,
        "body": body
    }

