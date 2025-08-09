#!/bin/bash

echo "Проверяем установлены ли community ноды..."

# Создаем директорию для нод
mkdir -p /home/node/.n8n/nodes
cd /home/node/.n8n/nodes

# Проверяем есть ли уже установленные ноды
if [ ! -f "package.json" ]; then
    echo "Устанавливаем community ноды..."
    
    # Инициализируем package.json
    npm init -y
    
    # Устанавливаем ноды
    npm install @tavily/n8n-nodes-tavily || echo "Tavily failed"
    npm install n8n-nodes-ticktick || echo "TickTick failed"
    npm install @apify/n8n-nodes-apify || echo "Apify failed"
    
    echo "Ноды установлены!"
    
    # ВАЖНО: устанавливаем права доступа
    chown -R node:node /home/node/.n8n/nodes
    
    echo "Права доступа установлены"
fi

# Возвращаемся в home 
cd /home/node

# КЛЮЧЕВОЙ МОМЕНТ: передаем переменные окружения для обнаружения нод
export N8N_CUSTOM_EXTENSIONS=/home/node/.n8n
export N8N_COMMUNITY_PACKAGES_ENABLED=true

echo "Запускаем n8n с переменными окружения..."
exec n8n
