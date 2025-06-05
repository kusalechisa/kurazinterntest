# Simple Task Manager

A Flutter-based mobile application for managing tasks with a clean and intuitive interface.

## Features

- Display a list of tasks
- Add new tasks
- Mark tasks as completed
- Delete tasks
- Persistent storage using SharedPreferences
- Swipe-to-delete functionality
- Material Design 3 UI

## Getting Started

### Prerequisites

- Flutter SDK (latest version)
- Android Studio / VS Code with Flutter extensions
- Android Emulator or physical device

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd mobile_task_manager
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Usage

- Tap the + button to add a new task
- Tap the checkbox to mark a task as completed
- Swipe a task from right to left to delete it
- Tasks are automatically saved and persisted between app launches

## Project Structure

```
mobile_task_manager/
├── lib/
│   ├── main.dart              # App entry point
│   ├── models/
│   │   └── task.dart         # Task model
│   ├── screens/
│   │   └── home_screen.dart  # Main screen
│   └── widgets/
│       └── task_item.dart    # Task list item widget
├── pubspec.yaml              # Dependencies
└── README.md
```

## Dependencies

- Flutter SDK
- shared_preferences: ^2.2.2
- provider: ^6.1.1