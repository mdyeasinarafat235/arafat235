#!/bin/bash

PROJECT_DIR=~/myproject
cd $PROJECT_DIR || exit 1

IP=$(ip addr show wlan0 | grep "inet " | awk '{print $2}' | cut -d/ -f1)
[ -z "$IP" ] && IP="127.0.0.1"
echo "Local IP: $IP"

# Git auto commit & push
CHANGES=$(git status --porcelain)
if [ -n "$CHANGES" ]; then
    git add .
    git commit -m "Auto update $(date)"
    git push
fi

# Restart Flask backend
pkill -f "python backend_flask/app.py" 2>/dev/null
nohup python backend_flask/app.py > flask.log 2>&1 &

# Restart Node frontend
pkill -f "node frontend_node/index.js" 2>/dev/null
nohup node frontend_node/index.js > node.log 2>&1 &

echo "Flask: http://$IP:5000"
echo "Node:  http://$IP:8080"
