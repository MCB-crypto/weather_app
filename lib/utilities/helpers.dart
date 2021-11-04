import 'package:flutter/cupertino.dart';

class Helpers {
  BuildContext context;
  Helpers(this.context);

  double getScreenWidth() {
    return MediaQuery.of(context).size.width;
  }

  double getScreenHeight() {
    return MediaQuery.of(context).size.height;
  }
}