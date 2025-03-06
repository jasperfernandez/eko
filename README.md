# 📡 Flutter Reverb WebSocket Client

A **Dart/Flutter WebSocket client** for **Laravel Reverb**, enabling seamless real-time communication with WebSockets.

## 🚀 Features
✔️ **Easy WebSocket Connection** with Laravel Reverb  
✔️ **Authentication Support** (JWT, API Keys)  
✔️ **Public & Private Channel Subscriptions**  
✔️ **Real-time Event Handling**  
✔️ **Lightweight & Easy to Use**

## 📦 Installation

Add **flutter_reverb** to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_reverb: latest_version
```

Run:

```sh
flutter pub get
```

## 🎯 Usage

### 1️⃣ **Initialize the WebSocket Client**
```dart
import 'package:flutter_reverb/flutter_reverb.dart';

final options = FlutterReverbOptions(
  scheme: "ws", 
  host: "your-server.com",
  port: "6001",
  appKey: "your-app-key", // Reverb app key
  authUrl: "https://your-backend.com/broadcasting/auth", // optional, needed for private channels
  authToken: "your-auth-token", // optional
  privatePrefix: "private-", // default: "private-"
  usePrivateChannelPrefix: true, // default: true
);

final reverb = FlutterReverb(options: options);
```

### 2️⃣ **Subscribe to Channels**
```dart
reverb.subscribe("public-channel");
reverb.subscribe("private-channel", isPrivate: true);
```

### 3️⃣ **Listen for Messages**
```dart
reverb.listen((message) {
  print("Received: ${message.event}, Data: ${message.data}");
}, "public-channel");
```

### 4️⃣ **Authenticate Manually (If Needed)**
```dart
final authToken = await reverb.authenticate("socket-id", "private-channel");
if (authToken != null) {
  reverb.subscribe("private-channel", isPrivate: true);
}
```

### 5️⃣ **Close Connection**
```dart
reverb.close();
```

## 🧪 Testing

Unit tests are included and use `mockito` to simulate WebSocket interactions:

```sh
flutter test
```

## 🛠 Configuration

| Parameter                 | Type      | Description                                                  |
|---------------------------|----------|--------------------------------------------------------------|
| `scheme`                  | String   | WebSocket scheme (`ws` or `wss`)                             |
| `host`                    | String   | Server hostname                                              |
| `port`                    | String   | Server port                                                  |
| `appKey`                  | String   | Laravel Echo app key                                         |
| `authUrl`                 | String?  | URL for authentication (private channels)                    |
| `authToken`               | String?  | Token for authentication requests                            |
| `privatePrefix`           | String   | Prefix for private channels (default: `private-`)            |
| `usePrivateChannelPrefix` | bool     | Enable usage of prefix for private channel (default: `true`) |

## 🤝 Contributing

1. **Fork** the repo & clone it
2. **Create** a new branch
3. **Commit** your changes
4. **Push** and open a **Pull Request**

## 📄 License

This package is **open-source** and licensed under the **MIT License**.

## 📬 Support

Found a bug? Have a feature request?  
Open an **issue** or contribute to the project! 🚀  
