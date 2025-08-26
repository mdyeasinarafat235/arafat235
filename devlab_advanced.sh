#!/bin/bash

# Project folder
PROJECT_DIR=~/myproject
cd $PROJECT_DIR || { echo "Project folder not found!"; exit 1; }

# Detect local IP
IP=$(ip addr show wlan0 | grep "inet " | awk '{print $2}' | cut -d/ -f1)
if [ -z "$IP" ]; then
    IP="127.0.0.1"
fi

echo "🌐 Local IP detected: $IP"

# Git: only add changed files
CHANGES=$(git status --porcelain)
if [ -n "$CHANGES" ]; then
    echo "💾 Changes detected. Committing..."
    git add .
    git commit -m "Auto update $(date)"
    git push
else
    echo "✅ No changes to commit."
fi

# Restart Flask server if app.py exists
if [ -f app.py ]; then
    pkill -f "python app.py" 2>/dev/null
    nohup python app.py > flask.log 2>&1 &
    echo "🐍 Flask server restarted at http://$IP:8080"
fi

# Restart Node server if index.js exists
if [ -f index.js ]; then
    pkill -f "node index.js" 2>/dev/null
    nohup node index.js > node.log 2>&1 &
    echo "🟢 Node server restarted at http://$IP:8080"
fi

echo "🚀 Mobile Dev Lab updated successfully!"
