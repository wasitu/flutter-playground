import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_playground/utility/theme_color.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class BBS extends StatelessWidget {
  const BBS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BBSController());
    final neumorphicStyle = NeumorphicStyle(
      depth: 2,
      shape: NeumorphicShape.flat,
      lightSource: LightSource.bottomRight,
      color: Theme.of(context).scaffoldBackgroundColor,
      intensity: 0.2,
    );
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      FutureBuilder<dynamic>(
                          future: controller._fetchContributesCache,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState !=
                                ConnectionState.done) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            return Obx(
                              () => Scrollbar(
                                isAlwaysShown: true,
                                child: ListView.builder(
                                  clipBehavior: Clip.none,
                                  reverse: true,
                                  itemCount: controller.contributes.length,
                                  itemBuilder: (context, index) {
                                    final c = controller.contributes[index];
                                    debugPrint(c.name + c.message);
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 16.0),
                                      child: Neumorphic(
                                          style: neumorphicStyle,
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${c.name}:',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    ?.copyWith(
                                                        color: ThemeColor.of(
                                                                context)
                                                            .label2),
                                              ),
                                              Text(
                                                '${c.message}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    ?.copyWith(
                                                        color: ThemeColor.of(
                                                                context)
                                                            .label2),
                                              ),
                                            ],
                                          )),
                                    );
                                  },
                                ),
                              ),
                            );
                          }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          NeumorphicButton(
                            style: neumorphicStyle,
                            child: const Text('POST'),
                            onPressed: () {
                              controller.post();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Neumorphic(
                  style: neumorphicStyle,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: controller.nameEditingController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '${controller.defaultName}',
                            labelText: 'Name:',
                            alignLabelWithHint: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                          keyboardType: TextInputType.multiline,
                          maxLines: 1,
                          onChanged: (value) {
                            // model.question = value;
                          },
                        ),
                        Scrollbar(
                          child: TextField(
                            controller: controller.messageEditingController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Input ...',
                              labelText: 'Message:',
                              alignLabelWithHint: true,
                            ),
                            keyboardType: TextInputType.multiline,
                            maxLines: 4,
                            minLines: 1,
                            onChanged: (value) {
                              // model.question = value;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BBSController extends GetxController {
  final GlobalKey<AnimatedListState> animatedListKey =
      GlobalKey<AnimatedListState>();
  final TextEditingController nameEditingController = TextEditingController();
  final TextEditingController messageEditingController =
      TextEditingController();
  final String uuid = const Uuid().v4();

  get defaultName => uuid.substring(0, 8);
  get contributes => _contributes;

  final _contributes = <Contribute>[].obs;

  Future<List<Contribute>>? _fetchContributesCache;
  get fetchContributesCache => _fetchContributesCache;

  CollectionReference get collection =>
      FirebaseFirestore.instance.collection('contributes');

  BBSController() {
    // Avoid transition gets slow
    _fetchContributesCache = Future.delayed(const Duration(milliseconds: 500))
        .then((value) => fetchContributes());
  }

  void post() {
    final name = nameEditingController.text;
    final message = messageEditingController.text;
    if (message.isEmpty) return;
    final data = {
      'uuid': uuid,
      'name': name.isNotEmpty ? name : defaultName,
      'message': message,
    };
    final c = Contribute(data: data);
    _contributes.add(c);
    // collection.add(data);
    messageEditingController.clear();
  }

  Future<List<Contribute>> fetchContributes() async {
    final completer = Completer<List<Contribute>>();
    collection.snapshots().listen((event) {
      final contributes =
          event.docs.map((e) => Contribute(data: e.data())).toList();
      _contributes.value = contributes;
      if (!completer.isCompleted) {
        completer.complete(contributes);
      }
    });
    return completer.future;
  }
}

class Contribute {
  Map<String, dynamic>? data;
  String get uuid => data?['uuid'];
  String get name => data?['name'];
  String get message => data?['message'];

  Contribute({required this.data});
}
