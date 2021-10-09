import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({Key? key, required String title})
      : super(
            key: key,
            title: Padding(
                padding: const EdgeInsets.only(top: 16.0), child: Text(title)));
}
