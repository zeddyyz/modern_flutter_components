import 'package:flutter/material.dart';
import 'package:modern_flutter_components/cupertino_close_button.dart';
import 'package:modern_flutter_components/modern_flutter_components_extension.dart';

class BottomSheetHeader extends StatelessWidget {
  const BottomSheetHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: context.defaultPadding, vertical: 8),
      color: Theme.of(context).bottomSheetTheme.backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: Theme.of(context).textTheme.headlineMedium),
          CupertinoCloseButton(),
        ],
      ),
    );
  }
}
