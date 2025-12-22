from flask import Flask, request
import os

app = Flask(__name__)
# Secret is pulled from environment (Vulnerability 1)
DB_URL = os.getenv("APP_SECRET", "default_dev_db")

@app.route('/')
def index():
    return {"status": "Production Running", "msg": "Welcome to the Secure App"}

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)