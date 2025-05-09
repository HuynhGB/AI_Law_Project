#!/bin/bash
set -e

export OLLAMA_HOST=0.0.0.0

ollama serve &

until curl -s http://localhost:11434 > /dev/null; do
  echo "Waiting for Ollama daemon..."
  sleep 1
done

ollama pull tinyllama

wait
