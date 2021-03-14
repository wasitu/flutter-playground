import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FirebaseTestModel>(
      create: (_) => FirebaseTestModel(),
      child: Consumer<FirebaseTestModel>(
        builder: (context, value, child) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('AAAAA'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class FirebaseTestModel extends ChangeNotifier {
  FirebaseTestModel() {
    FirebaseFirestore.instance.collection('photos').snapshots().listen((event) {
      event.docs.forEach((element) {
        print(element.data());
      });
    });
  }
}
