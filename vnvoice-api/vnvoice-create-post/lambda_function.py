import json

from vnvoice.db.dynamo.connector import DynamoConnector
from vnvoice.db.dynamo.enums import DefaultValue as dv
from vnvoice.db.dynamo.enums import DynamoTable as dyt
from vnvoice.enums import PostType as pt
from vnvoice.enums import StatusCode as sc
from vnvoice.util import (generate_id, get_current_date, get_gateway_response,
                          get_logger)

logger = get_logger(__name__)
dynamo_connector = DynamoConnector()

def lambda_handler(event, context):
    type = event["queryStringParameters"]["type"]
    body = json.loads(event["body"])

    post_id = str(generate_id())

    post = {
        "id": post_id,
        "author_id": body["author_id"],
        "created_date": str(get_current_date()),
        "updated_date": str(get_current_date()),
        "channel_id": body["channel_id"],
        "downvotes": dv.INIT_INT.value,
        "upvotes": dv.INIT_INT.value,
        "reported_times": dv.INIT_INT.value,
        "is_deleted": False,
        "img_url": body["img_url"],
        "status": dv.STATUS.value
    }

    if type == pt.TEXT.value:
        post["post_type"] = pt.TEXT.value
        post_text = {
            "post_id": post_id,
            "text": body["text"]
        }
        (err1, msg1) = dynamo_connector.put_item(dyt.POST.value, post)
        (err2, msg2) = dynamo_connector.put_item(dyt.POSTTEXT.value, post_text)
    elif type == pt.SURVEY.value:
        pass
    elif type == pt.PETITION.value:
        pass
    else:
        logger.debug("Invalid post type")
        return get_gateway_response(sc.BAD_REQUEST.value, "Invalid post type")
    
    if err1 is None and err2 is None:
        return get_gateway_response(sc.SUCCESS.value, 
                                    "Create new post successfully")
    return get_gateway_response(sc.INTERNAL_ERROR.value, 
                                msg1 if err1 is not None else msg2)
