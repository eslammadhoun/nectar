# 🥕 Nectar - Online Groceries App

**Nectar** is a modern, fully functional online grocery shopping application built with Flutter. It features a clean, premium UI designed for an optimal user experience, backed by Firebase for authentication and data management.

## 📱 Features

- **Authentication**: Secure Login and Sign Up using Firebase Auth.
- **Shop & Explore**: Browse products by categories, view exclusive offers, and best-selling items.
- **Product Details**: Detailed view of products with descriptions, pricing, and related items.
- **Cart Management**: Add items to cart, view total price, and manage quantities.
- **Favorites**: Save your favorite items for quick access.
- **Location Services**: Automatic user location detection using Geolocation and Geoapify.
- **Account Management**: User profile and settings.

## 🛠 Tech Stack & Architecture

This project follows the **MVVM (Model-View-ViewModel)** architecture pattern with a Repository layer for clean data handling.

- **Framework**: Flutter (Dart)
- **State Management**: Provider
- **Backend**: Firebase (Firestore, Authentication)
- **API Integration**:
  - **http** for REST API calls.
  - Geoapify for reverse geocoding.
  - CountryStateCity API for location data.
- **Architecture**:
  - **Core**: Theming, Constants, Helpers.
  - **Data**: Models, Repositories, Services.
  - **Features**: UI Views and ViewModels (Business Logic).

## 📂 Project Structure

```
lib/
├── V2/
│   ├── Core/           # Theme, Utils, Helpers
│   ├── Data/           # Models, Repositories, Services
│   └── features/       # Feature-based folders (View + ViewModel)
│       ├── account/
│       ├── cart/
│       ├── home/
│       ├── shop/
│       └── ...
└── main.dart           # Entry point
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK installed (Version 3.7.0 or higher)
- Dart SDK installed
- Android Studio / VS Code with Flutter extensions

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/eslammadhoun/nectar
   cd nectar
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Setup**
   - Create a new project in the [Firebase Console](https://console.firebase.google.com/).
   - Configure Android and iOS apps.
   - Download `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) and place them in their respective folders.

4. **API Configuration**
   - This app uses **Geoapify** and **CountryStateCity** APIs.

5. **Run the App**
   ```bash
   flutter run
   ```

### 📄 CopyWrite
    - **ALL RIGHTS RESERVED To ESLAM MADHOUN 2025**
    - **Software Enginer**
