import 'dart:convert';

import 'package:flutter_reverb/flutter_reverb_options.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_reverb/flutter_reverb.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
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
        httpClient: mockHttpClient,
      );

      flutterReverb = FlutterReverb(options: options);
    });

    test('should construct WebSocket URL correctly', () {
      expect(flutterReverb.options.scheme, 'ws');
      expect(flutterReverb.options.host, 'localhost');
      expect(flutterReverb.options.port, '6001');
      expect(flutterReverb.options.appKey, 'testKey');
    });

    test('should authenticate successfully', () async {
      when(mockHttpClient.post(
        Uri.parse('https://example.com/broadcasting/auth'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response(jsonEncode({'auth': 'valid_auth_token'}), 200));

      final authToken = await flutterReverb.authenticate('1234', 'private-channel');
      expect(authToken, 'valid_auth_token');
    });

    test('should fail authentication with incorrect response', () async {
      when(mockHttpClient.post(
        Uri.parse('https://example.com/broadcasting/auth'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('Unauthorized', 401));

      final authToken = await flutterReverb.authenticate('1234', 'private-channel');
      expect(authToken, isNull);
    });

    test('should subscribe to public channel', () {
      flutterReverb.subscribe('public-channel');
      // No exception should be thrown
    });
/*
    test('should subscribe to private channel', () {
      flutterReverb.subscribe('private-channel', isPrivate: true);
      // No exception should be thrown
    });

    test('should close WebSocket without error', () {
      expect(() => flutterReverb.close(), returnsNormally);
    });*/
  });
}
