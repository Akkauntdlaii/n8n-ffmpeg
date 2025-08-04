FROM n8nio/n8n:latest

USER root

# Универсальная установка ffmpeg
RUN if command -v apk > /dev/null; then \
        apk update && apk add --no-cache ffmpeg; \
    elif command -v apt-get > /dev/null; then \
        apt-get update && apt-get install -y ffmpeg && apt-get clean && rm -rf /var/lib/apt/lists/*; \
    fi

# Настраиваем npm
RUN npm config set registry https://registry.npmjs.org/
RUN npm cache clean --force

# Устанавливаем пакеты с таймаутом и дополнительными флагами
RUN npm install -g @tavily/n8n-nodes-tavily --timeout=60000
RUN npm install -g n8n-nodes-ticktick --timeout=60000 --no-package-lock
RUN npm install -g @apify/n8n-nodes-apify --timeout=60000

USER node

EXPOSE 5678
