from enum import Enum


class DynamoTable(Enum):
    CHANNEL = "Channel"
    POST = "Post"
    COMMENT = "Comment"
    POSTTEXT = "PostText"
    POSTHISTORY = "PostHistory"
    FAVOURITEPOST = "FavouritePost"

class DefaultValue(Enum):
    REPORTED_TIMES = 0
    STATUS = "Active"