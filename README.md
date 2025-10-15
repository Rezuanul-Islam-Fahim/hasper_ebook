<div align="center">

# 📚 Hasper EBook

**A modern, feature-rich E-Book mobile application for Android & iOS devices**

Built with ❤️ using Dart & Flutter

<img width="80%" src="screenshots/banner.png">

[![Flutter Version](https://img.shields.io/badge/Flutter-3.5.0+-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart Version](https://img.shields.io/badge/Dart-3.5.0+-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![Firebase](https://img.shields.io/badge/Firebase-Integrated-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)](https://firebase.google.com)
[![License](https://img.shields.io/github/license/rezuanul-islam-fahim/hasper_ebook?style=for-the-badge)](https://github.com/Rezuanul-Islam-Fahim/hasper_ebook/blob/master/LICENSE)

### 🎯 [Try Live Demo on Appetize.io](https://appetize.io/app/ikmj7hvoajtcaceafqydx7jhcm)

[![GitHub stars](https://img.shields.io/github/stars/rezuanul-islam-fahim/hasper_ebook?style=social)](https://github.com/Rezuanul-Islam-Fahim/hasper_ebook/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/rezuanul-islam-fahim/hasper_ebook?style=social)](https://github.com/Rezuanul-Islam-Fahim/hasper_ebook/network/members)
[![GitHub watchers](https://img.shields.io/github/watchers/rezuanul-islam-fahim/hasper_ebook?style=social)](https://github.com/Rezuanul-Islam-Fahim/hasper_ebook/watchers)

</div>

---

## 📖 Table of Contents

- [About](#about)
- [Features](#features)
- [Screenshots](#screenshots)
- [Tech Stack](#tech-stack)
- [Architecture](#architecture)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Firebase Configuration](#firebase-configuration)
  - [Running the App](#running-the-app)
- [Project Structure](#project-structure)
- [Building for Production](#building-for-production)
- [Contributing](#contributing)
- [Roadmap](#roadmap)
- [License](#license)
- [Contact](#contact)

---

## 🎯 About

**Hasper EBook** is a comprehensive digital library application that provides users with seamless access to a vast collection of e-books. With an elegant and intuitive interface, users can browse, search, and read their favorite books directly on their mobile devices. The app leverages Firebase's real-time database capabilities to deliver a dynamic and responsive reading experience.

### Key Highlights

- 📱 **Cross-Platform**: Native performance on both Android and iOS
- ☁️ **Cloud-Powered**: Real-time synchronization with Firebase Firestore
- 🎨 **Beautiful UI**: Modern and clean Material Design interface
- 📄 **Advanced PDF Reader**: Powered by Syncfusion's professional PDF viewer
- 🔍 **Smart Search**: Quickly find books by title, author, or language
- ♾️ **Infinite Scrolling**: Seamless browsing experience with pagination
- 🌐 **Multi-Language Support**: Books available in multiple languages

---

## ✨ Features

### 📚 Core Features

- **Browse Books**: Explore a comprehensive collection of e-books with beautiful cover displays
- **Book Details**: View detailed information including title, description, language, and page count
- **PDF Reader**: Read books with a professional, feature-rich PDF viewer
- **Search Functionality**: Find books quickly using the integrated search system
- **Categorization**: Books organized by language and categories
- **Infinite Scroll**: Load more books automatically as you scroll
- **Bookmarking**: Keep track of your reading progress
- **Responsive Design**: Adapts perfectly to different screen sizes

### 🎨 UI/UX Features

- **Material Design**: Modern and intuitive user interface
- **Custom Theme**: Carefully crafted color scheme and typography
- **Smooth Animations**: Fluid transitions and interactions
- **Drawer Navigation**: Easy access to different sections
- **Cover Photo Grid**: Visually appealing book display

### ⚡ Technical Features

- **State Management**: Efficient state management using Provider
- **Real-time Database**: Firebase Firestore for live data synchronization
- **Lazy Loading**: Optimized performance with infinite scroll pagination
- **SVG Support**: High-quality vector graphics rendering
- **Offline Capability**: Local caching for improved performance

---

## 📸 Screenshots

<div align="center">

<p>
  <img height="510px" src="screenshots/screenshot1.jpg"> &nbsp;
  <img height="510px" src="screenshots/screenshot2.jpg"> &nbsp;
  <img height="510px" src="screenshots/screenshot3.jpg">
</p>

<p>
  <img height="510px" src="screenshots/screenshot4.jpg"> &nbsp;
  <img height="510px" src="screenshots/screenshot5.jpg">
</p>

</div>

---

## 🛠️ Tech Stack

### Frontend
- **Flutter** `^3.5.0` - Cross-platform UI framework
- **Dart** `^3.5.0` - Programming language

### Backend & Services
- **Firebase Core** `^3.15.0` - Firebase SDK for Flutter
- **Cloud Firestore** `^5.6.0` - NoSQL cloud database

### State Management
- **Provider** `^6.1.2` - State management solution

### PDF Viewing
- **Syncfusion Flutter PDFViewer** `^28.2.12` - Professional PDF rendering

### UI & Graphics
- **Flutter SVG** `^2.0.16` - SVG rendering support
- **Cupertino Icons** `^1.0.8` - iOS-style icons

### Pagination
- **Infinite Scroll Pagination** `^4.1.0` - Efficient list loading

---

## 🏗️ Architecture

The application follows a clean architecture pattern with clear separation of concerns:

```
lib/
├── components/          # Reusable UI components
│   ├── book_item.dart
│   └── drawer.dart
├── models/             # Data models
│   └── book.dart
├── providers/          # State management
│   └── books_provider.dart
├── repositories/       # Data access layer
│   └── db_repository.dart
├── screens/           # Application screens
│   ├── home_screen/
│   ├── book_details_screen/
│   ├── all_book_screen/
│   └── pdf_screen.dart
├── utils/             # Utility functions
│   └── search.dart
├── firebase_options.dart
├── main.dart          # Entry point
├── routes.dart        # Route definitions
├── styles.dart        # Style constants
└── theme.dart         # App theme
```

### Design Patterns

- **Provider Pattern**: For state management and dependency injection
- **Repository Pattern**: Abstracts data sources (Firestore)
- **Factory Pattern**: Used in model constructors for object creation
- **Singleton Pattern**: Firebase instance management

---

## 🚀 Getting Started

### Prerequisites

Before you begin, ensure you have the following installed:

- **Flutter SDK** (3.5.0 or higher) - [Install Flutter](https://flutter.dev/docs/get-started/install)
- **Dart SDK** (3.5.0 or higher) - Included with Flutter
- **Android Studio** or **VS Code** with Flutter extensions
- **Xcode** (for iOS development, macOS only)
- **Firebase CLI** - [Install Firebase CLI](https://firebase.google.com/docs/cli)
- **Git** - [Install Git](https://git-scm.com/downloads)

### Installation

1. **Clone the repository**

```bash
git clone https://github.com/Rezuanul-Islam-Fahim/hasper_ebook.git
cd hasper_ebook
```

2. **Install dependencies**

```bash
flutter pub get
```

3. **Verify Flutter installation**

```bash
flutter doctor
```

Fix any issues reported by Flutter Doctor before proceeding.

### Firebase Configuration

This project uses Firebase Firestore for data storage. Follow these steps:

1. **Create a Firebase Project**
   - Go to [Firebase Console](https://console.firebase.google.com/)
   - Click "Add Project" and follow the setup wizard
   - Enable Cloud Firestore in the Firebase console

2. **Register your apps**
   - Add Android app with package name: `com.rezuanulfahim.hasperEbook`
   - Add iOS app with bundle ID: `com.rezuanulfahim.hasperEbook`
   - Download and add `google-services.json` to `android/app/`
   - Download and add `GoogleService-Info.plist` to `ios/Runner/`

3. **Configure FlutterFire**

```bash
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure Firebase for your Flutter project
flutterfire configure
```

4. **Firestore Database Structure**

Create a collection named `books` with the following structure:

```json
{
  "title": "Book Title",
  "coverPhotoUrl": "https://example.com/cover.jpg",
  "pdfUrl": "https://example.com/book.pdf",
  "language": "English",
  "pages": 250,
  "description": "Book description here...",
  "dateTime": "2025-01-01T00:00:00.000Z"
}
```

5. **Firestore Security Rules**

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /books/{book} {
      allow read: if true;  // Public read access
      allow write: if false; // Only admins can write
    }
  }
}
```

### Running the App

1. **Connect a device or start an emulator**

```bash
# List available devices
flutter devices

# Start an Android emulator
flutter emulators --launch <emulator_id>

# Start an iOS simulator (macOS only)
open -a Simulator
```

2. **Run the app**

```bash
# Run in debug mode
flutter run

# Run on a specific device
flutter run -d <device_id>

# Run in release mode
flutter run --release
```

3. **Hot Reload**

While the app is running, press:
- `r` - Hot reload
- `R` - Hot restart
- `q` - Quit

---

## 📁 Project Structure

```
hasper_ebook/
├── android/                 # Android native code
├── ios/                     # iOS native code
├── lib/                     # Dart application code
│   ├── components/         # Reusable widgets
│   ├── models/             # Data models
│   ├── providers/          # State management
│   ├── repositories/       # Data layer
│   ├── screens/            # UI screens
│   ├── utils/              # Helper functions
│   └── main.dart           # App entry point
├── assets/                  # Static assets
│   └── icons/              # App icons
├── screenshots/            # App screenshots
├── web/                    # Web platform support
├── pubspec.yaml            # Dependencies
├── firebase.json           # Firebase configuration
└── README.md               # This file
```

---

## 📦 Building for Production

### Android

1. **Configure signing**

Create `android/key.properties`:

```properties
storePassword=<your-store-password>
keyPassword=<your-key-password>
keyAlias=<your-key-alias>
storeFile=<path-to-keystore>
```

2. **Build APK**

```bash
flutter build apk --release
```

3. **Build App Bundle** (recommended for Play Store)

```bash
flutter build appbundle --release
```

Output: `build/app/outputs/bundle/release/app-release.aab`

### iOS

1. **Open Xcode workspace**

```bash
open ios/Runner.xcworkspace
```

2. **Configure signing in Xcode**
   - Select Runner target
   - Go to Signing & Capabilities
   - Select your team and provisioning profile

3. **Build IPA**

```bash
flutter build ipa --release
```

4. **Archive and upload** to App Store via Xcode

---

## 🤝 Contributing

Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

### How to Contribute

1. **Fork the Project**
2. **Create your Feature Branch** (`git checkout -b feature/AmazingFeature`)
3. **Commit your Changes** (`git commit -m 'Add some AmazingFeature'`)
4. **Push to the Branch** (`git push origin feature/AmazingFeature`)
5. **Open a Pull Request**

### Code Style

- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines
- Use meaningful variable and function names
- Add comments for complex logic
- Keep functions small and focused
- Write unit tests for new features

### Reporting Bugs

If you find a bug, please create an issue with:
- Clear title and description
- Steps to reproduce
- Expected vs actual behavior
- Screenshots if applicable
- Device and OS information

---

## 🗺️ Roadmap

### Current Version (v1.1.1)
- ✅ Browse books with infinite scroll
- ✅ View book details
- ✅ Read PDFs in-app
- ✅ Search functionality
- ✅ Firebase Firestore integration

### Planned Features

- [ ] **User Authentication**
  - User login and registration
  - Personal reading lists
  - Reading history
  
- [ ] **Enhanced Reading Experience**
  - Bookmarks and annotations
  - Night mode/Dark theme
  - Adjustable font sizes
  - Reading progress tracking
  
- [ ] **Social Features**
  - Book ratings and reviews
  - Share favorite books
  - User profiles
  
- [ ] **Content Management**
  - Categories and genres
  - Favorites collection
  - Download books for offline reading
  
- [ ] **Personalization**
  - Reading recommendations
  - Recently viewed books
  - Customizable themes

- [ ] **Admin Panel**
  - Web-based content management
  - Upload and manage books
  - Analytics dashboard

See the [open issues](https://github.com/Rezuanul-Islam-Fahim/hasper_ebook/issues) for a full list of proposed features and known issues.

---

## 📄 License

Distributed under the MIT License. See `LICENSE` file for more information.

```
MIT License

Copyright (c) 2022-2025 Rezuanul Islam Fahim

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

## 👤 Contact

**Rezuanul Islam Fahim**

- GitHub: [@Rezuanul-Islam-Fahim](https://github.com/Rezuanul-Islam-Fahim)
- Project Link: [https://github.com/Rezuanul-Islam-Fahim/hasper_ebook](https://github.com/Rezuanul-Islam-Fahim/hasper_ebook)

---

## 🙏 Acknowledgments

- [Flutter](https://flutter.dev) - The amazing UI framework
- [Firebase](https://firebase.google.com) - Backend infrastructure
- [Syncfusion](https://www.syncfusion.com/flutter-widgets) - PDF viewer component
- [Material Design](https://material.io) - Design system
- All contributors who help improve this project

---

<div align="center">

### ⭐ Star this repository if you find it helpful!

**Made with ❤️ and Flutter**

</div>