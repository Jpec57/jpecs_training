import 'package:flutter/cupertino.dart';
import 'package:jpec_training/Models/User.dart';
import 'package:jpec_training/Pages/LoginPage/LoginPage.dart';
import 'package:jpec_training/Services/SharedPreferencesService.dart';

class UserProvider extends ChangeNotifier {
  User _currentUser;

  void setUser(User user) {
    _currentUser = user;
    notifyListeners();
  }

  Future<User> getUser(BuildContext context, {bool hasRedirect = false}) async {
    if (_currentUser == null) {
      _currentUser = await getUserFromSharedPrefs();
    }
    if (hasRedirect && _currentUser == null){
      Navigator.of(context).pushNamedAndRemoveUntil(
          LoginPage.routeName, ModalRoute.withName(LoginPage.routeName));
    }
    return _currentUser;
  }
}