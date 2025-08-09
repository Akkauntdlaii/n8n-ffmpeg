FROM n8nio/n8n:latest

USER root

# Универсальная установка ffmpeg
RUN if command -v apk > /dev/null; then \
        apk update && apk add --no-cache ffmpeg && yarn --version; \
    elif command -v apt-get > /dev/null; then \
        apt-get update && apt-get install -y ffmpeg && apt-get clean && rm -rf /var/lib/apt/lists/*; \
    fi

USER node

# Создаем директорию для community нод
RUN mkdir -p ~/.n8n/nodes
WORKDIR ~/.n8n/nodes

# Инициализируем package.json
RUN npm init -y

# Устанавливаем пакеты через yarn (может работать лучше чем npm)
RUN yarn add @tavily/n8n-nodes-tavily n8n-nodes-ticktick @apify/n8n-nodes-apify

WORKDIR /usr/local/lib/node_modules/n8n
EXPOSE 5678
