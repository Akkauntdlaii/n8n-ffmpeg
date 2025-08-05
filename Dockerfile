FROM n8nio/n8n:latest

# Уникальная строка для сброса кеша Docker
ARG CACHEBUST=1
RUN echo "Cache bust: $CACHEBUST"

USER root

# Универсальная установка ffmpeg
RUN if command -v apk > /dev/null; then \
        apk update && apk add --no-cache ffmpeg; \
    elif command -v apt-get > /dev/null; then \
        apt-get update && apt-get install -y ffmpeg && apt-get clean && rm -rf /var/lib/apt/lists/*; \
    fi

USER node

RUN mkdir -p ~/.n8n/nodes
WORKDIR ~/.n8n/nodes

# Устанавливаем только рабочие пакеты
RUN npm install @tavily/n8n-nodes-tavily
RUN npm install @apify/n8n-nodes-apify

WORKDIR /usr/local/lib/node_modules/n8n
EXPOSE 5678
