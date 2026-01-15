# ROTA AI - Akıllı Seyahat Önerisi Uygulaması

## 📱 Proje Hakkında

ROTA AI, kullanıcıların seyahat tercihlerine göre kişiselleştirilmiş yer önerileri sunan bir mobil uygulamadır. Makine öğrenmesi algoritmaları kullanarak, kullanıcıların geçmiş ziyaretlerine ve değerlendirmelerine dayalı olarak akıllı öneriler oluşturur.

## 🎯 Özellikler

- **Kullanıcı Yönetimi**: Kayıt, giriş ve profil yönetimi
- **Şehir ve Yer Keşfi**: Türkiye ve KKTC'deki turistik yerleri keşfet
- **Akıllı Öneri Sistemi**: Python tabanlı makine öğrenmesi ile kişiselleştirilmiş öneriler
- **Ziyaret Geçmişi**: Geçmiş ziyaretleri takip et ve değerlendir
- **Puan Sistemi**: Ziyaret edilen yerlere puan ver
- **Duygu Durumu Entegrasyonu**: Kullanıcının ruh haline göre yer önerileri

## 🛠️ Teknolojiler

### Backend (C# - ASP.NET Core)
- **Framework**: ASP.NET Core Web API
- **Veritabanı**: SQL Server (LocalDB)
- **ORM**: Entity Framework Core
- **Mimari**: RESTful API, Service Layer Pattern
- **Makine Öğrenmesi**: Python ile entegre öneri sistemi

### Frontend (Flutter)
- **Framework**: Flutter (Dart)
- **Durum Yönetimi**: Provider
- **HTTP İstemcisi**: http package
- **Form Yönetimi**: flutter_form_builder
- **Yerel Depolama**: shared_preferences

### Python ML Modülü
- **Kütüphaneler**: pandas, numpy, scikit-learn
- **Veritabanı Bağlantısı**: pyodbc
- **Algoritma**: Collaborative Filtering

## 📂 Proje Yapısı

```
Teknofest-Rota-AI-Mobile-App/
├── RotaAI-Uygulama/
│   ├── RotaAI-backend/          # C# Backend API
│   │   └── TeknofestBackendCsharp/
│   │       ├── Controllers/      # API Endpoint'leri
│   │       ├── Services/         # İş mantığı katmanı
│   │       ├── Models/           # Veritabanı modelleri
│   │       ├── DTOs/             # Data Transfer Objects
│   │       ├── Data/             # DbContext ve seed data
│   │       └── PythonScripts/    # ML öneri sistemi
│   └── RotaAI-frontend/          # Flutter Mobile App
│       └── lib/
│           ├── auth/             # Giriş/Kayıt ekranları
│           ├── services/         # API servisleri
│           ├── providers/        # State management
│           ├── models/           # Veri modelleri
│           └── onboarding/       # Kullanıcı onboarding
```

## 🚀 Kurulum

### Backend Kurulumu

1. **Gereksinimler**
   - .NET 8.0 SDK
   - SQL Server LocalDB
   - Python 3.x

2. **Veritabanı Kurulumu**
```bash
cd RotaAI-Uygulama/RotaAI-backend/TeknofestBackendCsharp
dotnet ef database update
```

3. **Python Bağımlılıkları**
```bash
cd PythonScripts
pip install -r requirements.txt
```

4. **Backend Çalıştırma**
```bash
dotnet run
```
API: `https://localhost:5001`

### Frontend Kurulumu

1. **Gereksinimler**
   - Flutter SDK (3.7.2+)
   - Android Studio / VS Code

2. **Bağımlılık Yüklemesi**
```bash
cd RotaAI-Uygulama/RotaAI-frontend
flutter pub get
```

3. **Uygulama Çalıştırma**
```bash
flutter run
```

## 📊 Veritabanı Modeli

- **User**: Kullanıcı bilgileri ve kimlik doğrulama
- **City**: Şehir bilgileri (Türkiye ve KKTC)
- **Place**: Turistik yerler ve detayları
- **VisitedPlace**: Kullanıcı ziyaret geçmişi ve puanları

## 🔗 API Endpoint'leri

- `POST /api/user/register` - Kullanıcı kaydı
- `POST /api/user/login` - Kullanıcı girişi
- `GET /api/city` - Şehir listesi
- `GET /api/place/city/{cityId}` - Şehre göre yerler
- `GET /api/visitedplace/history` - Ziyaret geçmişi
- `POST /api/visitedplace` - Ziyaret kaydet
- `GET /api/placerecommendation` - AI tabanlı öneriler

## 🎨 Uygulama Ekranları

- Splash Screen
- Login/Register
- Ana Sayfa (Duygu durumu seçimi)
- Ülke/Şehir Seçimi
- Yer Detayları
- Öneri Sistemi
- Ziyaret Geçmişi
- Profil Yönetimi

<img width="300" alt="image" src="https://github.com/user-attachments/assets/7d18c982-f098-4ab4-bfe1-9a273af8cdae" />
<img width="300" alt="image" src="https://github.com/user-attachments/assets/f4a75648-4642-4b99-95f2-516dec4c0740" />
<img width="300" alt="image" src="https://github.com/user-attachments/assets/f5734b52-217e-4cb8-916a-b1e2fcb518c1" />
<img width="300" alt="image" src="https://github.com/user-attachments/assets/48b07475-561b-4b38-af4f-ece6e182c3c3" />


## 🤖 Öneri Sistemi

Sistem, kullanıcıların geçmiş ziyaretlerini ve verdikleri puanları analiz ederek benzer tercihlere sahip kullanıcıların beğendiği yerleri önerir. Python'da geliştirilen makine öğrenmesi modülü, ASP.NET Core backend ile entegre çalışarak gerçek zamanlı öneriler sunar.
