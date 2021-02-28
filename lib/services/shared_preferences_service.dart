import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jpec_training/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> setUserFromSharedPrefs(User user) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return await sharedPreferences.setString('user', jsonEncode(user.toJson()));
}

Future<User> getUserFromSharedPrefs() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String user = sharedPreferences.get('user');
  if (user == null) {
    return null;
  }
  return User.fromJson(jsonDecode(user));
}

Future<bool> setUserJWTToken(String jwt) async {
  final storage = new FlutterSecureStorage();
  if (jwt == null) {
    await storage.delete(key: 'jwt');
  } else {
    await storage.write(key: 'jwt', value: jwt);
  }
  return true;
}

Future<String> getUserJWTToken() async {
  final storage = new FlutterSecureStorage();
  return await storage.read(key: 'jwt');
}
