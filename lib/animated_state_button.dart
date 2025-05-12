import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:modern_flutter_components/modern_flutter_components_extension.dart';

enum ButtonState { idle, loading, success, error }

enum ButtonType { elevated, filled, light, outlined }

class AnimatedStateButton extends StatefulWidget {
  const AnimatedStateButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.onSuccess,
    this.onError,
    this.resetDelay = const Duration(seconds: 2),
    this.successIcon = Icons.check_rounded,
    this.errorIcon = Icons.close_rounded,
    this.iconData,
    this.buttonType = ButtonType.elevated,
    required this.appThemeColor,
  });

  final String text;
  final Future<ButtonState> Function() onPressed;
  final VoidCallback? onSuccess;
  final VoidCallback? onError;
  final Duration resetDelay;
  final IconData successIcon;
  final IconData errorIcon;
  final IconData? iconData;
  final ButtonType buttonType;
  final Color appThemeColor;

  @override
  State<AnimatedStateButton> createState() => _AnimatedStateButtonState();
}

class _AnimatedStateButtonState extends State<AnimatedStateButton>
    with SingleTickerProviderStateMixin {
  ButtonState _state = ButtonState.idle;
  late final AnimationController _scaleAnimationController;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _scaleAnimationController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _scaleAnimationController.dispose();
    super.dispose();
  }

  void _handlePress() async {
    if (_state == ButtonState.loading) return;

    setState(() => _state = ButtonState.loading);

    final result = await widget.onPressed();
    setState(() => _state = result);

    // Execute appropriate callback based on state
    if (result == ButtonState.success && widget.onSuccess != null) {
      widget.onSuccess!();
    } else if (result == ButtonState.error && widget.onError != null) {
      widget.onError!();
    }

    // Reset to idle state after delay
    await Future.delayed(widget.resetDelay);
    if (mounted) {
      setState(() => _state = ButtonState.idle);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(scale: _scaleAnimation.value, child: child);
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTapDown: (_) {
            if (_state != ButtonState.loading) {
              _scaleAnimationController.forward();
            }
          },
          onTapUp: (_) {
            _scaleAnimationController.reverse();
          },
          onTapCancel: () {
            _scaleAnimationController.reverse();
          },
          onTap: _state == ButtonState.loading ? null : _handlePress,
          child: Container(
            height: context.isMobile ? 49 : 52,
            decoration: BoxDecoration(
              color: _getColorForState(_state),
              borderRadius: BorderRadius.circular(40),
              border:
                  widget.buttonType == ButtonType.outlined
                      ? Border.all(color: context.borderColorIntense)
                      : null,
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder:
                  (child, animation) => ScaleTransition(scale: animation, child: child),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: context.adaptiveSize(0),
                children: [
                  if (widget.iconData != null && _state == ButtonState.idle) ...[
                    widget.iconData is HugeIcon
                        ? HugeIcon(
                          icon: widget.iconData!,
                          color: _getForegroundColor(widget.buttonType),
                          size: context.defaultIconSize,
                        )
                        : Icon(
                          widget.iconData,
                          color: _getForegroundColor(widget.buttonType),
                          size: context.defaultIconSize,
                        ),
                  ],
                  _buildChildForState(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChildForState() {
    switch (_state) {
      case ButtonState.idle:
        return Padding(
          key: const ValueKey('idle'),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            widget.text,
            style: TextStyle(
              color: _getForegroundColor(widget.buttonType),
              fontSize: context.isMobile ? 16 : 19,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      case ButtonState.loading:
        return Padding(
          key: const ValueKey('loading'),
          padding: const EdgeInsets.all(12),
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator.adaptive(
              strokeWidth: 2,
              backgroundColor: _getForegroundColor(widget.buttonType),
            ),
          ),
        );
      case ButtonState.success:
        return Padding(
          key: const ValueKey('success'),
          padding: const EdgeInsets.all(12),
          child: HugeIcon(
            icon: HugeIcons.strokeRoundedTick03,
            color: _getForegroundColor(widget.buttonType),
          ),
        );
      case ButtonState.error:
        return Padding(
          key: const ValueKey('error'),
          padding: const EdgeInsets.all(12),
          child: HugeIcon(
            icon: HugeIcons.strokeRoundedCancel02,
            color: _getForegroundColor(widget.buttonType),
          ),
        );
    }
  }

  Color _getForegroundColor(ButtonType type) {
    if (type == ButtonType.outlined) {
      return widget.appThemeColor;
    }
    if (type == ButtonType.light) {
      return context.primary;
    }
    if (type == ButtonType.filled) {
      return Colors.white;
    }
    if (type == ButtonType.elevated) {
      return context.primaryInverse;
    }
    return context.primary;
  }

  Color _getColorForState(ButtonState state) {
    if (widget.buttonType == ButtonType.outlined) {
      return context.scaffoldBackgroundColor;
    }
    if (widget.buttonType == ButtonType.light) {
      return context.borderColor;
    }

    if (widget.buttonType == ButtonType.filled) {
      return widget.appThemeColor;
    }

    if (widget.buttonType == ButtonType.elevated) {
      return context.primary;
    }

    return context.scaffoldBackgroundColor;
    // switch (state) {
    //   case ButtonState.loading:
    //     return Colors.blueGrey;
    //   case ButtonState.success:
    //     return Colors.green;
    //   case ButtonState.error:
    //     return Colors.red;
    //   case ButtonState.idle:
    //     return kAppBlue;
    // }
  }
}
