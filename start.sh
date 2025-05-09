#!/bin/bash
set -e

# Activate virtual environment
source /app/AI_service/venv/bin/activate

# Add health check endpoint to the Flask app
echo "
@app.route('/api/health', methods=['GET'])
def health_check():
    return jsonify({'status': 'ok'}), 200
" >> /app/AI_service/llm.py

# Wait for Ollama to be fully available
echo "Waiting for Ollama service..."
max_attempts=30
attempt=0
while ! curl -s http://ollama:11434 > /dev/null; do
  attempt=$((attempt+1))
  if [ $attempt -gt $max_attempts ]; then
    echo "Ollama service not available after $max_attempts attempts. Exiting."
    exit 1
  fi
  echo "Attempt $attempt/$max_attempts: Ollama not ready yet, waiting..."
  sleep 5
done
echo "Ollama service is available!"

# Check if model is available, pull if not
echo "Checking if model is available..."
if ! curl -s "http://ollama:11434/api/tags" | grep -q "tinyllama"; then
  echo "Model not found, pulling tinyllama..."
  curl -X POST http://ollama:11434/api/pull -d '{"name": "tinyllama"}'
fi

# Run backend and frontend services
echo "Starting backend service..."
cd /app/AI_service
python llm.py --host 0.0.0.0 &
BACKEND_PID=$!

echo "Starting frontend service..."
cd /app/frontend_service
python3 -m http.server $FRONTEND_PORT --bind 0.0.0.0 &
FRONTEND_PID=$!

# Monitor processes
monitor_process() {
  while true; do
    if ! kill -0 $1 2>/dev/null; then
      echo "$2 process died. Exiting container."
      exit 1
    fi
    sleep 10
  done
}

monitor_process $BACKEND_PID "Backend" &
monitor_process $FRONTEND_PID "Frontend" &

# Wait for all background processes
wait
