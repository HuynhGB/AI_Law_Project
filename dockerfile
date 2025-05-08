FROM python:3.12.3-slim-bullseye

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    VENV_PATH=/app/AI_service/venv \
    AI_SERVICE_PORT=5000 \
    FRONTEND_PORT=5500

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-venv \
    build-essential \
    gcc \
    g++ \
    cmake \
    git \
    libopenblas-dev \
    liblapack-dev \
    dumb-init && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app
RUN python3 -m venv $VENV_PATH
ENV PATH="$VENV_PATH/bin:$PATH"

COPY AI_service/requirements.txt /tmp/requirements.txt
RUN pip install --upgrade pip && pip install -r /tmp/requirements.txt --no-cache-dir

COPY . .

COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

EXPOSE $AI_SERVICE_PORT
EXPOSE $FRONTEND_PORT

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/app/start.sh"]
