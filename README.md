# SaveInsight – Personal Knowledge App

SaveInsight is a Flutter-based Android application developed as part of an **Academic Learning Activity (ALA)**.  
The application demonstrates **REST API integration**, **JSON parsing**, and **data display using ListView** with clean and professional UI design.

---

## 📌 Project Objective

The main objective of this project is to:
- Integrate a public REST API in a Flutter application
- Fetch and parse JSON data
- Display dynamic content using `ListView.builder`
- Navigate between screens in a structured manner

---

## 🛠 Tech Stack

- **Framework:** Flutter
- **Language:** Dart
- **API:** DummyJSON (Public REST API)
- **HTTP Client:** http package
- **UI Components:** Material Design

---

## 🌐 REST API Used

**DummyJSON Posts API**
https://dummyjson.com/posts

The API provides readable, article-like content which is used as sample insights in the application.

---

## ✨ Features Implemented (Phase 1 – ALA)

- Splash screen with branding
- Custom app logo and typography
- Fetching data from REST API
- Parsing JSON into Dart model classes
- Displaying content using `ListView.builder`
- Detail screen for viewing full content
- Clean and minimalist UI
- Proper folder structure and separation of concerns

---

## 📱 Application Screens

### Splash Screen
- Displays app logo and name
- Automatically navigates to Home Screen

### Home Screen
- Displays list of insights fetched from REST API
- Each item shows title and short preview

### Detail Screen
- Displays full title and body of selected insight

---

## 📂 Project Structure
lib/ ├── main.dart ├── screens/ │   ├── splash_screen.dart │   ├── home_screen.dart │   └── detail_screen.dart ├── models/ │   └── insight.dart ├── services/ │   └── api_service.dart └── theme/ └── app_colors.dart
Copy code

---

## ▶️ How to Run the Project

1. Clone the repository
2. Open the project in Android Studio
3. Run the following command:
   flutter pub get
   Copy code

4. Connect an emulator or physical device
5. Click **Run**

---

## 🚀 Future Scope

- Save insights locally
- Share content from other apps
- OCR-based text extraction
- Folder and tag-based organization
- Cloud synchronization
- User authentication

---

## 🎓 Academic Note

This project is developed **individually** as part of an Academic Learning Activity (ALA) and fulfills all required criteria including REST API integration and dynamic UI rendering.

---

## 👤 Author

- Name: Krunal Rathod
- Course: B.Tech (CSE)
- Enrollment no: 20230905050032