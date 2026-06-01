# Gocht - Voice Chat Room App

## Overview

**Gocht** is a Flutter-based voice chat room application that combines real-time voice communication with a monetization system featuring gifts, coins, VIP memberships, and user rankings.

## Features

### Core Features
- 🎙️ **Voice Chat Rooms** - Multi-user voice rooms with WebRTC/Agora integration
- 🎁 **Gift System** - Send virtual gifts to other users in rooms
- 💰 **Coins & Currency** - In-app currency system for purchasing gifts
- ⭐ **VIP Membership** - Premium tiers with exclusive benefits
- 🏆 **Leaderboard & Ranking** - Real-time user rankings based on activity
- 👤 **User Profiles** - Customize profiles with avatar, stats, and achievements
- 📊 **Admin Panel** - Manage users, rooms, gifts, and monetization

## Tech Stack

- **Frontend**: Flutter 3.0+
- **Backend**: Firebase (Auth, Firestore, Storage)
- **Voice**: WebRTC / Agora RTC Engine
- **State Management**: Provider
- **Payment**: In-App Purchase

## Quick Start

### Prerequisites
- Flutter 3.0 or higher
- Firebase project setup

### Installation

```bash
git clone https://github.com/ay657/Gocht.git
cd Gocht
flutter pub get
flutter run
```

## Configuration

Update `lib/firebase_options.dart` with your Firebase credentials.

## Project Structure

```
lib/
├── main.dart
├── config/theme/
├── models/
├── providers/
├── screens/
└── services/
```

## Contributing

Feel free to fork and submit pull requests!

## License

MIT License
