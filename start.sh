#!/bin/bash

# Script khởi động Open WebUI với Docker Compose
# Kiểm tra biến môi trường trước khi chạy

set -e

echo "======================================"
echo "  Open WebUI Docker Startup Script"
echo "======================================"
echo ""

# Kiểm tra Docker có đang chạy không
if ! docker info > /dev/null 2>&1; then
    echo "❌ Lỗi: Docker không chạy hoặc chưa cài đặt."
    echo "   Vui lòng khởi động Docker Desktop và thử lại."
    exit 1
fi

# Kiểm tra docker-compose có sẵn không
if ! command -v docker-compose &> /dev/null; then
    echo "❌ Lỗi: docker-compose chưa được cài đặt."
    echo "   Cài đặt: brew install docker-compose"
    exit 1
fi

# Load file .env nếu tồn tại
if [ -f .env ]; then
    echo "✓ Tìm thấy file .env, đang load biến môi trường..."
    set -a
    source .env
    set +a
else
    echo "⚠️  Không tìm thấy file .env"
    echo "   Bạn có thể tạo file .env từ .env.example:"
    echo "   cp .env.example .env"
    echo ""
fi

# Kiểm tra biến môi trường bắt buộc
MISSING_VARS=0

echo "Kiểm tra biến môi trường..."
echo ""

# Kiểm tra GITHUB_PERSONAL_ACCESS_TOKEN (bắt buộc)
if [ -z "$GITHUB_PERSONAL_ACCESS_TOKEN" ]; then
    echo "❌ Thiếu: GITHUB_PERSONAL_ACCESS_TOKEN"
    echo "   Cần thiết để MCP GitHub hoạt động."
    MISSING_VARS=1
else
    echo "✓ GITHUB_PERSONAL_ACCESS_TOKEN: ${GITHUB_PERSONAL_ACCESS_TOKEN:0:10}..."
fi

# Kiểm tra WEBUI_SECRET_KEY (optional, có default)
if [ -z "$WEBUI_SECRET_KEY" ]; then
    echo "⚠️  WEBUI_SECRET_KEY chưa được set (sẽ dùng giá trị mặc định)"
    echo "   Khuyến nghị: Set một chuỗi ngẫu nhiên để bảo mật tốt hơn."
else
    echo "✓ WEBUI_SECRET_KEY: ${WEBUI_SECRET_KEY:0:10}..."
fi

echo ""

# Nếu thiếu biến bắt buộc, hiển thị hướng dẫn và thoát
if [ $MISSING_VARS -eq 1 ]; then
    echo "======================================"
    echo "  Cách khắc phục:"
    echo "======================================"
    echo ""
    echo "Cách 1: Tạo file .env"
    echo "  cp .env.example .env"
    echo "  # Sau đó sửa file .env và điền token của bạn"
    echo ""
    echo "Cách 2: Export trước khi chạy script"
    echo "  export GITHUB_PERSONAL_ACCESS_TOKEN=\"ghp_your_token_here\""
    echo "  export WEBUI_SECRET_KEY=\"your_secret_key\""
    echo "  ./start.sh"
    echo ""
    echo "Cách 3: Chạy inline"
    echo "  GITHUB_PERSONAL_ACCESS_TOKEN=\"ghp_xxx\" ./start.sh"
    echo ""
    exit 1
fi

# Mọi thứ OK, bắt đầu khởi động
echo "======================================"
echo "  Khởi động Docker Compose..."
echo "======================================"
echo ""

# Pull images mới nhất (nếu có)
echo "Kiểm tra và pull Docker images..."
docker-compose pull

echo ""
echo "Khởi động các containers..."
docker-compose up -d

echo ""
echo "======================================"
echo "  ✓ Khởi động thành công!"
echo "======================================"
echo ""
echo "Services đang chạy:"
docker-compose ps

echo ""
echo "Truy cập Open WebUI tại: http://localhost:3301"
echo "MCP GitHub Proxy: http://localhost:51100"
echo ""
echo "Xem logs: docker-compose logs -f"
echo "Dừng: docker-compose down"
echo ""
