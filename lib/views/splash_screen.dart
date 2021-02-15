import 'package:flutter/material.dart';
import 'package:marketyo_developer_challenge/views/login_view.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: Duration(milliseconds: 1100), vsync: this);
    _animationController.forward();
    final curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutSine,
    );

    _animation = Tween<double>(begin: -1, end: 0).animate(curvedAnimation)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginView()));
        }
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color(0xFF0C7254),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 50, vertical: 50),
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              final width = MediaQuery.of(context).size.width;
              final xValue = _animation.value * width;
              return Transform(
                  transform: Matrix4.translationValues(xValue, 0, 0),
                  child: child);
            },
            child: Image.asset(
              'assets/images/marketyo-vertical.png',
            ),
          ),
        ),
      ),
    );
  }
}
