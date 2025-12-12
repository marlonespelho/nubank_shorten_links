# Nubank Shorten Links

Flutter application for shortening links, developed as a technical test for Nubank.

## 📋 Description

This project is a mobile application developed in Flutter that allows users to shorten long URLs. The application supports multiple languages (Portuguese and English) and uses modular architecture with state management using MobX.

## 🛠️ Prerequisites

Before you begin, make sure you have installed:

- **Flutter SDK**
  - Check installation: `flutter --version`
  - Installation instructions: [Flutter Install](https://docs.flutter.dev/get-started/install)
- **Dart SDK** (included with Flutter)
- **Android Studio** or **VS Code** with Flutter extensions

### For Android development:
- Android SDK
- Android Studio or Android SDK Command-line Tools

### For iOS development (macOS only):
- Xcode
- CocoaPods

## 🚀 Installation

1. **Install dependencies:**
   ```bash
   flutter pub get
   ```

2. **Generate code files:**
   
   The project uses code generation for MobX and translations. Run the following commands:
   
   ```bash
   # Generate MobX code
   flutter pub run build_runner build --delete-conflicting-outputs
   
   # Generate translation files
   flutter pub run intl_utils:generate
   ```

## ▶️ How to Run

### Run on device/emulator:

1. **Check available devices:**
   ```bash
   flutter devices
   ```

2. **Run the application:**
   ```bash
   flutter run
   ```

## 🧪 Testing

```bash
# Run unit tests
flutter test

# Run integration tests
flutter test integration_test/
```

## 📁 Project Structure

```
lib/
├── assets/              # Static resources (images)
├── generated/           # Automatically generated files
│   ├── intl/           # Generated translation files
│   └── l10n.dart       # Localization class
├── l10n/               # Translation files (.arb)
├── main.dart           # Application entry point
└── modules/
    ├── core/           # Core module (configurations, HTTP, etc)
    ├── design/         # Reusable UI components
    └── link_shortener/ # Main link shortener module
        ├── models/     # Data models
        ├── stores/     # MobX stores
        ├── use_cases/  # Use cases
        └── views/      # Screens and widgets
```

## 🏗️ Architecture

The project uses:

- **Flutter Modular**: For dependency injection and routing
- **MobX**: For reactive state management
- **Clean Architecture**: Separation in layers (Views, Stores, Use Cases)
- **Internationalization (i18n)**: Multi-language support
