#!/bin/bash

# Project folder
cd ~/myproject

# Git auto commit & push
git add .
git commit -m "Auto update $(date)"
git push

# Stop any running Flask server (optional)
pkill -f "python app.py"

# Start Flask server in background
nohup python app.py > flask.log 2>&1 &

# Stop any running Node server (optional)
pkill -f "node index.js"

# Start Node server in background
nohup node index.js > node.log 2>&1 &

echo "✅ Dev Lab updated and servers restarted!"
echo "Flask: http://192.168.100.171:8080"
echo "Node:  http://192.168.100.171:8080"
