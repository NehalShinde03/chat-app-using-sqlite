import 'package:flutter/cupertino.dart';

class LoginProvider extends ChangeNotifier{

  static bool _isPasswordVisible = true;
  bool get isPasswordVisible => _isPasswordVisible;
  set isPasswordVisible(bool val){
    _isPasswordVisible = val;
    notifyListeners();
  }

}