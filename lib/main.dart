import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_playground/scenes/gallery.dart';
import 'package:flutter_playground/scenes/generate.dart';
import 'package:flutter_playground/scenes/home.dart';
import 'package:flutter_playground/scenes/unknown.dart';
import 'package:flutter_playground/utility/local_storage.dart';
import 'package:get/route_manager.dart';

import 'scenes/animated_background_test.dart';
import 'scenes/bbs.dart';
import 'scenes/detail.dart';
import 'utility/theme_color.dart';
import 'utility/local_storage.dart';

void main() async {
  await Firebase.initializeApp();
  await LocalStorage.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Playground',
      theme: ThemeData.light().overrides(),
      darkTheme: ThemeData.dark().overrides(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const Home()),
        GetPage(name: '/home', page: () => const Home()),
        GetPage(name: '/gallery', page: () => const Gallery()),
        GetPage(name: '/detail', page: () => Detail()),
        GetPage(name: '/bbs', page: () => const BBS()),
        GetPage(
          name: '/animated_background_test',
          page: () => const AnimatedBackgroundTest(),
        ),
        GetPage(name: '/pass_generator', page: () => const Generate()),
      ],
      unknownRoute: GetPage(name: '/unknown', page: () => const Unknown()),
    );
  }
}

extension on ThemeData {
  ThemeData overrides() {
    final colors = ThemeColor(brightness);
    return copyWith(
      primaryTextTheme: textTheme.apply(
        displayColor: colors.label2,
      ),
      textTheme: textTheme.apply(),
      appBarTheme: AppBarTheme(
        centerTitle: false,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: colors.label2),
        elevation: 0,
        titleTextStyle: TextStyle(
          fontSize: 48,
          color: colors.label2,
        ),
        // textTheme: TextTheme(
        //   title: TextStyle(
        //     fontSize: 48,
        //     color: colors.label2,
        //   ),
        // ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(colorScheme.secondary),
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          textStyle: MaterialStateProperty.resolveWith(
            (states) {
              if (states.contains(MaterialState.hovered)) {
                return const TextStyle(decoration: TextDecoration.underline);
              }
              return const TextStyle();
            },
          ),
          minimumSize: MaterialStateProperty.all(Size.zero),
        ),
      ),
      cardTheme: CardTheme(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
