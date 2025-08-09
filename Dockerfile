FROM n8nio/n8n:latest

USER root

# ffmpeg
RUN if command -v apk > /dev/null; then \
        apk update && apk add --no-cache ffmpeg; \
    elif command -v apt-get > /dev/null; then \
        apt-get update && apt-get install -y ffmpeg && apt-get clean && rm -rf /var/lib/apt/lists/*; \
    fi

# Копируем скрипт и делаем его исполняемым
COPY install-nodes.sh /install-nodes.sh
RUN chmod +x /install-nodes.sh

# ВАЖНО: добавляем переменные окружения для обнаружения нод
ENV N8N_CUSTOM_EXTENSIONS=/home/node/.n8n
ENV N8N_COMMUNITY_PACKAGES_ENABLED=true

USER node

EXPOSE 5678

ENTRYPOINT ["/install-nodes.sh"]
