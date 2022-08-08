import boto3
from botocore.exceptions import ClientError
from vnvoice.util import get_logger


logger = get_logger(__name__)

class DynamoConnector():
    def __init__(self) -> None:
        try:
            self.dynamodb = boto3.resource('dynamodb')
            logger.debug("Connected to DynamoDB")
        except Exception as err:
            logger.debug(f"Cannot connect to DynamoDB: {str(err)}")
            return

    def put_item(self, table_name: str, item):
        try:
            table = self.dynamodb.Table(table_name)
            table.put_item(
                Item=item
            )

            logger.debug("Insert new item successfully")
            return (None, "Success")
        except ClientError as err:
            logger.debug("Cannot add new item: "
                         f"{err.response['Error']['Message']}")
            return (
                err.response['Error']['Code'], 
                err.response['Error']['Message']
            )
