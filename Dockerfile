FROM n8nio/n8n:latest

USER root

# Универсальная установка ffmpeg
RUN if command -v apk > /dev/null; then \
        apk update && apk add --no-cache ffmpeg; \
    elif command -v apt-get > /dev/null; then \
        apt-get update && apt-get install -y ffmpeg && apt-get clean && rm -rf /var/lib/apt/lists/*; \
    fi

USER node

# Создаем директорию для community нод (как указано в документации n8n)
RUN mkdir -p ~/.n8n/nodes

# Переходим в директорию для нод
WORKDIR ~/.n8n/nodes

# Устанавливаем community пакеты в правильную директорию
RUN npm install @tavily/n8n-nodes-tavily
RUN npm install n8n-nodes-ticktick  
RUN npm install @apify/n8n-nodes-apify

# Возвращаемся в рабочую директорию
WORKDIR /usr/local/lib/node_modules/n8n

EXPOSE 5678
