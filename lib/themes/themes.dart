import 'package:flutter/material.dart';

class Themes {
  String primaryColor;
  String backgroundColor;
  
  Themes(this.primaryColor, this.backgroundColor);

  void changeColor(String newPrimaryColor, String newbackgroundColor) {
    primaryColor = newPrimaryColor;
    backgroundColor = newbackgroundColor;
  }
}

class Light extends Themes {
  Light() : super("#1C2833", "#FDFEFE");
}

class Dark extends Themes {
  Dark() : super("##F0F3F4", "#2C3E50");
}

class Blue extends Themes {
  Blue() : super("##E74C3C", "#85C1E9");
}
