
# 🌿 VolunAI — AI-Powered Volunteer Platform



A web and mobile platform connecting volunteers, event organisers, and communities across Kazakhstan — powered by AI matching and gamification.
<img width="1890" height="906" alt="image" src="https://github.com/user-attachments/assets/0d98d633-4195-404f-a7cd-9221017db6c6" />

![Image 1](<img width="180" height="391" alt="image" src="https://github.com/user-attachments/assets/64b59ed8-f3e4-4b42-8ce3-f9d6c331e3fe" />) ![Image 2](<img width="173" height="377" alt="image" src="https://github.com/user-attachments/assets/389f41f2-fb8c-442f-9f2a-956900b4cd5f" />)

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

## Screenshots

| Home | Events | AI Chat | Rating |
|------|--------|---------|--------|
| ![home](website/assets/images/home_screen.png) | ![events](website/assets/images/add_event.png) | ![ai](website/assets/images/psychology.png) | ![rating](website/assets/images/rating.png) |

---

*Built at SheCodes Hackathon 2026 · 1st Place*
