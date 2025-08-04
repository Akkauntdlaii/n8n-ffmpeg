FROM n8nio/n8n:latest

USER root

# Универсальная установка ffmpeg
RUN if command -v apk > /dev/null; then \
        apk update && apk add --no-cache ffmpeg; \
    elif command -v apt-get > /dev/null; then \
        apt-get update && apt-get install -y ffmpeg && apt-get clean && rm -rf /var/lib/apt/lists/*; \
    fi

# Очищаем npm cache и устанавливаем пакеты
RUN npm cache clean --force
RUN npm install -g @tavily/n8n-nodes-tavily@latest
RUN npm install -g n8n-nodes-ticktick@latest  
RUN npm install -g @apify/n8n-nodes-apify@latest

USER node

EXPOSE 5678
