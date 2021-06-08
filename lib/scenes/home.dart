import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'FLUTTER PLAYGROUND',
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(height: 32),
            // Text(
            //   'TEST SCENES',
            //   style: Theme.of(context).textTheme.headline6,
            // ),
            // SizedBox(height: 16),
            buildMenuItem(
              context: context,
              text: 'TRANSITION TEST',
              callback: () {
                Get.toNamed('/detail?id=10');
              },
            ),
            buildMenuItem(
              context: context,
              text: 'UNKNOWN',
              callback: () {
                Get.toNamed('/abc');
              },
            ),
            buildMenuItem(
              context: context,
              text: 'GALLERY',
              callback: () {
                Get.toNamed('/gallery');
              },
            ),
            buildMenuItem(
              context: context,
              text: 'BBS',
              callback: () {
                Get.toNamed('/bbs');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(
      {required BuildContext context,
      required String text,
      VoidCallback? callback}) {
    return Row(
      children: [
        Text(' - '),
        TextButton(
          child: Text(text),
          onPressed: callback,
        ),
      ],
    );
  }
}
