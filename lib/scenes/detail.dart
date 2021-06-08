import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Detail extends StatelessWidget {
  final String? id;

  Detail() : this.id = Get.parameters['id'];

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
                Get.toNamed('/detail?id=2');
              },
            ),
            TextButton(
              child: Text('POP'),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
