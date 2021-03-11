import 'package:flutter/foundation.dart';

void sprint(String msg, {Object? obj}) {
  print('${describeIdentity(obj)} : $msg');
}
