const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const compression = require('compression');
const rateLimit = require('express-rate-limit');
const multer = require('multer');
const path = require('path');
const fs = require('fs-extra');
const { v4: uuidv4 } = require('uuid');

const app = express();
const PORT = process.env.PORT || 3000;

// Uploads klasörünü oluştur
const uploadsDir = path.join(__dirname, 'uploads');
fs.ensureDirSync(uploadsDir);

// Middleware
app.use(helmet());
app.use(compression());
app.use(cors({
  origin: true, // Tüm originlere izin ver
  credentials: true,
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
  allowedHeaders: ['Content-Type', 'Authorization', 'Accept', 'Origin', 'X-Requested-With'],
  optionsSuccessStatus: 200
}));

// Rate limiting
const limiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 dakika
  max: 100 // Her IP için maksimum 100 istek
});
app.use(limiter);

// JSON ve URL encoded data için
app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ extended: true, limit: '10mb' }));

// Request logging
app.use((req, res, next) => {
  console.log(`🔄 ${req.method} ${req.path} - ${new Date().toISOString()}`);
  next();
});

// Multer konfigürasyonu - PDF dosyaları için
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, uploadsDir);
  },
  filename: function (req, file, cb) {
    // Benzersiz dosya adı oluştur
    const uniqueName = `${uuidv4()}-${Date.now()}${path.extname(file.originalname)}`;
    cb(null, uniqueName);
  }
});

// Dosya filtreleme - sadece PDF
const fileFilter = (req, file, cb) => {
  console.log('Yüklenen dosya bilgisi:', {
    originalname: file.originalname,
    mimetype: file.mimetype,
    fieldname: file.fieldname
  });
  
  // PDF kontrolü - hem mimetype hem de dosya uzantısı
  const isPdf = file.mimetype === 'application/pdf' || 
                file.originalname.toLowerCase().endsWith('.pdf');
  
  if (isPdf) {
    cb(null, true);
  } else {
    cb(new Error('Sadece PDF dosyaları kabul edilir!'), false);
  }
};

const upload = multer({
  storage: storage,
  fileFilter: fileFilter,
  limits: {
    fileSize: 10 * 1024 * 1024 // 10MB limit
  }
});

// Bakım düzeyi istekleri için basit hafıza deposu (production'da veritabanı kullanın)
let careLevelRequests = [];

// Ana endpoint
app.get('/', (req, res) => {
  res.json({
    message: 'Health Care Backend API',
    version: '1.0.0',
    endpoints: {
      'POST /api/care-level-request': 'Yeni bakım düzeyi talebi oluştur',
      'GET /api/care-level-request/:id': 'Bakım düzeyi talebini getir',
      'GET /api/care-level-requests': 'Tüm talepleri listele',
      'POST /api/upload-pdf': 'PDF dosyası yükle',
      'GET /api/download-pdf/:filename': 'PDF dosyasını indir',
      'DELETE /api/delete-pdf/:filename': 'PDF dosyasını sil'
    }
  });
});

// PDF dosyası yükleme
app.options('/api/upload-pdf', cors()); // Preflight request için
app.post('/api/upload-pdf', upload.single('pdf'), (req, res) => {
  console.log('📨 POST /api/upload-pdf request alındı');
  console.log('🔍 Request headers:', req.headers);
  console.log('🔍 Request body keys:', Object.keys(req.body));
  
  try {
    if (!req.file) {
      console.log('❌ Dosya bulunamadı');
      return res.status(400).json({
        success: false,
        message: 'PDF dosyası bulunamadı'
      });
    }

    console.log('✅ Dosya başarıyla alındı:', req.file.originalname);
    const fileInfo = {
      id: uuidv4(),
      originalName: req.file.originalname,
      filename: req.file.filename,
      size: req.file.size,
      uploadDate: new Date().toISOString(),
      path: req.file.path
    };

    console.log('📤 Response gönderiliyor:', fileInfo);
    res.json({
      success: true,
      message: 'PDF dosyası başarıyla yüklendi',
      file: fileInfo
    });

  } catch (error) {
    console.error('❌ PDF yükleme hatası:', error);
    res.status(500).json({
      success: false,
      message: 'Dosya yüklenirken hata oluştu',
      error: error.message
    });
  }
});

// PDF dosyası indirme
app.get('/api/download-pdf/:filename', (req, res) => {
  try {
    const filename = req.params.filename;
    const filePath = path.join(uploadsDir, filename);

    // Dosya varlığını kontrol et
    if (!fs.existsSync(filePath)) {
      return res.status(404).json({
        success: false,
        message: 'PDF dosyası bulunamadı'
      });
    }

    // Güvenlik kontrolü - sadece uploads klasöründeki dosyalar
    if (!filePath.startsWith(uploadsDir)) {
      return res.status(403).json({
        success: false,
        message: 'Erişim reddedildi'
      });
    }

    // PDF dosyasını gönder
    res.setHeader('Content-Type', 'application/pdf');
    res.setHeader('Content-Disposition', `attachment; filename="${filename}"`);
    res.sendFile(filePath);

  } catch (error) {
    console.error('PDF indirme hatası:', error);
    res.status(500).json({
      success: false,
      message: 'Dosya indirilirken hata oluştu',
      error: error.message
    });
  }
});

