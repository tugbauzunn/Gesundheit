# Bakım Düzeyi Artışı Mobil Uygulaması

Bu Flutter uygulaması, bakım düzeyi artışı başvurularını yönetmek için geliştirilmiştir.

## Özellikler

### ✅ Tamamlanan Özellikler

- **Ana Sayfa**: Basit ve temiz tasarım, sadece bakım düzeyi artış başvurusu için buton
- **Bakım Düzeyi Artışı Formu**: 
  - Mevcut bakım düzeyi seçimi (Pflegegrad 1-5)
  - İstenen bakım düzeyi seçimi 
  - Artış nedeni açıklama alanı
  - Form doğrulama ve gönderim
- **Responsive Tasarım**: Mobil ve web uyumlu arayüz

### 📋 Sayfa Yapısı

1. **Ana Sayfa (HomeScreen)**
   - Uygulama logosu
   - Ana başlık ve açıklama
   - "Başvuru Yap" butonu
   - Bilgi kartı

2. **Bakım Düzeyi Artışı (CareLevelRequestScreen)**
   - Mevcut bakım düzeyi dropdown'u
   - İstenen bakım düzeyi dropdown'u
   - Artış nedeni metin alanı
   - Form validasyonu
   - API entegrasyonu hazır

## Teknik Yapı

### Klasör Yapısı
```
lib/
├── main.dart                 # Ana uygulama dosyası
├── models/
│   └── care_level_request.dart  # Veri modeli
├── screens/
│   ├── main_navigation_screen.dart  # Ana navigasyon
│   ├── home_screen.dart            # Ana sayfa
│   └── care_level_request_screen.dart  # Form sayfası
└── services/
    └── api_service.dart           # API servis katmanı
```

### Kullanılan Paketler
- `http: ^1.1.0` - REST API iletişimi
- `uuid: ^4.2.1` - Benzersiz ID oluşturma
- `provider: ^6.1.1` - State management
- `table_calendar: ^3.0.9` - Takvim bileşenleri
- `intl: ^0.19.0` - Uluslararasılaştırma

## API Entegrasyonu

### Endpoint'ler
- `POST /api/care-level-request` - Yeni başvuru gönderme
- `GET /api/care-level-request/:id` - Başvuru durumu sorgulama

### Veri Modeli
```json
{
  "id": "uuid",
  "current_level": 2,
  "desired_level": 3,
  "reason": "Mehr Pflegebedarf",
  "created_at": "2025-09-02T09:40:00Z",
  "status": "pending"
}
```

## Kurulum ve Çalıştırma

### Gereksinimler
- Flutter SDK (3.8.1 veya üzeri)
- Dart SDK
- Web browser (Chrome/Edge) veya Android/iOS emulator

### Kurulum
```bash
# Bağımlılıkları yükleyin
flutter pub get

# Uygulamayı çalıştırın
flutter run
```

### Platform Seçimi
Uygulama çalıştırıldığında şu seçenekler sunulur:
- Windows (desktop)
- Chrome (web)
- Edge (web)

## Geliştirme Durumu

### 🟢 Tamamlanan
- [x] Temel uygulama yapısı
- [x] Basitleştirilmiş navigasyon sistemi
- [x] Ana sayfa tasarımı
- [x] Bakım düzeyi artışı formu
- [x] Form validasyonu
- [x] API servis katmanı
- [x] Responsive tasarım

### 🟡 Devam Eden
- [ ] Backend API implementasyonu
- [ ] Gerçek API bağlantısı

### 🔴 Planlanan
- [ ] Kullanıcı kimlik doğrulama
- [ ] Başvuru durumu takibi
- [ ] Push bildirimleri
- [ ] Dosya yükleme özelliği
- [ ] Çoklu dil desteği
- [ ] Offline mod
