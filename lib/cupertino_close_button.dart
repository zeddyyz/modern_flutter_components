import 'package:flutter/material.dart';

class CupertinoCloseButton extends StatelessWidget {
  const CupertinoCloseButton({super.key, this.bgColor, this.iconColor, this.onTap, this.iconSize});

  final Color? bgColor;
  final Color? iconColor;
  final VoidCallback? onTap;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    Color iconButtonBackgroundColor = isLightMode ? Colors.grey.shade200 : Colors.grey.shade900;
    Color primary = isLightMode ? Colors.black : Colors.white;

    return InkWell(
      onTap: onTap ?? () => Navigator.pop(context),
      borderRadius: BorderRadius.circular(40),
      splashFactory: NoSplash.splashFactory,
      splashColor: Colors.transparent,
      child: Container(
        height: 36,
        width: 36,
        decoration: BoxDecoration(
          color: bgColor ?? iconButtonBackgroundColor,
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.close_rounded, size: iconSize ?? 24, color: iconColor ?? primary),
      ),
    );
  }
}
