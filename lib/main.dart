import 'package:flutter/material.dart';
import 'package:flutter_playground/scenes/detail.dart';
import 'package:flutter_playground/scenes/home.dart';
import 'package:flutter_playground/scenes/unknown.dart';
import 'package:flutter_playground/utility.dart';

import 'routing/app_route_information_parser.dart';
import 'routing/app_router_delegate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppRouterDelegate _routerDelegate = AppRouterDelegate(
    onGenerateRoute: (RouteSettings settings) {
      return MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) {
          sprint(settings.name ?? '');
          switch (settings.name) {
            case '/':
              return Home();
            default:
              if (RegExp(r'details#\S+$').hasMatch(settings.name ?? '')) {
                final id = settings.name?.split('#').last;
                return Detail(id: id);
              }
              return Unknown();
          }
        },
      );
    },
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Playground',
      routerDelegate: _routerDelegate,
      routeInformationParser: AppRouteInformationParser(),
    );
  }
}
