import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({required String title})
      : super(
            title: Padding(
                padding: EdgeInsets.only(top: 16.0), child: Text(title)));
}
