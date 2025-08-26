#!/bin/bash

PROJECT_DIR=~/myproject
cd $PROJECT_DIR || exit 1

# Auto detect local IP
IP=$(ip addr show wlan0 | grep "inet " | awk '{print $2}' | cut -d/ -f1)
[ -z "$IP" ] && IP="127.0.0.1"
echo "Local IP: $IP"

# Git auto commit & push
CHANGES=$(git status --porcelain)
if [ -n "$CHANGES" ]; then
    git add .
    git commit -m "Auto update $(date)"
    git push
else
    echo "No changes to commit."
fi

# Restart Flask backend
pkill -f "python backend_flask/app.py" 2>/dev/null
nohup python backend_flask/app.py > flask.log 2>&1 &

# Restart Node frontend
pkill -f "node frontend_node/index.js" 2>/dev/null
nohup node frontend_node/index.js > node.log 2>&1 &

echo "🚀 DevLab Ready!"
echo "Flask: http://$IP:5000/api"
echo "Node:  http://$IP:8080"
