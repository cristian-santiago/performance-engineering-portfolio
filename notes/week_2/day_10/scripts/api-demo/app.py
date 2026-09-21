"""
API created in FLASK
"""
from flask import Flask, jsonify
import oracledb

app = Flask(__name__)

def get_conn():
    return oracledb.connect(
        user="system",
        password="Oracle123",
        dsn="localhost:1521/XEPDB1"
    )

@app.route("/customer/<name>")
def get_customer(name):
    conn = get_conn()
    cur = conn.cursor()
    cur.execute("SELECT id, name, email FROM customers where name = :1", [name])
    row = cur.fetchone()
    cur.close()
    conn.close()
    if row:
        return jsonify({
            "id": row[0],
            "name": row[1],
            "email": row[2]
         })
    return jsonify({"Error": "not found"}), 404

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)