import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_playground/utility/local_storage.dart';

import 'package:get/get.dart';
import 'package:random_password_generator/random_password_generator.dart';
import 'package:flutter_picker/flutter_picker.dart';

class PasswordGenerator extends StatelessWidget {
  final scrollController = ScrollController();

  PasswordGenerator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = [
      'Length',
      'Letters',
      'Numbers',
      'Uppercase',
      'Special Character'
    ];
    final controller =
        Get.put(PasswordGeneratorController(), tag: '${context.hashCode}');
    return Obx(
      () => Flexible(
        child: Column(
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: double.infinity,
                minHeight: 128,
              ),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'password',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: SingleChildScrollView(
                            controller: scrollController,
                            scrollDirection: Axis.horizontal,
                            child: SelectableText(
                              controller.password.value
                                  .replaceAll('', '\u200B'),
                              maxLines: 1,
                              scrollPhysics:
                                  const NeverScrollableScrollPhysics(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    controller.generate();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    primary: Colors.white,
                    padding: const EdgeInsets.all(12),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Generate'),
                  ),
                ),
                const SizedBox(width: 32),
                TextButton(
                  onPressed: () {
                    controller.copyToClipboard();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    primary: Colors.white,
                    padding: const EdgeInsets.all(12),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Copy'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(items[0]),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Row(
                    children: [
                      Text(
                        controller.length.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .button
                            ?.copyWith(color: Theme.of(context).primaryColor),
                      ),
                      const Icon(Icons.arrow_downward_outlined),
                    ],
                  ),
                  onPressed: () {
                    controller.showPicker(
                      context: context,
                      title: items[0],
                      data: controller.lengthData,
                      initialIndex: controller.lengthIndex,
                      onConfirm: (picker, selects) {
                        controller.length.value =
                            controller.lengthData[selects.first];
                        controller.generate();
                      },
                    );
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(items[1]),
                CupertinoSwitch(
                  activeColor: Theme.of(context).primaryColor,
                  value: controller.letters.value,
                  onChanged: (value) {
                    controller.letters.value = value;
                    controller.generate();
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(items[2]),
                CupertinoSwitch(
                  activeColor: Theme.of(context).primaryColor,
                  value: controller.numbers.value,
                  onChanged: (value) {
                    controller.numbers.value = value;
                    controller.generate();
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(items[3]),
                CupertinoSwitch(
                  activeColor: Theme.of(context).primaryColor,
                  value: controller.uppercase.value,
                  onChanged: (value) {
                    controller.uppercase.value = value;
                    controller.generate();
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(items[4]),
                CupertinoSwitch(
                  activeColor: Theme.of(context).primaryColor,
                  value: controller.specialChar.value,
                  onChanged: (value) {
                    controller.specialChar.value = value;
                    controller.generate();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PasswordGeneratorController extends GetxController {
  final lengthData = List<int>.generate(100, (i) => i + 1);

  final password = ''.obs;
  final length = LocalStorage.shared.length.obs;

  final letters = LocalStorage.shared.letters.obs;
  final numbers = LocalStorage.shared.numbers.obs;
  final uppercase = LocalStorage.shared.uppercase.obs;
  final specialChar = LocalStorage.shared.specialChar.obs;

  int get lengthIndex => lengthData.indexOf(length.value);

  PasswordGeneratorController() {
    letters.listen((value) {
      forceLettersToEnabled();
      LocalStorage.shared.letters = value;
    });
    numbers.listen((value) {
      forceLettersToEnabled();
      LocalStorage.shared.numbers = value;
    });
    uppercase.listen((value) {
      forceLettersToEnabled();
      LocalStorage.shared.uppercase = value;
    });
    specialChar.listen((value) {
      forceLettersToEnabled();
      LocalStorage.shared.specialChar = value;
    });
    length.listen((value) {
      LocalStorage.shared.length = value;
    });
    generate();
  }

  void generate() {
    password.value = RandomPasswordGenerator().randomPassword(
      letters: letters.value,
      numbers: numbers.value,
      uppercase: uppercase.value,
      specialChar: specialChar.value,
      passwordLength: length.toDouble(),
    );
  }

  void copyToClipboard() async {
    final data = ClipboardData(text: password.value);
    await Clipboard.setData(data);
  }

  void showPicker({
    required BuildContext context,
    required String title,
    required List<dynamic> data,
    int initialIndex = 0,
    PickerConfirmCallback? onConfirm,
    PickerSelectedCallback? onSelect,
    VoidCallback? onCancel,
  }) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    Picker picker = Picker(
      height: 192,
      headerDecoration: BoxDecoration(
        color: Theme.of(context).cardColor,
      ),
      selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
        background: Theme.of(context).primaryColor.withOpacity(0.1),
      ),
      title: const Text(''),
      cancel: const SizedBox(),
      confirmText: 'Select',
      confirmTextStyle: Theme.of(context).textTheme.button?.copyWith(
            color: Theme.of(context).primaryColor,
          ),
      itemExtent: 32 * textScaleFactor,
      magnification: 1.2,
      selecteds: [initialIndex],
      adapter: PickerDataAdapter<String>(
        pickerdata: data,
      ),
      changeToFirst: true,
      textAlign: TextAlign.left,
      columnPadding: const EdgeInsets.symmetric(vertical: 12.0),
      onConfirm: onConfirm,
      onSelect: onSelect,
      onCancel: onCancel,
    );
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: picker.makePicker(),
          );
        });
  }

  void forceLettersToEnabled() {
    if (!letters.value &&
        !numbers.value &&
        !uppercase.value &&
        !specialChar.value) {
      letters.value = true;
    }
  }
}
