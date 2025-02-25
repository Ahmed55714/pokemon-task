import 'package:flutter/material.dart';
import '../helper/responsive_helper.dart';
import 'app_colors.dart';

class TextThemes {
  final BuildContext context;
  final ResponsiveHelper rh;

  TextThemes(this.context) : rh = ResponsiveHelper(context);

  static final TextStyle textTitle = TextStyle(
    color: AppColors.white,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    fontFamily: 'BoldCairo',
  );

    static final TextStyle text = TextStyle(
    color: AppColors.greySoftTwo,
    fontSize: 14,
   
    fontFamily: 'BoldCairo',
  );

  static final TextStyle textDetals = TextStyle(
    color: Colors.grey.shade700,
    fontSize: 16,
    fontFamily: 'BoldCairo',
  );

    static final TextStyle headertextDetals = TextStyle(
    color: AppColors.colorBlue,
    fontSize: 18,
    fontWeight: FontWeight.bold,
    fontFamily: 'BoldCairo',
  );

  static final TextStyle subTitle = TextStyle(
    color: Colors.white70,
    fontSize: 18,
    fontWeight: FontWeight.w500,
    fontFamily: 'BoldCairo',
  );

  static final TextStyle nameTitle = TextStyle(
    color: AppColors.white,
    fontSize: 32,
    fontWeight: FontWeight.bold,
    fontFamily: 'BoldCairo',
  );

}
