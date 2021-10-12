import 'package:flutter/material.dart';
import 'package:flutter_playground/widget/password_generator.dart';

class Generate extends StatelessWidget {
  const Generate({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context).copyWith(
        textScaleFactor: MediaQuery.of(context).textScaleFactor * 1.3);
    return MediaQuery(
      data: data,
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      PasswordGenerator(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
