import 'dart:math';

import 'package:willmod3/configs/constant.dart';
import 'package:willmod3/configs/myapp.dart';

String getPicDummy() {
  Random rnd = Random();
  return "?dummy=${rnd.nextInt(1000)}";
}
