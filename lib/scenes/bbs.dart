import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_playground/utility/theme_color.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class BBS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BBSModel>(
      create: (_) => BBSModel(),
      child: Consumer<BBSModel>(
        builder: (context, model, child) {
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
                constraints: BoxConstraints(maxWidth: 480),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          ListView.builder(
                            clipBehavior: Clip.none,
                            reverse: true,
                            itemCount: model.contributes.length,
                            itemBuilder: (context, index) {
                              final c = model.contributes[index];
                              print(c.name + c.message);
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
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
                                                  color: ThemeColor.of(context)
                                                      .label2),
                                        ),
                                        Text(
                                          '${c.message}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              ?.copyWith(
                                                  color: ThemeColor.of(context)
                                                      .label2),
                                        ),
                                      ],
                                    )),
                              );
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              NeumorphicButton(
                                style: neumorphicStyle,
                                child: Text('POST'),
                                onPressed: () {
                                  model.post();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Neumorphic(
                      style: neumorphicStyle,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              controller: model.nameEditingController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: '${model.defaultName}',
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
                                controller: model.messageEditingController,
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
          ));
        },
      ),
    );
  }
}

class BBSModel extends ChangeNotifier {
  final GlobalKey<AnimatedListState> animatedListKey =
      GlobalKey<AnimatedListState>();
  final TextEditingController nameEditingController = TextEditingController();
  final TextEditingController messageEditingController =
      TextEditingController();
  final String uuid = Uuid().v4();

  get defaultName => uuid.substring(0, 8);
  get contributes => _contributes;

  final List<Contribute> _contributes = [];

  void post() {
    final name = nameEditingController.text;
    final message = messageEditingController.text;
    if (message.isEmpty) return;
    final c = Contribute(
      uuid: uuid,
      name: name.isNotEmpty ? name : defaultName,
      message: message,
    );
    _contributes.add(c);
    messageEditingController.clear();
    notifyListeners();
  }
}

class Contribute {
  final String uuid;
  final String name;
  final String message;

  const Contribute({
    required this.uuid,
    required this.name,
    required this.message,
  });
}
