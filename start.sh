#!/bin/bash

# Chạy Flask backend
cd /app/AI_service
python llm.py --host 0.0.0.0 &

# Chạy frontend với HTTP server
cd /app/frontend_service
python3 -m http.server $FRONTEND_PORT --bind 0.0.0.0
