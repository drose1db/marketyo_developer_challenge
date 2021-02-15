import 'package:flutter/material.dart';
import 'package:marketyo_developer_challenge/views/login_view.dart';

class AppBarProvider {
  static Widget marketyoAppBar(
      BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) {
    return PreferredSize(
      preferredSize: Size.fromHeight(
        MediaQuery.of(context).size.height / 7,
      ),
      child: Stack(children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: MediaQuery.of(context).size.height / 7,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color(0xFF0C7254),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //I have used this icon button to center the company's logo. This icon will not shown because of its color.
                IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: Color(0xFF0C7254),
                  ),
                  onPressed: () {},
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 9,
                  child: Hero(
                    tag: 'logo',
                    child: Image.asset(
                      'assets/images/marketyo-vertical.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginView(),
                        ),
                        (route) => false);
                  },
                  icon: Image.asset(
                    'assets/images/sign-out.png',
                    color: Colors.white,
                    width: 25,
                    height: 25,
                  ),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }

  static Widget marketyoAppBarWithReturn(
      BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) {
    return PreferredSize(
      preferredSize: Size.fromHeight(
        MediaQuery.of(context).size.height / 7,
      ),
      child: Stack(children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: MediaQuery.of(context).size.height / 7,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color(0xFF0C7254),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.navigate_before,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 9,
                  child: Image.asset(
                    'assets/images/marketyo-vertical.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 7.5,
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
