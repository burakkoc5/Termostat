# Smart Thermostat App

A Flutter app to control and monitor a smart thermostat system using Firebase Realtime Database.

## Features
- View and set target temperature
- Boiler ON/OFF and manual override
- Usage logs and energy chart
- GPS-based automation (turn off boiler when away)
- Settings for hysteresis, override timeout, and Firebase path
- Dark mode support

## Setup

1. **Clone this repo**
2. **Install dependencies:**
   ```
   flutter pub get
   ```
3. **Firebase Setup:**
   - Create a Firebase project at https://console.firebase.google.com/
   - Add an Android/iOS app to your project
   - Download `google-services.json` (Android) or `GoogleService-Info.plist` (iOS) and place in the correct directory:
     - Android: `android/app/google-services.json`
     - iOS: `ios/Runner/GoogleService-Info.plist`
   - Enable Firebase Realtime Database and set rules for open testing:
     ```json
     {
       "rules": {
         ".read": true,
         ".write": true
       }
     }
     ```
     *(For production, restrict access!)*
4. **Run the app:**
   ```
   flutter run
   ```

## Required Packages
- firebase_core
- firebase_database
- provider
- geolocator
- fl_chart
- intl
- shared_preferences
- flutter_localizations
- cupertino_icons

## Project Structure
- `lib/models/` - Data models
- `lib/services/` - Firebase and location services
- `lib/providers/` - State management
- `lib/screens/` - UI screens
- `lib/widgets/` - Reusable widgets
- `lib/utils/` - Utilities and constants

---

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
