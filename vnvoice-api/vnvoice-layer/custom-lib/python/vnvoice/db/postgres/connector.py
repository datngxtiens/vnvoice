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
            self.connector = psycopg2.connect(conn_str)
            self.cursor = self.connector.cursor()

            logger.debug("Connected to PostgreSQL database.")
        except Exception as err:
            logger.error(f"RDS connection error: {str(err)}")
            return

    def insert_item(self, table: str, fields: tuple, values: list):
        field_values = f"({', '.join(fields)})"
        value_list = str(values).strip('[]')

        query = f"INSERT INTO {table} {field_values} VALUES {value_list} RETURNING id"

        try:
            self.cursor.execute(query=query)

            id = self.cursor.fetchone()[0]
            logger.debug(f"Insert item with ID {id} successfully")

            self.connector.commit()

            return id
        except Exception as err:
            logger.error(f"Insert exception: {str(err)}")
            raise

    def select_items(self, table: str, fields: tuple, condition: str, 
                     order: str, page: int, limit: int) -> list:
        try:  
            rows = []
            field_values = f"{', '.join(fields)}"

            query = f"SELECT {field_values} FROM {table}"

            if condition:
                query = query + f" WHERE {condition}"
            if order:
                query = query + f" ORDER BY {order}"
            if limit:
                query = query + f" LIMIT {limit}"
                if page:
                    query = query + f" OFFSET {(page - 1) * limit}"

            self.cursor.execute(query)
            for row in self.cursor:
                rows.append(row)

            return rows
        except Exception as err:
            logger.error(f"Get items failed: {str(err)}")
            raise

    def get_cursor(self):
        return self.cursor

    def commit_changes(self):
        self.connector.commit()

        

        


