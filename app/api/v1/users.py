from fastapi import APIRouter
import mysql.connector

users = APIRouter()

# Function to create a database connection
def create_conn():
    conn = mysql.connector.connect(
        host="db",
        user="root",
        password="secretpassword",
        database="test_database"
    )
    return conn

@users.get(
    "/users",
    tags=["users"],
    description="Get users data",
)
async def get_users():
    conn = create_conn()
    cursor = conn.cursor()

    # Query to fetch data from the MySQL database
    query = "SELECT * FROM users"
    cursor.execute(query)

    # Fetch all rows and extract column names
    rows = cursor.fetchall()
    column_names = [column[0] for column in cursor.description]

    # Convert rows to a list of dictionaries
    data = [dict(zip(column_names, row)) for row in rows]

    # Close the connection and return the data
    cursor.close()
    conn.close()
    return data
