import 'package:flutter/material.dart';
import 'package:flutter_playground/scenes/unknown.dart';

class AppPage extends Page {
  AppPage({
    required String name,
    required this.routeFactory,
    LocalKey? key,
    Object? arguments,
  }) : super(
          key: key ?? ValueKey(name),
          name: name,
          arguments: arguments,
        );

  final RouteFactory routeFactory;

  @override
  Route createRoute(BuildContext context) =>
      routeFactory(this) ??
      MaterialPageRoute(
        settings: this,
        builder: (BuildContext context) {
          return Unknown();
        },
      );
}
