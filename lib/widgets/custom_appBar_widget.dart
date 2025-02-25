import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final bool isColorWhite;
  final List<Widget>? actions;

  const CustomAppBar({
    Key? key,
    required this.text,
    this.isColorWhite = false,
    this.actions,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isColorWhite ? Colors.white : Colors.blue;
    final textColor = isColorWhite ? Colors.blue : Colors.white;

    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
 
      title: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      actions: actions,
    );
  }
}
