import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

extension ModernFlutterComponentsExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  bool get isDarkMode => theme.brightness == Brightness.dark;
  bool get isLightMode => theme.brightness == Brightness.light;

  double get viewWidth => MediaQuery.sizeOf(this).width;
  double get viewHeight => MediaQuery.sizeOf(this).height;

  bool get isPortrait => MediaQuery.orientationOf(this) == Orientation.portrait;

  bool get isMobile => viewWidth < 635;

  Color get primary => isLightMode ? Colors.black : Colors.white;
  Color get primaryInverse => isLightMode ? Colors.white : Colors.black;

  Color get secondary => isLightMode ? Colors.grey : Colors.grey.shade900;

  Color get hint => isDarkMode ? Colors.grey.shade600 : Colors.grey;
  Color get hintIntense => isDarkMode ? Colors.grey.shade500 : Colors.grey.shade600;

  Color get cardColor => isLightMode ? Colors.white : const Color.fromARGB(255, 20, 20, 20);
  Color get borderColor => isLightMode ? Colors.grey.shade200 : Colors.grey.shade900;
  Color get borderColorIntense =>
      isLightMode
          ? Colors.grey.shade300.withValues(alpha: 0.75)
          : Colors.grey.shade800.withValues(alpha: 0.75);

  Color get scaffoldBackgroundColor => Theme.of(this).scaffoldBackgroundColor;

  BottomSheetThemeData get bottomSheetTheme => Theme.of(this).bottomSheetTheme;

  Color get iconButtonBackgroundColor => isLightMode ? Colors.grey.shade200 : Colors.grey.shade900;

  Color get shadowColor =>
      isLightMode
          ? Theme.of(this).primaryColor.withValues(alpha: 0.2)
          : Theme.of(this).primaryColor.withValues(alpha: 0.4);

  Color get shimmerBaseColor =>
      isDarkMode ? const Color.fromARGB(255, 20, 20, 20) : const Color.fromARGB(255, 240, 240, 240);
  Color get shimmerHighlightColor =>
      isDarkMode ? const Color.fromARGB(255, 26, 26, 26) : const Color.fromARGB(255, 220, 220, 220);
  Color get shimmerBackgroundColor =>
      isDarkMode ? const Color.fromARGB(255, 25, 25, 25) : Colors.white;

  double get defaultPadding =>
      kIsWeb
          ? 32.0
          : !isMobile
          ? 24.0
          : 16.0;

  double get largeScreenCenterPadding =>
      kIsWeb
          ? (viewWidth * 0.3)
          : !isMobile
          ? (isPortrait ? viewWidth * 0.15 : viewWidth * 0.25)
          : 16.0;

  double get defaultIconSize =>
      kIsWeb
          ? 34.0
          : !isMobile
          ? 26.0
          : 24.0;

  double gap(double size) =>
      kIsWeb
          ? size * 1.75
          : !isMobile
          ? size * 1.5
          : size;

  double adaptiveSize(double value) =>
      kIsWeb
          ? value * 1.5
          : !isMobile
          ? value * 1.25
          : value;

  int get gridViewCrossAxisCount =>
      kIsWeb
          ? 3
          : isMobile
          ? 1
          : 2;
}
