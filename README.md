
# 🌿 VolunAI — AI-Powered Volunteer Platform



A web and mobile platform connecting volunteers, event organisers, and communities across Kazakhstan — powered by AI matching and gamification.

<img width="1890" height="906" alt="image" src="https://github.com/user-attachments/assets/0d98d633-4195-404f-a7cd-9221017db6c6" />





<p align="center">
  <img src="https://github.com/user-attachments/assets/b2fccd0f-2118-49b3-8498-7592d52f2669" width="30%">
  <img src="https://github.com/user-attachments/assets/8f9665e6-4a7f-4096-aa63-0f6d811ba319" width="30%">
  <img src="https://github.com/user-attachments/assets/43cc19f2-9001-44e7-839c-1edf79c0b198" width="30%">
</p>


---

## What It Does

- 🔍 **Smart Search** — find volunteer events by location, interest, and availability
- 🤖 **AI Chat** — built-in AI assistant to guide volunteers and answer questions
- 🧠 **Psychology Module** — wellbeing check-in for volunteers (burnout prevention)
- 🏆 **Rating & Gamification** — leaderboard and point system to reward active volunteers
- 📅 **Event Management** — organisers can create, publish, and manage volunteer events
- 👤 **Dual Role System** — separate flows for volunteers and organisers

---

## Tech Stack

**Mobile (Flutter)**
`Dart` · `Flutter` · `Material Design`

**Web**
`HTML` · `CSS` · `JavaScript` · `Vite`

---

## Project Structure

```
volunai/
├── flutter/                  # Mobile app
│   └── lib/
│       ├── main.dart
│       ├── screens/
│       │   ├── home_screen.dart
│       │   ├── search_screen.dart
│       │   ├── ai_chat_screen.dart
│       │   ├── psychology_screen.dart
│       │   ├── rating_screen.dart
│       │   ├── profile_screen.dart
│       │   ├── add_event_screen.dart
│       │   └── ...
│       ├── widgets/
│       └── theme/
└── website/                  # Web platform
    ├── index.html
    ├── css/style.css
    ├── js/main.js
    ├── pages/
    │   ├── events.html
    │   ├── search.html
    │   ├── rating.html
    │   └── about.html
    └── assets/images/
```

---

## Run the Web App

```bash
cd website
# Open index.html directly in a browser, or serve with:
npx serve .
```

## Run the Flutter App

```bash
cd flutter
flutter pub get
flutter run
```

> Requires Flutter SDK — [install guide](https://docs.flutter.dev/get-started/install)

---


