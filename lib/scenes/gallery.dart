import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class Gallery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GalleryModel>(
      create: (_) => GalleryModel(),
      child: Consumer<GalleryModel>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text('GALLERY'),
            ),
            body: Center(
              child: FutureBuilder<List<Photo>>(
                future: model.fetchPhotos(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done)
                    return CircularProgressIndicator();
                  return Wrap(
                    spacing: 16,
                    children: snapshot.data?.map((e) {
                          return buildPhotoWidget(e);
                        }).toList() ??
                        [],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildPhotoWidget(Photo e) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          launch(e.photographerLink);
        },
        child: Column(
          children: [
            Image.network(
              e.imageLink,
              fit: BoxFit.cover,
              width: 192,
              height: 192,
              loadingBuilder: (context, child, loadingProgress) {
                return loadingProgress == null
                    ? Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 4,
                              blurRadius: 6,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                        child: child)
                    : Container(child: child);
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.white,
                  child: Text(error.toString()),
                );
              },
            ),
            SizedBox(height: 8),
            Text(e.photographer),
          ],
        ),
      ),
    );
  }
}

class GalleryModel extends ChangeNotifier {
  GalleryModel();

  Future<List<Photo>> fetchPhotos() {
    final completer = Completer<List<Photo>>();
    FirebaseFirestore.instance.collection('photos').snapshots().listen((event) {
      final photos = event.docs.map((e) => Photo(data: e.data())).toList();
      completer.complete(photos);
    });
    return completer.future;
  }
}

class Photo {
  Map<String, dynamic>? data;
  String get photographer => data?['photographer'];
  String get imageLink => data?['image_link'];
  String get photographerLink => data?['photographer_link'];

  Photo({required this.data});
}