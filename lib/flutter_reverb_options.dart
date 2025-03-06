import 'package:http/http.dart' as http;

class FlutterReverbOptions {
  final String scheme;
  final String host;
  final String port;
  final String appKey;
  final String? authToken;
  final String? authUrl;
  final http.Client? httpClient;
  final String privatePrefix;

  FlutterReverbOptions({
    required this.scheme,
    required this.host,
    required this.port,
    required this.appKey,
    this.authToken,
    this.authUrl,
    this.httpClient,
    this.privatePrefix = 'private-',
  });
}