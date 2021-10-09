import 'package:flutter/foundation.dart';

void sprint(String msg, {Object? obj}) {
  debugPrint('${describeIdentity(obj)} : $msg');
}
