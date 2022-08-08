from enum import Enum


class StatusCode(Enum):
    SUCCESS = 200
    BAD_REQUEST = 400
    UNAUTHORIZED = 401
    NOT_FOUND = 404
    INTERNAL_ERROR = 500
    BAD_GATEWAY = 502
    SERVICE_UNAVAILABLE = 503


class PostType(Enum):
    TEXT = "text"
    PETITION = "petition"
    SURVEY = "survey"
    