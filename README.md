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
    simple_flutter_reverb: ^0.0.1
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

### 2️⃣ **Listen for Messages**
```dart
// Public channel
reverb.listen((message) {
  print("Received: ${message.event}, Data: ${message.data}");
}, "public-channel", isPrivate: false);

// Private channel
reverb.listen((message) {
print("Received: ${message.event}, Data: ${message.data}");
}, "public-channel", isPrivate: true);
```

### 3️⃣ **Authenticate Manually (If Needed)**
```dart
final authToken = await reverb.authenticate("socket-id", "private-channel");
if (authToken != null) {
  reverb.subscribe("private-channel", isPrivate: true);
}
```

### 4️⃣ **Close Connection**
```dart
reverb.close();
```

## 🧪 Testing

Unit tests are included and use `mockito` to simulate WebSocket interactions: TODO

```sh
flutter test
```

## 🛠 Configuration

| Parameter                 | Type      | Description                                                 |
|---------------------------|----------|-------------------------------------------------------------|
| `scheme`                  | String   | WebSocket scheme (`ws` or `wss`)                            |
| `host`                    | String   | Server hostname                                             |
| `port`                    | String   | Server port                                                 |
| `appKey`                  | String   | Laravel Echo app key                                        |
| `authUrl`                 | String?  | URL for authentication (private channels)                   |
| `authToken`               | String?  | Token for authentication requests (`sanctum` or similar)      |
| `privatePrefix`           | String   | Prefix for private channels (default: `private-`)           |
| `usePrivateChannelPrefix` | bool     | Enable usage of prefix for private channel (default: `true`) |

### FlutterReverbOptions example

```dart
class FlutterReverbOptions {
  final String scheme;
  final String host;
  final String port;
  final String appKey;
  final dynamic authToken;
  final String? authUrl;
  final String privatePrefix;
  final bool usePrefix;

  FlutterReverbOptions({
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

## Usage Example

```dart
import 'package:activeage_mobile/core/secure_storage/secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_reverb/flutter_reverb.dart';
import 'package:flutter_reverb/flutter_reverb_options.dart';

import '../service_locator.dart';

/// WebSocketService manages communication with the Reverb WebSocket service.
class WebSocketService {
  // SecureStorageService instance to retrieve access tokens for authentication
  final SecureStorageService _secureStorageService = sl<SecureStorageService>();

  // FlutterReverb instance for managing WebSocket connections
  late final FlutterReverb _flutterReverb;

  /// Constructor to initialize the WebSocketService
  /// Sets up the FlutterReverb with the required configuration
  WebSocketService() {
    // Creating an options object for Reverb WebSocket connection
    final FlutterReverbOptions _options = FlutterReverbOptions(
      // Reading environment variables from .env file for Reverb configuration
      scheme: dotenv.env['REVERB_SCHEME']!,
      host: dotenv.env['REVERB_HOST']!,
      port: dotenv.env['REVERB_PORT']!,
      appKey: dotenv.env['REVERB_APP_KEY']!,
      authUrl: dotenv.env['REVERB_AUTH_URL']!, // URL for authentication (private channels) (Documentation: https://laravel.com/docs/11.x/broadcasting#authorizing-channels)
      privatePrefix: 'private-', // Prefix for private channels (Laravel default prefix is 'private-')
      // Retrieving the access token from secure storage for authentication
      authToken: _secureStorageService.getAccessToken(),
    );

    // Initializing FlutterReverb with the provided options
    _flutterReverb = FlutterReverb(options: _options);
  }

  /// Listens to a public channel and calls the onData callback with the received data.
  /// 
  /// [onData] - A callback function that will be invoked with the data from the channel.
  /// [channel] - The name of the public channel to listen to.
  void listenPublicChannel(void Function(dynamic) onData, String channel) {
    // Subscribing to the public channel
    _flutterReverb.listen(onData, channel);
  }

  /// Listens to a private channel and calls the onData callback with the received data.
  /// 
  /// [onData] - A callback function that will be invoked with the data from the channel.
  /// [channel] - The name of the private channel to listen to.
  void listenPrivateChannel(void Function(dynamic) onData, String channel) {
    // Subscribing to the private channel by passing `isPrivate: true`
    _flutterReverb.listen(onData, channel, isPrivate: true);
  }

}

/// Uncommented legacy code for reference (if needed later):
/// This section of code is an alternative approach using WebSocketChannel for managing WebSocket communication.
/// It subscribes to both public and private channels, handles authentication, and includes error handling for WebSocket connections.


```

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
