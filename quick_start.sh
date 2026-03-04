#!/bin/bash

echo "🚀 CRM - Быстрый Запуск"
echo "========================"
echo ""

# Проверить наличие Python
if ! command -v python3 &> /dev/null; then
    echo "❌ Python3 не найден!"
    echo "Установите Python3: https://python.org"
    exit 1
fi

# Проверить наличие папки build/web
if [ ! -d "build/web" ]; then
    echo "❌ Папка build/web не найдена!"
    echo "Запустите: flutter build web --release"
    exit 1
fi

# Перейти в build/web
cd build/web

echo "✅ Найдена собранная версия"
echo "📁 Путь: $(pwd)"
echo ""

# Проверить наличие index.html
if [ ! -f "index.html" ]; then
    echo "❌ index.html не найден!"
    exit 1
fi

echo "✅ Файл index.html найден"
echo ""

# Найти свободный порт
PORT=8080
while lsof -Pi :$PORT -sTCP:LISTEN -t >/dev/null ; do
    echo "⚠️  Порт $PORT занят"
    PORT=$((PORT + 1))
done

echo "🌐 Запуск сервера на порту $PORT..."
echo "========================================"
echo ""
echo "📱 URL: http://localhost:$PORT"
echo "🔑 Логин: demo@crm.com"
echo "🔐 Пароль: demo"
echo "========================================"
echo ""
echo "Нажмите Ctrl+C для остановки"
echo ""

# Запустить сервер
python3 -m http.server $PORT
