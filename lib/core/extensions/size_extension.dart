import 'package:flutter/material.dart';

// size extension for responsive design
extension SizeExtension on BuildContext {
  double dynamicWidth(double val) => MediaQuery.of(this).size.width * val;
  double dynamicHeight(double val) => MediaQuery.of(this).size.height * val;

  double get dynamicLowWidth => dynamicWidth(.10);
}

// value extension for responsive design
extension ValExtension on BuildContext {
  double get lowVal => dynamicWidth(.3);
  double get mediumVal => dynamicWidth(.2);
  double get highVal => dynamicWidth(.1);
  double get tooHighVal => dynamicWidth(.05);
}

// padding extension for responsive design
extension PaddingExtension on BuildContext {
  EdgeInsets get paddingLow => EdgeInsets.all(lowVal);
  EdgeInsets get paddingOnlyLow => EdgeInsets.only(left: lowVal, right: lowVal);
  EdgeInsets get paddingMedium => EdgeInsets.all(mediumVal);
  EdgeInsets get paddingHigh => EdgeInsets.all(highVal);
  EdgeInsets get paddingOnlyHigh =>
      EdgeInsets.only(left: highVal, right: highVal);
}
