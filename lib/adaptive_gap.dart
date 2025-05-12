import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:modern_flutter_components/modern_flutter_components_extension.dart';

class AdaptiveGap extends StatelessWidget {
  const AdaptiveGap({super.key, required this.gap});

  final double gap;

  @override
  Widget build(BuildContext context) {
    return Gap(context.adaptiveSize(gap));
  }
}
