FROM n8nio/n8n:latest
USER root
# Устанавливаем ffmpeg через apk (Alpine Linux)
RUN apk update && \
    apk add --no-cache ffmpeg && \
    rm -rf /var/cache/apk/*
# Универсальная установка ffmpeg
RUN if command -v apk > /dev/null; then \
        apk update && apk add --no-cache ffmpeg; \
    elif command -v apt-get > /dev/null; then \
        apt-get update && apt-get install -y ffmpeg && apt-get clean && rm -rf /var/lib/apt/lists/*; \
    fi

# Добавляем Python и yt-dlp
RUN apk add --no-cache python3 py3-pip && \
    pip3 install --no-cache-dir yt-dlp

USER node
EXPOSE 5678
