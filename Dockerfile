FROM n8nio/n8n:latest

USER root
# ffmpeg
RUN if command -v apk > /dev/null; then \
        apk update && apk add --no-cache ffmpeg; \
    elif command -v apt-get > /dev/null; then \
        apt-get update && apt-get install -y ffmpeg && apt-get clean && rm -rf /var/lib/apt/lists/*; \
    fi

USER node

# Официальный способ из документации n8n
RUN mkdir -p ~/.n8n/nodes
WORKDIR ~/.n8n/nodes
RUN npm install @tavily/n8n-nodes-tavily n8n-nodes-ticktick @apify/n8n-nodes-apify

WORKDIR /usr/local/lib/node_modules/n8n
EXPOSE 5678
