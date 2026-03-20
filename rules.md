Dưới đây là một số nguyên tắc trong dự án này:

### Các port của mcp-* phải từ 511xx
Ví dụ:
```yml
    ports:
      - "51100:8000"
```

### Các biến môi trường của mcp-** phải lấy từ biến môi trường từ hệ thống
Ví dụ:
```yml
    environment:
      - GITHUB_PERSONAL_ACCESS_TOKEN=${GITHUB_PERSONAL_ACCESS_TOKEN}
```

### Container tự restart lại (`restart: always`)

### Update start.sh và sample.env nếu biến môi trường cần cập nhật

### Update trong readme.md để hướng dẫn
- start openwebui
- cấu hình connection để openwebui sử dụng các model như Gemini với API KEY
- cấu hình mcp
Lưu ý, hãy viết readme.md ngắn gọn nhất có thể