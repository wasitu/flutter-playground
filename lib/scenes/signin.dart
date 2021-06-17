import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_playground/scenes/home.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../extension/build_context_extension.dart';

class Signin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SigninController());
    return Scaffold(
      appBar: AppBar(),
      body: Obx(
        () => SafeArea(
          child: IgnorePointer(
            ignoring: controller.isLogining,
            child: SingleChildScrollView(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 480),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'signin.title',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 56,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'signin.mailaddress.label',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                                SizedBox(height: 16),
                                TextField(
                                  autocorrect: true,
                                  keyboardType: TextInputType.emailAddress,
                                  obscureText: false,
                                  enableSuggestions: true,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(12),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context).dividerColor,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context).accentColor,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    hintText: 'signin.mailaddress.hint',
                                  ),
                                  onChanged: (value) {
                                    controller.mail = value.trim();
                                  },
                                ),
                                SizedBox(height: 40),
                                Text(
                                  'signin.password.label',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                                SizedBox(height: 16),
                                TextField(
                                  autocorrect: true,
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(12),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context).dividerColor,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context).accentColor,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    hintText: 'password.hint',
                                  ),
                                  onChanged: (value) {
                                    controller.pass = value;
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 40),
                            context.buildFlatButton(
                              title: 'signin.button.signin',
                              isEnabled: controller.isEnabled,
                              isLoading: controller.isLogining,
                              onPressed: () {
                                if (!controller.isEnabled) {
                                  return;
                                }
                                controller.isLogining = true;
                                FocusScope.of(context).unfocus();
                                Future.delayed(Duration(seconds: 1))
                                    .then((value) {
                                  navigator?.pushReplacement(
                                    GetPageRoute(
                                      routeName: '/',
                                      page: () => Home(),
                                      transition: Transition.fadeIn,
                                      fullscreenDialog: true,
                                    ),
                                  );
                                });
                              },
                            ),
                            SizedBox(height: 32),
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {},
                              child: Text(
                                'signin.button.forgot_password',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    ?.copyWith(
                                        color: Theme.of(context).accentColor),
                              ),
                            ),
                          ],
                        ),
                      ),
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

class SigninController extends GetxController {
  SigninController();

  RxString _mail = ''.obs;
  String get mail => _mail.value;
  set mail(String value) {
    _mail.value = value;
  }

  RxString _pass = ''.obs;
  String get pass => _pass.value;
  set pass(String value) {
    _pass.value = value;
  }

  bool get isEnabled => !(_mail.isEmpty || _pass.isEmpty);

  RxBool _isLogining = false.obs;
  bool get isLogining => _isLogining.value;
  set isLogining(bool value) {
    _isLogining.value = value;
  }
}
