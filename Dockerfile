FROM n8nio/n8n:latest

USER root

# Универсальная установка ffmpeg
RUN if command -v apk > /dev/null; then \
        apk update && apk add --no-cache ffmpeg; \
    elif command -v apt-get > /dev/null; then \
        apt-get update && apt-get install -y ffmpeg && apt-get clean && rm -rf /var/lib/apt/lists/*; \
    fi

# Устанавливаем community ноды в директорию n8n (как в официальном примере)
RUN cd /usr/local/lib/node_modules/n8n && npm install @tavily/n8n-nodes-tavily n8n-nodes-ticktick @apify/n8n-nodes-apify

USER node

EXPOSE 5678
