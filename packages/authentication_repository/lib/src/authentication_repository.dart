import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    // await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unknown;
    yield* _controller.stream;
  }

  Future<bool> logIn({
    @required String username,
    @required String password,
  }) async {
    assert(username != null);
    assert(password != null);

    await Future.delayed(
      const Duration(milliseconds: 300),
      () {},
    );
    bool isLoginSuccess = true;
    if (isLoginSuccess) {
      String token = "SECRET_TOKEN";
      saveUserToken(token);
      _controller.add(AuthenticationStatus.authenticated);
    } else {
      _controller.add(AuthenticationStatus.unauthenticated);
    }
    return isLoginSuccess;
  }

  Future<String> getUserToken() async {
    final storage = new FlutterSecureStorage();
    return await storage.read(key: "user_token");
  }

  Future<bool> saveUserToken(String token) async {
    final storage = new FlutterSecureStorage();
    await storage.write(key: "user_token", value: token);
    return false;
  }

  Future<bool> removeUserToken() async {
    final storage = new FlutterSecureStorage();
    await storage.delete(key: "user_token");
    return false;
  }

  void logOut() {
    removeUserToken();
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
