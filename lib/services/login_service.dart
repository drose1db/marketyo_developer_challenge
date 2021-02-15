import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:marketyo_developer_challenge/constants/api_url.dart';
import 'package:marketyo_developer_challenge/models/login_model.dart';
import 'package:marketyo_developer_challenge/services/i_login_service.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class LoginService with ILoginService {
  final String _url = ApiUrl.baseUrl;

  @override
  Future login() async {
    final Response response = await http.get(_url + 'login');
    if (response.statusCode == 200) {
      final decodedBody = json.decode(response.body);
      final login = decodedBody;
      return login;
    }
    return LoginModel();
  }
}
