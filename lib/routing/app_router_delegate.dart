import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/routing/app_page.dart';
import 'package:flutter_playground/scenes/detail.dart';
import 'package:flutter_playground/scenes/gallery.dart';
import 'package:flutter_playground/scenes/home.dart';
import 'package:flutter_playground/scenes/unknown.dart';
import 'package:flutter_playground/utility/custom_scroll_behavior.dart';

class AppRouterDelegate extends RouterDelegate<String>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<String> {
  final _stack = <String>[];

  static AppRouterDelegate of(BuildContext context) {
    final delegate = Router.of(context).routerDelegate;
    assert(delegate is AppRouterDelegate, 'Delegate type must match');
    return delegate as AppRouterDelegate;
  }

  AppRouterDelegate();

  final RouteFactory onGenerateRoute = (RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) {
        return ScrollConfiguration(
          behavior: CustomScrollBehavior(),
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Column(
              children: [
                SizedBox(height: 16),
                Flexible(
                  child: Builder(builder: (context) {
                    if (settings.name == '/') return Home();
                    if (settings.name == 'gallery') return Gallery();
                    if (RegExp(r'details#\S+$').hasMatch(settings.name ?? '')) {
                      final id = settings.name?.split('#').last;
                      return Detail(id: id);
                    }
                    return Unknown();
                  }),
                ),
              ],
            ),
          ),
        );
      },
    );
  };

  @override
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  String get currentConfiguration => _stack.isNotEmpty
      ? _stack.reduce((value, element) {
          return value.endsWith('/') ? value + element : value + '/' + element;
        })
      : '';

  List<String> get stack => List.unmodifiable(_stack);

  void push(String newRoute) {
    _stack.add(newRoute);
    notifyListeners();
  }

  void remove(String routeName) {
    _stack.remove(routeName);
    notifyListeners();
  }

  @override
  Future<void> setInitialRoutePath(String configuration) {
    return setNewRoutePath(configuration);
  }

  @override
  Future<void> setNewRoutePath(String configuration) {
    _stack
      ..clear()
      ..add('/');
    final replaced = configuration.replaceFirst('/', '');
    if (replaced.isNotEmpty) _stack.addAll(replaced.split('/').toList());
    return SynchronousFuture<void>(null);
  }

  bool _onPopPage(Route<dynamic> route, dynamic result) {
    if (_stack.isNotEmpty) {
      if (_stack.last == route.settings.name) {
        _stack.remove(route.settings.name);
        notifyListeners();
      }
    }
    return route.didPop(result);
  }

  @override
  Widget build(BuildContext context) {
    var key = '';
    return Navigator(
      key: navigatorKey,
      onPopPage: _onPopPage,
      pages: _stack.map((e) {
        key += '/' + e;
        return AppPage(
          key: ValueKey(key),
          name: e,
          routeFactory: onGenerateRoute,
        );
      }).toList(),
    );
  }
}
