import 'package:chat_sqlite/data_base_helper/data_base_helper.dart';
import 'package:chat_sqlite/model/user_model.dart';
import 'package:flutter/cupertino.dart';

class SenderSideProvider extends ChangeNotifier{

  //to read register user in db
  Future<List<UserModel>> _future = DataBaseHelper().readRegisterUserData();
  Future<List<UserModel>> get future => _future;
  set future(val){
      _future = val;
      notifyListeners();
  }

}