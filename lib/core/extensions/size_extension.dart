import 'package:flutter/material.dart';

extension SizeExtension on BuildContext {

  double dynamicWidth(double val) => MediaQuery.of(this).size.width * val;
  double dynamicHeight(double val) => MediaQuery.of(this).size.height * val;

  double get dynamicLowWidth => dynamicWidth(.10);
}

extension ValExtension on BuildContext{
  double get lowVal => dynamicWidth(.3);
  double get mediumVal => dynamicWidth(.2);
  double get highVal => dynamicWidth(.1);
}


extension PaddingExtension on BuildContext{
  EdgeInsets get paddingLow => EdgeInsets.all(lowVal);
  EdgeInsets get paddingMedium => EdgeInsets.all(mediumVal);
  EdgeInsets get paddingHigh => EdgeInsets.all(highVal);
}
