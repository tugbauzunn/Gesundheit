# Health Care Backend API

Bu proje, sağlık bakım düzeyi talepleri ve PDF dosya yönetimi için Node.js backend API'sidir.

## Özellikler

- 🔐 Güvenli PDF dosya yükleme
- 📁 Dosya sistemi üzerinde PDF saklama
- 🔄 PDF indirme ve silme
- 📋 Bakım düzeyi talepleri yönetimi
- 🛡️ Güvenlik (Helmet, Rate Limiting, CORS)
- 📦 Dosya boyutu kontrolü (10MB maksimum)

## API Endpoints

### PDF Dosya İşlemleri
- `POST /api/upload-pdf` - PDF dosyası yükle
- `GET /api/download-pdf/:filename` - PDF dosyasını indir
- `DELETE /api/delete-pdf/:filename` - PDF dosyasını sil
- `GET /api/uploaded-files` - Yüklenen dosyaları listele

### Bakım Düzeyi Talepleri
- `POST /api/care-level-request` - Yeni talep oluştur
- `GET /api/care-level-request/:id` - Talep detaylarını getir
- `GET /api/care-level-requests` - Tüm talepleri listele

## Kurulum

1. Dependencies'leri yükle:
```bash
cd backend
npm install
```

2. Sunucuyu başlat:
```bash
npm run dev
```

Sunucu http://localhost:3000 adresinde çalışacak.

## Kullanım Örnekleri

### PDF Dosyası Yükleme
```javascript
const formData = new FormData();
formData.append('pdf', pdfFile);

const response = await fetch('http://localhost:3000/api/upload-pdf', {
  method: 'POST',
  body: formData
});

const result = await response.json();
console.log(result);
```

### PDF Dosyası İndirme
```javascript
const response = await fetch(`http://localhost:3000/api/download-pdf/${filename}`);
const blob = await response.blob();
// Blob'u indirme olarak kullan
```

### Bakım Düzeyi Talebi Oluşturma
```javascript
const requestData = {
  currentLevel: 2,
  desiredLevel: 3,
  reason: "Sağlık durumu kötüleşti",
  attachedFileId: "pdf-file-id"
};

const response = await fetch('http://localhost:3000/api/care-level-request', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json'
  },
  body: JSON.stringify(requestData)
});
```

## Güvenlik

- Helmet ile HTTP güvenlik başlıkları
- Rate limiting (15 dakikada 100 istek)
- CORS koruması
- Dosya türü kontrolü (sadece PDF)
- Dosya boyutu sınırı (10MB)
- Path traversal koruması

## Yapı

```
backend/
├── server.js          # Ana sunucu dosyası
├── package.json       # NPM dependencies
├── .env               # Environment variables
├── .gitignore         # Git ignore rules
├── uploads/           # PDF dosyaları burada saklanır
└── README.md          # Bu dosya
```

## Production'a Hazırlık

1. .env dosyasında production ayarları yapın
2. Gerçek veritabanı bağlantısı ekleyin
3. SSL sertifikası kullanın
4. PM2 ile process management
5. Nginx reverse proxy
