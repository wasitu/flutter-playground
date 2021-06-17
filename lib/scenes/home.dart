import 'package:flutter/material.dart';
import 'package:flutter_playground/scenes/signin.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
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
              buildMenuItem(
                context: context,
                text: 'ANIMATED BACKGROUND TEST',
                callback: () {
                  Get.toNamed('/animated_background_test');
                },
              ),
              buildMenuItem(
                context: context,
                text: 'SIGNIN',
                callback: () {
                  navigator?.push(
                    GetPageRoute(
                      settings: RouteSettings(name: '/signin'),
                      page: () => Signin(),
                      fullscreenDialog: true,
                    ),
                  );
                },
              ),
              buildMenuItem(
                context: context,
                text: 'UNKNOWN',
                callback: () {
                  Get.toNamed('/abc');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuItem(
      {required BuildContext context,
      required String text,
      VoidCallback? callback}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(' - '),
        Flexible(
          child: TextButton(
            style: Theme.of(context).textButtonTheme.style,
            child: Text(text),
            onPressed: callback,
          ),
        ),
      ],
    );
  }
}
