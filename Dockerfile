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

# Устанавливаем yt-dlp через виртуальное окружение
RUN apk add --no-cache python3 py3-pip && \
    python3 -m venv /opt/venv && \
    /opt/venv/bin/pip install yt-dlp && \
    ln -s /opt/venv/bin/yt-dlp /usr/local/bin/yt-dlp

USER node
EXPOSE 5678
