import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:marketyo_developer_challenge/constants/primary_swatch_color.dart';
import 'package:marketyo_developer_challenge/core/injection_container.dart'
    as di;
import 'package:marketyo_developer_challenge/view_models/login_view_model.dart';
import 'package:marketyo_developer_challenge/view_models/product_view_model.dart';
import 'package:marketyo_developer_challenge/views/products_view.dart';
import 'package:marketyo_developer_challenge/views/login_view.dart';
import 'package:marketyo_developer_challenge/views/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  di.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductViewModel(),
          child: ProductsView(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginViewModel(),
          child: LoginView(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: marketyoPrimaryColor),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: [const Locale.fromSubtags(languageCode: 'tr')],
    );
  }
}
