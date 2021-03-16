import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

import 'routing/app_route_information_parser.dart';
import 'routing/app_router_delegate.dart';

void main() async {
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppRouterDelegate _routerDelegate = AppRouterDelegate();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Playground',
      routerDelegate: _routerDelegate,
      routeInformationParser: AppRouteInformationParser(),
      theme: ThemeData.light().overrides(),
      darkTheme: ThemeData.dark().overrides(),
    );
  }
}

extension on ThemeData {
  ThemeData overrides() {
    return this.copyWith(
      primaryColor: Colors.white,
      primaryTextTheme: textTheme.apply(displayColor: Colors.black),
      // textTheme: textTheme.apply(displayColor: Colors.black),
      appBarTheme: AppBarTheme(
        centerTitle: false,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        textTheme: TextTheme(
          title: TextStyle(
            fontSize: 48,
            color: Colors.black,
          ),
        ),
      ),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          textStyle: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.hovered))
              return TextStyle(decoration: TextDecoration.underline);
            return TextStyle();
          }),
        ),
      ),
    );
  }
}
