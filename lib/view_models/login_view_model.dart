import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:marketyo_developer_challenge/models/login_model.dart';
import 'package:marketyo_developer_challenge/services/i_login_service.dart';
import 'package:marketyo_developer_challenge/services/login_service.dart';

class LoginViewModel with ChangeNotifier {
  LoginService _loginService = GetIt.I<ILoginService>();
  var _loginModel;
  get loginModel => _loginModel;
  Future<bool> login() async {
    _loginModel = await _loginService.login();
    notifyListeners();
    return true;
  }
}
