import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:marketyo_developer_challenge/view_models/login_view_model.dart';
import 'package:marketyo_developer_challenge/views/products_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _isObscure;
  bool _isLoggedIn;
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    getUsernameAndPassword();
    _isObscure = true;
    _isLoggedIn = false;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                colors: [
                  Color(0xFFFFFFFF),
                  Color(0xFFFFFFFF),
                ],
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: size.height / 20,
                ),
                Hero(
                    tag: 'logo',
                    child: Image.asset('assets/images/kurumsal-logo.png')),
                SizedBox(
                  height: size.height / 100,
                ),
                Container(
                  width: size.width,
                  alignment: Alignment.bottomCenter,
                  child: TyperAnimatedTextKit(
                    text: ['Bildiğin market'],
                    speed: Duration(milliseconds: 150),
                    textStyle: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Montserrat',
                      color: Color(0xFF0C7254),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height / 30,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF0C7254),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(75),
                        topRight: Radius.circular(75),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        children: [
                          SizedBox(
                            height: size.height / 25,
                          ),
                          Container(
                            height: size.height / 4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white,
                                  blurRadius: 2,
                                  offset: Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: customTextField(
                                      context,
                                      userNameController,
                                      "*Kullanıcı Adı",
                                      SizedBox(),
                                      false),
                                ),
                                Divider(
                                  height: size.height / 200,
                                  color: Colors.green.shade400,
                                  thickness: 2,
                                ),
                                Expanded(
                                    child: customTextField(
                                        context,
                                        passwordController,
                                        '*Şifre',
                                        IconButton(
                                          icon: Icon(
                                            _isObscure
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: Colors.green,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _isObscure = !_isObscure;
                                            });
                                          },
                                        ),
                                        _isObscure)),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: size.height / 15,
                          ),
                          GestureDetector(
                            onTap: () async {
                              final result = await Provider.of<LoginViewModel>(
                                      context,
                                      listen: false)
                                  .login();
                              if (userNameController.text.isNotEmpty &&
                                  passwordController.text.isNotEmpty &&
                                  result) {
                                _isLoggedIn = true;
                                sharedPreferences =
                                    await SharedPreferences.getInstance();
                                sharedPreferences.setString(
                                    'userName', userNameController.text);
                                sharedPreferences.setString(
                                    'password', passwordController.text);
                                _showLoaderDialog(
                                    context, "Giriş yapılıyor...");
                                Future.delayed(Duration(milliseconds: 750), () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductsView(
                                        isLoggedIn: _isLoggedIn,
                                      ),
                                    ),
                                  );
                                });
                              } else {
                                _isLoggedIn = false;
                                Timer(Duration(milliseconds: 50), () async {
                                  await Flushbar(
                                    backgroundGradient: LinearGradient(colors: [
                                      Color(0xFF1C2834),
                                      Color(0xFF1C2834),
                                    ]),
                                    progressIndicatorBackgroundColor:
                                        Colors.white,
                                    backgroundColor: Colors.white,
                                    icon: Icon(
                                      Icons.warning,
                                      color: Colors.white,
                                    ),
                                    messageText: Text(
                                      'Kullanıcı adı veya parola girilmedi.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,
                                          color: Colors.white),
                                    ),
                                    duration: Duration(milliseconds: 1500),
                                  ).show(context);
                                });
                              }
                            },
                            child: Container(
                              height: size.height / 13,
                              width: size.width / 2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Text(
                                  'Giriş',
                                  style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.w900,
                                      fontSize: 17,
                                      color: Color(0xFF0C7254),
                                      letterSpacing: 1.35),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height / 18,
                          ),
                          GestureDetector(
                            onTap: () async {
                              sharedPreferences.clear();
                              CircularProgressIndicator();
                              Future.delayed(Duration(milliseconds: 250), () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductsView(
                                      isLoggedIn: false,
                                    ),
                                  ),
                                );
                              });
                            },
                            child: Text(
                              'Giriş yapmadan devam et',
                              style: TextStyle(
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17,
                                  color: Colors.white,
                                  decoration: TextDecoration.underline,
                                  letterSpacing: 1.2),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getUsernameAndPassword() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final userName = sharedPreferences.getString('userName') == null
        ? ""
        : sharedPreferences.getString('userName');

    final password = sharedPreferences.getString('password') == null
        ? ""
        : sharedPreferences.getString('password');

    userNameController.text = userName;

    passwordController.text = password;
  }

  Widget customTextField(
      BuildContext context,
      TextEditingController textEditingController,
      String hintString,
      Widget suffixIcon,
      bool obscureText) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, top: 15),
      child: Center(
        child: TextField(
          controller: textEditingController,
          cursorColor: Color(0xFF0C7254),
          style: TextStyle(color: Color(0xFF0C7254), fontFamily: 'Raleway'),
          decoration: InputDecoration(
              hintText: hintString,
              hintStyle:
                  TextStyle(color: Colors.grey.shade700, fontFamily: 'Raleway'),
              suffixIcon: suffixIcon,
              border: InputBorder.none),
          obscureText: obscureText,
        ),
      ),
    );
  }

  _showLoaderDialog(BuildContext context, String operation) {
    AlertDialog alert = AlertDialog(
      contentTextStyle: TextStyle(
          color: Color(0xFF0C7254),
          fontFamily: 'Raleway',
          fontWeight: FontWeight.bold),
      content: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            strokeWidth: 5,
            backgroundColor: Colors.white,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Text(
              operation,
              style: TextStyle(
                  color: Color(0xFF0C7254),
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
