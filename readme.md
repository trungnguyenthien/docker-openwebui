# Open WebUI với Docker & MCP GitHub

## Khởi động

```bash
# 1. Tạo file .env
cp sample.env .env
# Sửa .env và điền: GITHUB_PERSONAL_ACCESS_TOKEN, WEBUI_SECRET_KEY

# 2. Start
./start.sh

# 3. Truy cập
# Open WebUI: http://localhost:3301
# MCP Proxy: http://localhost:51100
```

## Cấu hình AI Models

Vào **Settings** ⚙️ → **Connections** → **+ Add Connection**

### Google Gemini
```
API Base URL: https://generativelanguage.googleapis.com/v1beta
API Key: <lấy tại https://aistudio.google.com/app/apikey>
```

### OpenAI
```
API Base URL: https://api.openai.com/v1
API Key: <lấy tại https://platform.openai.com/api-keys>
```

### Anthropic Claude
```
API Base URL: https://api.anthropic.com/v1
API Key: <your_anthropic_key>
```

## Cấu hình MCP GitHub

Vào **Settings** → **Tools** → **MCP Servers** → **+ Add MCP Server**

```
Name: GitHub
URL: http://mcp-github:8000
Type: SSE
```

Sau đó chat với AI và yêu cầu làm việc với GitHub (tạo file, issue, PR, etc.)

## Lệnh cơ bản

```bash
./stop.sh                    # Dừng services
docker-compose logs -f       # Xem logs
docker-compose restart       # Restart
docker-compose ps            # Kiểm tra status
```
