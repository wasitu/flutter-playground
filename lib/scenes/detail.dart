import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Detail extends StatelessWidget {
  final String? id;

  Detail({Key? key, String? id})
      : id = id ?? Get.parameters['id'],
        super(key: key);

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
              child: const Text('DETAIL 2'),
              onPressed: () {
                Get.toNamed('/detail?id=2');
              },
            ),
            TextButton(
              child: const Text('PUSH TEST'),
              onPressed: () {
                navigator?.push(
                  GetPageRoute(
                    settings: const RouteSettings(name: '/detail?id=22'),
                    page: () => Detail(),
                  ),
                );
              },
            ),
            TextButton(
              child: const Text('POP'),
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
