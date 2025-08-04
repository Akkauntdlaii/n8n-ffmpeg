FROM n8nio/n8n:latest

USER root

# Универсальная установка ffmpeg
RUN if command -v apk > /dev/null; then \
        apk update && apk add --no-cache ffmpeg; \
    elif command -v apt-get > /dev/null; then \
        apt-get update && apt-get install -y ffmpeg && apt-get clean && rm -rf /var/lib/apt/lists/*; \
    fi

USER node

# Создаем директорию для community нод
RUN mkdir -p /home/node/.n8n/nodes

# Устанавливаем community пакеты с правильным префиксом
RUN npm install --prefix=/home/node/.n8n/nodes @tavily/n8n-nodes-tavily
RUN npm install --prefix=/home/node/.n8n/nodes n8n-nodes-ticktick  
RUN npm install --prefix=/home/node/.n8n/nodes @apify/n8n-nodes-apify

EXPOSE 5678
