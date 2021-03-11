import 'package:flutter/material.dart';
import 'package:flutter_playground/routing/app_router_delegate.dart';

class Detail extends StatelessWidget {
  final String? id;

  Detail({
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Viewing details for item $id'),
            TextButton(
              child: Text('DETAIL 2'),
              onPressed: () {
                AppRouterDelegate.of(context).push('details/2');
              },
            ),
            TextButton(
              child: Text('POP'),
              onPressed: () {
                AppRouterDelegate.of(context).popRoute();
              },
            ),
          ],
        ),
      ),
    );
  }
}
