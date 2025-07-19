FROM n8nio/n8n:latest

USER root

# Устанавливаем ffmpeg
RUN apt-get update && \
    apt-get install -y ffmpeg && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER node

EXPOSE 5678
