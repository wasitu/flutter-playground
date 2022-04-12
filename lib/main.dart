import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/utility/local_storage.dart';
import 'package:get/route_manager.dart';

import 'scenes/animated_background_test.dart';
import 'scenes/bbs.dart';
import 'scenes/detail.dart';
import 'scenes/gallery.dart';
import 'scenes/generate.dart';
import 'scenes/home.dart';
import 'scenes/unknown.dart';
import 'utility/local_storage.dart';
import 'utility/theme_color.dart';

void main() async {
  await Firebase.initializeApp();
  await LocalStorage.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  StatelessElement createElement() {
    Get.addPages([
      GetPage(name: '/', page: () => const Home()),
      GetPage(name: '/gallery', page: () => const Gallery()),
      GetPage(name: '/detail', page: () => Detail()),
      GetPage(name: '/bbs', page: () => const BBS()),
      GetPage(
        name: '/animated_background_test',
        page: () => const AnimatedBackgroundTest(),
      ),
      GetPage(name: '/pass_generator', page: () => const Generate()),
    ]);
    return super.createElement();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Playground',
      theme: ThemeData.light().overrides(),
      darkTheme: ThemeData.dark().overrides(),
      initialRoute: '/',
      // getPages: [
      //   GetPage(name: '/', page: () => const Home()),
      //   GetPage(name: '/gallery', page: () => const Gallery()),
      //   GetPage(name: '/detail', page: () => Detail()),
      //   GetPage(name: '/bbs', page: () => const BBS()),
      //   GetPage(
      //     name: '/animated_background_test',
      //     page: () => const AnimatedBackgroundTest(),
      //   ),
      //   GetPage(name: '/pass_generator', page: () => const Generate()),
      //   GetPage(name: '/trends', page: () => const Trends()),
      // ],
      // unknownRoute: GetPage(name: '/unknown', page: () => const Unknown()),
      onGenerateRoute: (RouteSettings settings) {
        FixedPageRedirect redirect = FixedPageRedirect(
          settings: settings,
          unknownRoute: GetPage(name: '/unknown', page: () => const Unknown()),
        );
        GetPageRoute page = redirect.page();
        if (redirect.isUnknown) {
          // Unknown route need return null, Because it could be the middle page
          return null;
        }
        return page;
      },
      onUnknownRoute: (settings) => GetPageRoute(
        settings: settings,
        page: () => const Unknown(),
      ),
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

// Fix unknownRoute not working: https://github.com/jonataslaw/getx/issues/1739
class FixedPageRedirect extends PageRedirect {
  FixedPageRedirect(
      {GetPage? route,
      GetPage? unknownRoute,
      bool isUnknown = false,
      RouteSettings? settings})
      : super(
            route: route,
            unknownRoute: unknownRoute,
            isUnknown: isUnknown,
            settings: settings);

  /// check if redirect is needed
  @override
  bool needRecheck() {
    if (settings == null && route != null) {
      settings = route;
    }
    final match = Get.routeTree.matchRoute(settings!.name!);
    Get.parameters = match.parameters;

    // fix unknownRoute don't work
    // // No Match found
    // if (match.route == null) {
    if (match.route == null ||
        match.route!.name != Uri.parse(settings!.name!).path) {
      isUnknown = true;
      return false;
    }

    final runner = MiddlewareRunner(match.route!.middlewares);
    route = runner.runOnPageCalled(match.route);
    addPageParameter(route!);

    // No middlewares found return match.
    if (match.route!.middlewares == null || match.route!.middlewares!.isEmpty) {
      return false;
    }
    final newSettings = runner.runRedirect(settings!.name);
    if (newSettings == null) {
      return false;
    }
    settings = newSettings;
    return true;
  }
}
