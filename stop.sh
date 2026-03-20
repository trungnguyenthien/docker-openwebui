#!/bin/bash

# Script dừng Open WebUI và các services Docker Compose

set -e

echo "======================================"
echo "  Open WebUI Docker Stop Script"
echo "======================================"
echo ""

# Kiểm tra Docker có đang chạy không
if ! docker info > /dev/null 2>&1; then
    echo "❌ Lỗi: Docker không chạy."
    exit 1
fi

# Kiểm tra docker-compose có sẵn không
if ! command -v docker-compose &> /dev/null; then
    echo "❌ Lỗi: docker-compose chưa được cài đặt."
    exit 1
fi

# Hiển thị các containers đang chạy
echo "Các containers đang chạy:"
docker-compose ps
echo ""

# Hỏi người dùng có muốn xóa volumes không
read -p "Bạn có muốn xóa luôn dữ liệu (volumes)? [y/N]: " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "⚠️  Đang dừng và xóa containers + volumes..."
    docker-compose down -v
    echo ""
    echo "✓ Đã dừng và xóa tất cả (bao gồm dữ liệu)"
else
    echo "Đang dừng containers (giữ lại dữ liệu)..."
    docker-compose down
    echo ""
    echo "✓ Đã dừng containers (dữ liệu vẫn được giữ lại)"
fi

echo ""
echo "======================================"
echo "  Hoàn tất!"
echo "======================================"
echo ""
echo "Để khởi động lại: ./start.sh"
echo "Xem volumes: docker volume ls"
echo ""
