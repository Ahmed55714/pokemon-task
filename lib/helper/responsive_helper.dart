import 'package:flutter/material.dart';

class ResponsiveHelper {
  final BuildContext context;
  ResponsiveHelper(this.context);

  double height(double value) => MediaQuery.of(context).size.height * value;
  double width(double value) => MediaQuery.of(context).size.width * value;
}
