## 0.0.1
- Added `FlutterReverbOptions` class.
- Added `FlutterReverb` class.
## 0.0.2
- Changed `listen` method to accept `isPrivate` parameter.
- Changed `authenticate` method to be private.
- Changed `subscribe` method to be private.
- Removed broken tests.
- TODO: Rewrite tests.
## 0.0.3
- Removed option to provide own http client. Now using `http` package.
- Small refactoring.
## 0.0.4
- Changed `FlutterReverbOptions.authToken` to 'dynamic' type. This way, it can be a `String` or a `Future<String>`.
