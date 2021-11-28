import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScrollToHide extends StatefulWidget {
  const ScrollToHide({
    Key? key,
    required this.controller,
    required this.child,
    this.duration = const Duration(milliseconds: 200),
  }) : super(key: key);

  final Widget child;
  final ScrollController controller;
  final Duration duration;

  @override
  _ScrollToHideState createState() => _ScrollToHideState();
}

class _ScrollToHideState extends State<ScrollToHide> {
  bool _isVisible = true;

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
      });
    }
  }

  void hide() {
    if (_isVisible) {
      setState(() {
        _isVisible = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) => AnimatedContainer(
        duration: widget.duration,
        height: _isVisible ? 70 : 0,
        child: Wrap(
          children: [widget.child],
        ),
      );
}
