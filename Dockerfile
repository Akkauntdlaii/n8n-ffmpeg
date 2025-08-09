FROM n8nio/n8n:latest

USER root

# Универсальная установка ffmpeg
RUN if command -v apk > /dev/null; then \
        apk update && apk add --no-cache ffmpeg; \
    elif command -v apt-get > /dev/null; then \
        apt-get update && apt-get install -y ffmpeg && apt-get clean && rm -rf /var/lib/apt/lists/*; \
    fi

# Создаем директорию и устанавливаем глобально (это другой подход)
RUN npm install -g @tavily/n8n-nodes-tavily @apify/n8n-nodes-apify

# Переключаемся на пользователя node и создаем локальную директорию
USER node
RUN mkdir -p ~/.n8n/nodes

WORKDIR ~/.n8n/nodes
# Устанавливаем локально тоже
RUN npm install n8n-nodes-ticktick

WORKDIR /usr/local/lib/node_modules/n8n
EXPOSE 5678
