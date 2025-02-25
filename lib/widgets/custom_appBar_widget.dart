import 'package:flutter/material.dart';
import 'package:pokemon/constants/app_colors.dart';

import '../constants/text_theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;

  final bool isBackButtonVisible;

  const CustomAppBar({
    Key? key,
    required this.text,
    this.isBackButtonVisible = true,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading:
          isBackButtonVisible
              ? IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios, color: AppColors.white),
              )
              : null,

      backgroundColor: AppColors.colorBlue,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),

      title: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Text(text, style: TextThemes.textTitle),
      ),
    );
  }
}
