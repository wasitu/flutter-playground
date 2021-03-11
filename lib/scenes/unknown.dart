import 'package:flutter/material.dart';

class Unknown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(
          '404',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
    );
  }
}
