import os

import psycopg2
from vnvoice.util import get_logger

logger = get_logger(__name__)

class PostgresConnector():
    try:
        HOST  = os.environ.get('RDS_HOST')
        USERNAME = os.environ.get('RDS_USERNAME')
        PSW = os.environ.get('RDS_USER_PSW')
        DB = os.environ.get('RDS_DB_NAME')
    except:
        HOST, USERNAME, PSW, DB = ""

    conn_str = f"host={HOST} user={USERNAME} password={PSW} dbname={DB}"

    def __init__(self, conn_str: str = conn_str) -> None:
        try:
            self._connector = psycopg2.connect(conn_str)
            self._cursor = self._connector.cursor()

            logger.debug("Connected to PostgreSQL database.")
        except Exception as err:
            logger.error(f"RDS connection error: {str(err)}")
            return

    @property
    def cursor(self):
        return self._cursor

    def execute(self, query: str):
        try:
            self._cursor.execute(query)
        except Exception as err:
            logger.debug(f"Failed to execute query: {str(err)}")
            return

    def commit_changes(self):
        try:
            self._connector.commit()
        except Exception as err:
            logger.debug(f"Cannot commit changes to DB: {str(err)}")
            return

        

        


