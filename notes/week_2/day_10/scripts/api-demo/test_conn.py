'''
Testing connection to the API
'''

import oracledb

conn = oracledb.connect(

    user="system",
    password="Oracle123",
    dsn="localhost:1521/XEPDB1"
)

cur = conn.cursor()
cur.execute("SELECT COUNT(*) FROM customers")
print(cur.fetchone())
cur.close()
conn.close()