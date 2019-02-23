import 'package:flutter/material.dart';

class MamakStyles {
  static TextStyle headerFooterSmallStyle() {
    return TextStyle(fontSize: 10, color: Colors.black);
  }

  static TextStyle tableHeaderStyle() {
    return TextStyle(fontSize: 12, height: 1.0);
  }

  static TextStyle expansionTitleStyle() {
    return TextStyle(fontSize: 14, color: Colors.blueGrey, height: 1.0);
  }

  static TextStyle paddingTitleStyle(MaterialColor textColor) {
    return TextStyle(fontSize: 14, color: textColor, height: 1.0);
  }

  static TextStyle paddingSubTitleStyle() {
    return TextStyle(fontSize: 11, color: Colors.grey, height: 1.0);
  }
}
