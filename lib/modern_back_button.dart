import 'package:flutter/material.dart';
import 'package:modern_flutter_components/modern_flutter_components_extension.dart';

class ModernBackButton extends StatelessWidget {
  const ModernBackButton({super.key, this.onTap});

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap ?? () => Navigator.of(context).pop(),
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: context.borderColor,
              borderRadius: BorderRadius.circular(50),
            ),
            width: 38,
            height: 38,
            margin: const EdgeInsets.only(left: 4),
            alignment: Alignment.center,
            child: Icon(Icons.arrow_back_ios_new_rounded, size: 19, color: context.primary),
          ),
        ),
      ),
    );
  }
}
