
# Unstable Ticker

## Setup Instructions
1. Run the WebSocket server:
```bash
dart mock_server.dart
```
2. Run the Flutter app:
```bash
flutter pub get
flutter run
```

## Architectural Decisions
- **Riverpod** for scalable state management.
- Separation of layers (service, repository, notifier, UI) for testability and performance.

## Anomaly Detection Heuristic
- If price changes more than 50% from the previous value in 1 update, it is marked anomalous.
- This avoids showing extreme price drops from corrupted data.

## Performance Analysis
- Efficient updates via Riverpod and isolated widget builds.
- Each stock item is independent, reducing rebuilds.
- Use DevTools to confirm smooth UI.
