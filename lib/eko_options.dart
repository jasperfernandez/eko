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
