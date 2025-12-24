# Backend - TVU Hồ Sơ Đi Nước Ngoài

## Cấu trúc

- `src/config/` - Cấu hình DB và env
- `src/models/` - Mapping CSDL
- `src/routes/` - API routes
- `src/controllers/` - Xử lý request/response
- `src/services/` - Logic nghiệp vụ
- `src/middlewares/` - Middleware auth và role
- `src/utils/` - Utilities
- `src/app.js` - Khởi tạo Express
- `src/server.js` - Chạy server

## Chạy

```bash
npm install
npm start
```

Server chạy trên http://localhost:4000

## API

- POST /api/auth/login
- GET /api/auth/me
- GET /api/hoso
- POST /api/hoso
- etc.
