#!/bin/bash
set -e

# Kích hoạt venv
source /app/AI_service/venv/bin/activate

# Chạy song song cả backend và frontend dùng `&`, nhưng theo dõi và giữ container sống:
cd /app/AI_service
python llm.py --host 0.0.0.0 &

cd /app/frontend_service
python3 -m http.server $FRONTEND_PORT --bind 0.0.0.0 &

# Wait all background processes
wait
