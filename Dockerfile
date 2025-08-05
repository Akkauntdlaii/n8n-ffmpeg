FROM n8nio/n8n:latest

# Force rebuild - Aug 5 2025 v2
USER root

# Универсальная установка ffmpeg
RUN if command -v apk > /dev/null; then \
        apk update && apk add --no-cache ffmpeg; \
    elif command -v apt-get > /dev/null; then \
        apt-get update && apt-get install -y ffmpeg && apt-get clean && rm -rf /var/lib/apt/lists/*; \
    fi

# Очищаем npm кеш и исправляем права доступа
RUN npm cache clean --force
RUN rm -rf /root/.npm
RUN rm -rf /tmp/npm-*

USER node

# Очищаем кеш для пользователя node
RUN npm cache clean --force || true

# Создаем директорию для community нод
RUN mkdir -p ~/.n8n/nodes

WORKDIR ~/.n8n/nodes

# Устанавливаем только рабочие пакеты
RUN npm install @tavily/n8n-nodes-tavily || echo "Tavily failed"
RUN npm install @apify/n8n-nodes-apify || echo "Apify failed"

# TickTick не устанавливаем через Docker - только через переменные окружения

WORKDIR /usr/local/lib/node_modules/n8n

EXPOSE 5678
