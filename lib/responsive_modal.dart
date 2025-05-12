// part of modern_flutter_components;

import 'package:flutter/material.dart';
import 'package:modern_flutter_components/cupertino_close_button.dart';

/// Shows either a modal bottom sheet (on small screens) or a dialog (on larger screens)
class ResponsiveModal {
  ///
  /// Parameters:
  /// - [context]: BuildContext
  /// - [title]: Title of the modal
  /// - [builder]: Builder function that returns the content
  /// - [constraints]: Optional constraints for the modal
  /// - [isScrollable]: Whether the content should be scrollable
  /// - [useRootNavigator]: Use root navigator
  /// - [barrierDismissible]: Whether clicking outside dismisses the modal (dialog mode only)
  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required Widget Function(BuildContext, bool isDialog) builder,
    BoxConstraints? constraints,
    bool isScrollable = true,
    bool useRootNavigator = true,
    bool barrierDismissible = true,
  }) {
    // Use MediaQuery to determine if we should show a dialog or bottom sheet
    final isLargeScreen = MediaQuery.sizeOf(context).width >= 635;
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    final bgColor = Theme.of(context).bottomSheetTheme.backgroundColor;
    final textTheme = Theme.of(context).textTheme;
    final viewHeight = MediaQuery.sizeOf(context).height;

    if (isLargeScreen) {
      // Show as dialog on larger screens
      return showDialog<T>(
        context: context,
        useRootNavigator: useRootNavigator,
        barrierDismissible: barrierDismissible,
        barrierColor: isLightMode ? Colors.black54 : Colors.black87,
        builder: (BuildContext dialogContext) {
          return Dialog(
            backgroundColor: bgColor,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                constraints:
                    constraints ?? BoxConstraints(maxWidth: 560, maxHeight: viewHeight * 0.8),
                child: Scaffold(
                  appBar: AppBar(
                    title: Padding(padding: const EdgeInsets.only(left: 8), child: Text(title)),
                    titleTextStyle: textTheme.displayMedium,
                    automaticallyImplyLeading: false,
                    centerTitle: false,
                    toolbarHeight: 80,
                    actionsPadding: EdgeInsets.only(right: 20),
                    actions: [CupertinoCloseButton()],
                  ),
                  body:
                      isScrollable
                          ? SingleChildScrollView(child: builder(dialogContext, true))
                          : builder(dialogContext, true),
                ),
              ),
            ),
          );
        },
      );
    } else {
      // Show as bottom sheet on smaller screens
      return showModalBottomSheet<T>(
        context: context,
        useRootNavigator: useRootNavigator,
        useSafeArea: true,
        isScrollControlled: true,
        enableDrag: barrierDismissible,
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        constraints:
            constraints ?? BoxConstraints(minHeight: viewHeight * 0.3, maxHeight: viewHeight * 0.8),
        builder: (BuildContext bottomSheetContext) {
          return ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            child: Scaffold(
              appBar: AppBar(
                title: Padding(padding: const EdgeInsets.only(left: 8), child: Text(title)),
                titleTextStyle: textTheme.headlineMedium,
                automaticallyImplyLeading: false,
                centerTitle: false,
                toolbarHeight: 65,
                actionsPadding: EdgeInsets.only(right: 10),
                actions: [CupertinoCloseButton()],
              ),
              body:
                  isScrollable
                      ? SingleChildScrollView(child: builder(bottomSheetContext, true))
                      : builder(bottomSheetContext, true),
            ),
          );
        },
      );
    }
  }
}
