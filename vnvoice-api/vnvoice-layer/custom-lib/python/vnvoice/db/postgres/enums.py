from enum import Enum


class PostgresTable(Enum):
    CHANNEL = "channel"
    POST = "post"
    COMMENT = "post_comment"
    POST_TEXT = "post_text"
    POST_PETITION = "post_petition"
    POST_SURVEY = "post_survey"
    POST_HISTORY = "post_history"
    FAVORITE_POST = "favorite_post"
    POST_IMAGE = "post_image"
