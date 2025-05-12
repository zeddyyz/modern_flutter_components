import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:modern_flutter_components/adaptive_gap.dart';
import 'package:modern_flutter_components/modern_flutter_components_extension.dart';

/// Shows an alert snackbar with a message and an icon.
class AlertSnackbar {
  static Future<ScaffoldFeatureController<SnackBar, SnackBarClosedReason>> show(
    BuildContext context, {
    bool isError = false,
    required String message,
    Duration? duration,
  }) async {
    final snackbar = SnackBar(
      content: Column(
        children: [
          HugeIcon(
            icon: isError ? HugeIcons.strokeRoundedAlert02 : HugeIcons.strokeRoundedAlertCircle,
            color: isError ? Colors.red : Colors.blueAccent,
          ),
          AdaptiveGap(gap: 8),
          Text(message, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
        ],
      ),
      duration: duration ?? const Duration(seconds: 2),
      backgroundColor: context.cardColor,
    );

    return ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  static Future<ScaffoldFeatureController<SnackBar, SnackBarClosedReason>> showPill(
    BuildContext context, {
    bool isError = false,
    required String message,
    Duration? duration,
  }) async {
    final snackbar = SnackBar(
      content: Row(
        children: [
          HugeIcon(
            icon: isError ? HugeIcons.strokeRoundedAlert02 : HugeIcons.strokeRoundedAlertCircle,
            color: isError ? Colors.red : Colors.blueAccent,
          ),
          AdaptiveGap(gap: 8),
          Text(message, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
        ],
      ),
      duration: duration ?? const Duration(seconds: 2),
      backgroundColor: context.cardColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
        side: BorderSide(
          color:
              isError
                  ? Colors.red.withValues(alpha: 0.3)
                  : Colors.blueAccent.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      width: context.adaptiveSize(240),
      elevation: 0,
    );

    return ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
