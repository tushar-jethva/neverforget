import 'package:flutter/cupertino.dart';
import 'package:never_forget/FirebaseMethods/auth_methods.dart';
import 'package:never_forget/models/user_model.dart';


class UserProvider extends ChangeNotifier {
  UserModel? _user;
  UserModel get getUser => _user!;
  final MyAuthMethods _methods = MyAuthMethods();

  Future<void> refreshUser() async {
    UserModel us = await _methods.getUserDetail();
    _user = us;

    notifyListeners();
  }
}