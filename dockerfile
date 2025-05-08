# Base image nhỏ gọn
FROM python:3.12.3-slim-bullseye

# Thiết lập biến môi trường
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    VENV_PATH=/app/AI_service/venv \
    AI_SERVICE_PORT=5000 \
    FRONTEND_PORT=5500

# Cài các dependencies hệ thống cần thiết
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

# Tạo và kích hoạt virtual environment
WORKDIR /app
RUN python3 -m venv $VENV_PATH
ENV PATH="$VENV_PATH/bin:$PATH"

# Cài đặt requirements Python
COPY AI_service/requirements.txt /tmp/requirements.txt
RUN pip install --upgrade pip && pip install -r /tmp/requirements.txt --no-cache-dir

# Copy toàn bộ source code vào container
COPY . .

# Copy file khởi động riêng
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Expose các port cần thiết
EXPOSE $AI_SERVICE_PORT
EXPOSE $FRONTEND_PORT

# Dùng dumb-init để khởi động
ENTRYPOINT ["/usr/bin/dumb-init", "--"]

# Chạy script start
CMD ["/app/start.sh"]
