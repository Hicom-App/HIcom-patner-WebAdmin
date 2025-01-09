import 'dart:math';
import 'package:flutter/material.dart';

abstract class AnimationControllerState<T extends StatefulWidget> extends State<T> with SingleTickerProviderStateMixin {
  AnimationControllerState(this.animationDuration);
  final Duration animationDuration;
  late final animationController = AnimationController(vsync: this, duration: animationDuration);
  late final CurvedAnimation animation = CurvedAnimation(parent: animationController, curve: Curves.elasticInOut,);

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

class ShakeWidget extends StatefulWidget {
  const ShakeWidget({
    super.key,
    required this.child,
    required this.shakeOffset,
    this.shakeCount = 3,
    this.shakeDuration = const Duration(milliseconds: 400),
    this.shakeDirection = Axis.horizontal, // New parameter for shake direction
  });

  final Widget child;
  final double shakeOffset;
  final int shakeCount;
  final Duration shakeDuration;
  final Axis shakeDirection; // Direction of the shake

  @override
  ShakeWidgetState createState() => ShakeWidgetState(shakeDuration);
}

class ShakeWidgetState extends AnimationControllerState<ShakeWidget> {
  ShakeWidgetState(super.duration);

  @override
  void initState() {
    super.initState();
    animationController.addStatusListener(_updateStatus);
  }

  @override
  void dispose() {
    animationController.removeStatusListener(_updateStatus);
    super.dispose();
  }

  void _updateStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      animationController.reset();
    }
  }

  void shake() {
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation, // Use the curved animation for smoother effect
      child: widget.child,
      builder: (context, child) {
        final sineValue =
        sin(widget.shakeCount * pi * 2 * animation.value);
        //double offset = sin(_shakeAnimation.value * pi * 2);

        // Shake logic based on direction
        final offset = widget.shakeDirection == Axis.horizontal
            ? Offset(sineValue * widget.shakeOffset, 0)
            : (widget.shakeDirection == Axis.vertical
            ? Offset(0, sineValue * widget.shakeOffset)
            : Offset(sineValue * widget.shakeOffset,
            sineValue * widget.shakeOffset)); // Both directions

        return Transform.translate(
          offset: offset,
          child: child,
        );
      },
    );
  }
}
