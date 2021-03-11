import 'package:flutter/material.dart';
import 'package:flutter_playground/routing/app_router_delegate.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: TextButton(
          child: Text('DETAIL 1'),
          onPressed: () {
            AppRouterDelegate.of(context).push('details#1');
          },
        ),
      ),
    );
  }
}