// PDF dosyası silme
app.delete('/api/delete-pdf/:filename', (req, res) => {
  try {
    const filename = req.params.filename;
    const filePath = path.join(uploadsDir, filename);

    // Dosya varlığını kontrol et
    if (!fs.existsSync(filePath)) {
      return res.status(404).json({
        success: false,
        message: 'PDF dosyası bulunamadı'
      });
    }

    // Güvenlik kontrolü
    if (!filePath.startsWith(uploadsDir)) {
      return res.status(403).json({
        success: false,
        message: 'Erişim reddedildi'
      });
    }

    // Dosyayı sil
    fs.unlinkSync(filePath);

    res.json({
      success: true,
      message: 'PDF dosyası başarıyla silindi'
    });

  } catch (error) {
    console.error('PDF silme hatası:', error);
    res.status(500).json({
      success: false,
      message: 'Dosya silinirken hata oluştu',
      error: error.message
    });
  }
});

// Yeni bakım düzeyi talebi oluştur
app.post('/api/care-level-request', (req, res) => {
  try {
    const request = {
      id: uuidv4(),
      ...req.body,
      createdAt: new Date().toISOString(),
      status: 'pending'
    };

    careLevelRequests.push(request);

    res.status(201).json({
      success: true,
      message: 'Bakım düzeyi talebi başarıyla oluşturuldu',
      data: request
    });

  } catch (error) {
    console.error('Talep oluşturma hatası:', error);
    res.status(500).json({
      success: false,
      message: 'Talep oluşturulurken hata oluştu',
      error: error.message
    });
  }
});

// Çoğul endpoint - Flutter app ile uyumluluk için
app.post('/api/care-level-requests', (req, res) => {
  try {
    const request = {
      id: uuidv4(),
      ...req.body,
      createdAt: new Date().toISOString(),
      status: 'pending'
    };

    careLevelRequests.push(request);

    res.status(201).json({
      success: true,
      message: 'Bakım düzeyi talebi başarıyla oluşturuldu',
      data: request
    });

  } catch (error) {
    console.error('Talep oluşturma hatası:', error);
    res.status(500).json({
      success: false,
      message: 'Talep oluşturulurken hata oluştu',
      error: error.message
    });
  }
});

// Bakım düzeyi talebini getir
app.get('/api/care-level-request/:id', (req, res) => {
  try {
    const requestId = req.params.id;
    const request = careLevelRequests.find(r => r.id === requestId);

    if (!request) {
      return res.status(404).json({
        success: false,
        message: 'Talep bulunamadı'
      });
    }

    res.json({
      success: true,
      data: request
    });

  } catch (error) {
    console.error('Talep getirme hatası:', error);
    res.status(500).json({
      success: false,
      message: 'Talep getirilirken hata oluştu',
      error: error.message
    });
  }
});

// Tüm talepleri listele
app.get('/api/care-level-requests', (req, res) => {
  try {
    res.json({
      success: true,
      data: careLevelRequests,
      count: careLevelRequests.length
    });

  } catch (error) {
    console.error('Talepleri listeleme hatası:', error);
    res.status(500).json({
      success: false,
      message: 'Talepler listelenirken hata oluştu',
      error: error.message
    });
  }
});

// Yüklenen dosyaları listele
app.get('/api/uploaded-files', (req, res) => {
  try {
    const files = fs.readdirSync(uploadsDir)
      .filter(file => file.endsWith('.pdf'))
      .map(filename => {
        const filePath = path.join(uploadsDir, filename);
        const stats = fs.statSync(filePath);
        return {
          filename,
          size: stats.size,
          uploadDate: stats.birthtime,
          downloadUrl: `/api/download-pdf/${filename}`
        };
      });

    res.json({
      success: true,
      files,
      count: files.length
    });

  } catch (error) {
    console.error('Dosya listeleme hatası:', error);
    res.status(500).json({
      success: false,
      message: 'Dosyalar listelenirken hata oluştu',
      error: error.message
    });
  }
});

// Error handling middleware
app.use((error, req, res, next) => {
  if (error instanceof multer.MulterError) {
    if (error.code === 'LIMIT_FILE_SIZE') {
      return res.status(400).json({
        success: false,
        message: 'Dosya boyutu çok büyük (maksimum 10MB)'
      });
    }
  }
  
  console.error('Sunucu hatası:', error);
  res.status(500).json({
    success: false,
    message: 'Sunucu hatası oluştu',
    error: error.message
  });
});

// 404 handler
app.use('*', (req, res) => {
  res.status(404).json({
    success: false,
    message: 'Endpoint bulunamadı'
  });
});

// Sunucuyu başlat
app.listen(PORT, () => {
  console.log(`🚀 Health Care Backend Server çalışıyor: http://localhost:${PORT}`);
  console.log(`📁 PDF dosyaları saklanacak klasör: ${uploadsDir}`);
  console.log(`🔗 API Documentation: http://localhost:${PORT}`);
});

module.exports = app;
