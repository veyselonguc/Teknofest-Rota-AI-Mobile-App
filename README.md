# 📍 RotaAI Mobile App

### 🌐 Overview (EN)
RotaAI is an AI-powered mobile application developed for the 2025 TEKNOFEST Technology Competition, where it became a semi-finalist in the Tourism category. The app suggests personalized historical travel routes based on the user's visit history and ratings.

The AI recommendation system, developed in Python, analyzes a user's previous visits and suggests the top 5 most relevant new destinations. As part of the data, we used web scraping to collect real Google reviews of historical places.

🧭 The app also includes:
🇹🇷 Informational pages about Turkey and TRNC (history, geography, culture)
🍽️ Traditional Dishes page introducing regional foods and desserts
🧠 A “Did You Know?” section on the homepage that presents surprising facts about historical sites
The app is connected to a database and requires user login for personalized functionality.

### 🇹🇷 Proje Özeti (TR)
📱 RotaAI, kullanıcıların geçmiş ziyaretlerini puanlamasıyla çalışan yapay zeka destekli bir rota öneri mobil uygulamasıdır.
2025 TEKNOFEST yarışması TURİZM kategorisinde yarı finalist olduk. Sistem, Python tabanlı öneri motoruyla kullanıcının geçmiş gezilerine göre en uygun 5 yeni noktayı önerir.

Web scraping yöntemi ile Google yorumlarından veri toplayarak tarihi yerlerin kullanıcı yorumlarını elde ettik ve öneri sisteminde örnek veri olarak kullandık.

📌 Ek olarak uygulamada şu bölümler yer alır:
🇹🇷 Türkiye ve KKTC hakkında tanıtım sayfaları (tarih, kültür, coğrafya)
🍽️ Yöresel tatlar sayfası (yemek/tatlı tanıtımları)
🧠 Ana sayfada “Bunları biliyor muydunuz?” alanı (ilginç bilgiler)
Uygulama kullanıcı girişi ile çalışmakta ve veritabanına bağlıdır.

### 🛠️ Technologies Used
Flutter (Frontend – Mobile)
ASP.NET Core (Backend & API)
Python (AI-based recommendation system)
Web Scraping (Google Reviews)
JSON (Data exchange)
MSSQL (Database)
💡 AI Recommendation System
Developed in Python using content-based filtering (TF-IDF + Cosine Similarity)
Takes user visit history and ratings (0–5) as input
Suggests the top 5 most similar historical places
Includes sentiment analysis on review data (Positive / Neutral / Negative)

## 🚀 Getting Started
⚠️ Important Note: For the project to run properly, first start the backend (ASP.NET Core API). The backend program must remain running while you run the Flutter app to ensure the app can communicate with it.

### 📦 1. Clone the Project
git clone https://github.com/AhmetFurkanRsbr/RotaAI-MobileApp.git

### 🗃️ 2. Restore MSSQL Database (rotaai_demo.bacpac)
- Open SQL Server Management Studio (SSMS)
- Right-click on "Databases" → "Import Data-tier Application"
- Select `rotaai_demo.bacpac` and complete the wizard

### Open the project in your preferred IDE (e.g., VS Code or Android Studio)

### 🤖 3. Run the AI Recommendation System (Python Backend)
cd RotaAI-backend/TeknofestBackendCsharp/PythonScripts

### Install dependencies
pip install -r requirements.txt

### 🛠️ 4. Run the Backned (asp.net API Backend)
cd ..
cd ..
dotnet run

### 📱 5. Run the Flutter App
# Go back to root folder
cd ..
cd .\RotaAI-frontend\

### Install Flutter dependencies
flutter pub get

### Run the app
flutter run
