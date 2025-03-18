
import 'package:simple_flutter_reverb/simple_flutter_reverb_options.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:simple_flutter_reverb/simple_flutter_reverb.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'simple_flutter_reverb_test.mocks.dart';

@GenerateMocks([http.Client, WebSocketChannel])
void main() {
  group('FlutterReverb', () {
    late MockClient mockHttpClient;
    late MockWebSocketChannel mockWebSocket;
    late SimpleFlutterReverb flutterReverb;

    setUp(() {
      mockHttpClient = MockClient();
      mockWebSocket = MockWebSocketChannel();

      final options = SimpleFlutterReverbOptions(
        scheme: 'ws',
        host: 'localhost',
        port: '6001',
        appKey: 'testKey',
        authToken: 'testToken',
        authUrl: 'https://example.com/broadcasting/auth',
      );

      flutterReverb = SimpleFlutterReverb(options: options);
    });

    test('should construct WebSocket URL correctly', () {
      expect(flutterReverb.options.scheme, 'ws');
      expect(flutterReverb.options.host, 'localhost');
      expect(flutterReverb.options.port, '6001');
      expect(flutterReverb.options.appKey, 'testKey');
    });
  });
}
