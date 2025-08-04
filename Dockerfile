FROM n8nio/n8n:latest

USER root

# Универсальная установка ffmpeg
RUN if command -v apk > /dev/null; then \
        apk update && apk add --no-cache ffmpeg; \
    elif command -v apt-get > /dev/null; then \
        apt-get update && apt-get install -y ffmpeg && apt-get clean && rm -rf /var/lib/apt/lists/*; \
    fi

# Устанавливаем yarn
RUN npm install -g yarn

# Очищаем кеши
RUN npm cache clean --force
RUN yarn cache clean

# Устанавливаем пакеты через yarn
RUN yarn global add @tavily/n8n-nodes-tavily
RUN yarn global add n8n-nodes-ticktick
RUN yarn global add @apify/n8n-nodes-apify

USER node

EXPOSE 5678
