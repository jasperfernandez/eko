import 'package:eko/eko_options.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:eko/eko.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'eko_test.mocks.dart';

@GenerateMocks([http.Client, WebSocketChannel])
void main() {
  group('FlutterReverb', () {
    late MockClient mockHttpClient;
    late MockWebSocketChannel mockWebSocket;
    late Eko eko;

    setUp(() {
      mockHttpClient = MockClient();
      mockWebSocket = MockWebSocketChannel();

      final options = EkoOptions(
        scheme: 'ws',
        host: 'localhost',
        port: '6001',
        appKey: 'testKey',
        authToken: 'testToken',
        authUrl: 'https://example.com/broadcasting/auth',
      );

      eko = Eko(options: options);
    });

    test('should construct WebSocket URL correctly', () {
      expect(eko.options.scheme, 'ws');
      expect(eko.options.host, 'localhost');
      expect(eko.options.port, '6001');
      expect(eko.options.appKey, 'testKey');
    });
  });
}
