#!/bin/bash
# Start Xvfb
Xvfb :99 -screen 0 1280x1024x24 &
export DISPLAY=:99

# Start the node server
echo "Starting Node.js server..."
node scraper_server.js
