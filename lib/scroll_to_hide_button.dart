import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScrollToHideButton extends StatefulWidget {
  const ScrollToHideButton({
    Key? key,
    required this.controller,
    required this.child,
    this.duration = const Duration(milliseconds: 200),
  }) : super(key: key);

  final Widget child;
  final ScrollController controller;
  final Duration duration;

  @override
  _ScrollToHideButtonState createState() => _ScrollToHideButtonState();
}

class _ScrollToHideButtonState extends State<ScrollToHideButton> {
  bool _isVisible = true;
  double opacity = 1;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(listen);
  }

  @override
  void dispose() {
    widget.controller.removeListener(listen);
    super.dispose();
  }

  void listen() {
    final direction = widget.controller.position.userScrollDirection;

    if (direction == ScrollDirection.forward) {
      show();
    } else if (direction == ScrollDirection.reverse) {
      hide();
    }
  }

  void show() {
    if (!_isVisible) {
      setState(() {
        _isVisible = true;
        opacity = 1;
      });
    }
  }

  void hide() {
    if (_isVisible) {
      setState(() {
        _isVisible = false;
        opacity = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) => AnimatedOpacity(
        opacity: opacity,
        duration: widget.duration,
        child: Wrap(
          children: [widget.child],
        ),
      );
}
