#!/bin/bash
set -e

# Start the Ollama daemon in the background
ollama serve &

# Wait until Ollama daemon is ready
until curl -s http://localhost:11434 > /dev/null; do
  echo "Waiting for Ollama daemon..."
  sleep 1
done

# Pull the model
ollama pull tinyllama

# Wait for daemon (already running)
wait
