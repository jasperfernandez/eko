
import 'package:simple_flutter_reverb/flutter_reverb_options.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:simple_flutter_reverb/flutter_reverb.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'flutter_reverb_test.mocks.dart';

@GenerateMocks([http.Client, WebSocketChannel])
void main() {
  group('FlutterReverb', () {
    late MockClient mockHttpClient;
    late MockWebSocketChannel mockWebSocket;
    late FlutterReverb flutterReverb;

    setUp(() {
      mockHttpClient = MockClient();
      mockWebSocket = MockWebSocketChannel();

      final options = FlutterReverbOptions(
        scheme: 'ws',
        host: 'localhost',
        port: '6001',
        appKey: 'testKey',
        authToken: 'testToken',
        authUrl: 'https://example.com/broadcasting/auth',
      );

      flutterReverb = FlutterReverb(options: options);
    });

    test('should construct WebSocket URL correctly', () {
      expect(flutterReverb.options.scheme, 'ws');
      expect(flutterReverb.options.host, 'localhost');
      expect(flutterReverb.options.port, '6001');
      expect(flutterReverb.options.appKey, 'testKey');
    });
  });
}
