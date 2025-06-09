import 'package:flutter/material.dart';
import 'package:modern_flutter_components/modern_flutter_components.dart';

class ModernAlertDialogWidget extends StatelessWidget {
  const ModernAlertDialogWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.confirmText,
    required this.confirmColor,
    required this.cancelText,
    required this.onConfirm,
    required this.onCancel,
  });

  final Widget icon;
  final String title;
  final String description;
  final String confirmText;
  final Color confirmColor;
  final String cancelText;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedSuperellipseBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 8,
      backgroundColor: context.cardColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                icon,
                SizedBox(width: 16),
                Expanded(
                  child: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              description,
              style: TextStyle(fontSize: 14, color: context.primary, fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: onCancel,
                  style: ButtonStyle(
                    splashFactory: NoSplash.splashFactory,
                    foregroundColor: WidgetStateProperty.all(Colors.blue),
                    shape: WidgetStateProperty.all(
                      RoundedSuperellipseBorder(borderRadius: BorderRadius.circular(13)),
                    ),
                  ),
                  child: const Text('Cancel', style: TextStyle(fontWeight: FontWeight.w600)),
                ),
                TextButton(
                  onPressed: onConfirm,
                  style: ButtonStyle(
                    splashFactory: NoSplash.splashFactory,
                    backgroundColor: WidgetStateProperty.all(confirmColor.withValues(alpha: 0.1)),
                    padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 20)),
                    shape: WidgetStateProperty.all(
                      RoundedSuperellipseBorder(borderRadius: BorderRadius.circular(13)),
                    ),
                  ),
                  child: Text(
                    cancelText,
                    style: TextStyle(fontWeight: FontWeight.bold, color: confirmColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
