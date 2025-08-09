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
else
    echo "Ноды уже установлены, пропускаем установку"
fi

# Возвращаемся в home и запускаем n8n
cd /home/node
echo "Запускаем n8n..."
exec n8n
