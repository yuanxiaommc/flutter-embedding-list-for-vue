import 'package:flutter/material.dart';

/// 缩放动画按钮
class ScaleAnimateButton extends StatefulWidget {
  final Widget child;
  final Function() onTap;
  final Function()? onLongPress;
  final HitTestBehavior? behavior;

  /// 动画时长
  final Duration? scaleDuration;

  /// 缩放比例(0 ~ 1), 值越大缩放越多
  final double scale;

  const ScaleAnimateButton({
    Key? key,
    required this.child,
    required this.onTap,
    this.scaleDuration = const Duration(milliseconds: 150),
    this.behavior,
    this.scale = 0.1,
    this.onLongPress,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ScaleAnimateButtonState();
  }
}

class _ScaleAnimateButtonState extends State<ScaleAnimateButton>
    with SingleTickerProviderStateMixin {
  late double _scale;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.scaleDuration,
      lowerBound: 0.0,
      upperBound: widget.scale,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;

    return GestureDetector(
      behavior: widget.behavior,
      onTapDown: (TapDownDetails details) {
        _controller.forward();
      },
      onTapUp: (TapUpDetails details) {
        _controller.reverse();
      },
      onTapCancel: () {
        _controller.reverse();
      },
      onTap: () {
        widget.onTap();
      },
      onLongPress: () {
        if (widget.onLongPress != null) {
          widget.onLongPress!();
        }
      },
      child: Transform.scale(
        scale: _scale,
        child: widget.child,
      ),
    );
  }
}
