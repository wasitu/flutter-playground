import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_playground/scenes/gallery.dart';
import 'package:flutter_playground/scenes/home.dart';
import 'package:flutter_playground/scenes/unknown.dart';
import 'package:flutter_playground/widget/animated_background.dart';
import 'package:get/route_manager.dart';

import 'scenes/animated_background_test.dart';
import 'scenes/bbs.dart';
import 'scenes/detail.dart';
import 'utility/theme_color.dart';

void main() async {
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Playground',
      theme: ThemeData.light().overrides(),
      darkTheme: ThemeData.dark().overrides(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => Home()),
        GetPage(name: '/gallery', page: () => Gallery()),
        GetPage(name: '/detail', page: () => Detail()),
        GetPage(name: '/bbs', page: () => BBS()),
        GetPage(
          name: '/animated_background_test',
          page: () => AnimatedBackgroundTest(),
        )
      ],
      unknownRoute: GetPage(name: '/unknown', page: () => Unknown()),
    );
  }
}

extension on ThemeData {
  ThemeData overrides() {
    final colors = ThemeColor(this.brightness);
    return this.copyWith(
      primaryTextTheme: textTheme.apply(
        displayColor: colors.label2,
      ),
      textTheme: textTheme.apply(),
      appBarTheme: AppBarTheme(
        centerTitle: false,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: colors.label2),
        elevation: 0,
        textTheme: TextTheme(
          title: TextStyle(
            fontSize: 48,
            color: colors.label2,
          ),
        ),
      ),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          textStyle: MaterialStateProperty.resolveWith(
            (states) {
              if (states.contains(MaterialState.hovered))
                return TextStyle(decoration: TextDecoration.underline);
              return TextStyle();
            },
          ),
          minimumSize: MaterialStateProperty.all(Size.zero),
        ),
      ),
    );
  }
}
