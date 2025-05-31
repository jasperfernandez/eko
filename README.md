# 📡 Eko a Flutter Laravel Reverb Client

## 🚀 Features

✔️ **Easy WebSocket Connection** to Laravel Reverb  
✔️ **Authentication Support** (JWT, API Keys)  
✔️ **Public & Private Channel Subscriptions**  
✔️ **Real-time Event Handling**  
✔️ **Lightweight & Easy to Use**

## 📦 Installation

Add **eko** to your `pubspec.yaml`:

```yaml
dependencies:
  eko: ^0.0.1
```

and run:

```sh
flutter pub get
```

or install it from the command line:

```sh
flutter pub add eko
```

## 🎯 Usage

### 1️⃣ **Initialize the WebSocket Client**

```dart
import 'package:eko/eko.dart';

final options = EkoOptions(
  scheme: "ws",
  host: "localhost",
  port: "8080",
  appKey: "your-app-key", // Reverb app key
  authUrl: "https://your-backend.com/api/broadcasting/auth", // optional, needed for private channels
  authToken: "your-auth-token", // optional
  privatePrefix: "private-", // default: "private-"
);

final eko = Eko(options: options);
```

### 2️⃣ **Listen for Messages**

```dart
// Public channel
eko.listen((message) {
  print("Received: ${message.event}, Data: ${message.data}");
}, "public-channel", isPrivate: false);

// Private channel
eko.listen((message) {
print("Received: ${message.event}, Data: ${message.data}");
}, "public-channel", isPrivate: true);
```

### 3️⃣ **Close Connection**

```dart
eko.close();
```

## 🧪 Testing

Unit tests are included and use `mockito` to simulate WebSocket interactions: TODO

```sh
flutter test
```

## 🛠 Configuration

| Parameter       | Type    | Description                                              |
| --------------- | ------- | -------------------------------------------------------- |
| `scheme`        | String  | WebSocket scheme (`ws` or `wss`)                         |
| `host`          | String  | Server hostname                                          |
| `port`          | String  | Server port                                              |
| `appKey`        | String  | Laravel Echo app key                                     |
| `authUrl`       | String? | URL for authentication (private channels)                |
| `authToken`     | String? | Token for authentication requests (`sanctum` or similar) |
| `privatePrefix` | String  | Prefix for private channels (default: `private-`)        |

### EkoOptions example

```dart
class EkoOptions {
  final String scheme;
  final String host;
  final String port;
  final String appKey;
  final dynamic authToken;
  final String? authUrl;
  final String privatePrefix;
  final bool usePrefix;

  EkoOptions({
    required this.scheme,
    required this.host,
    required this.port,
    required this.appKey,
    this.authToken,
    this.authUrl,
    this.privatePrefix = 'private-',
    this.usePrefix = true,
  });
}
```
