import 'package:flutter/material.dart';

class AnimatedColorIcon extends StatefulWidget {
  final IconData icon;
  final bool selected;
  final Color selectedColor;
  final Function onTap;

  const AnimatedColorIcon({
    super.key,
    required this.selected,
    this.selectedColor = Colors.red,
    required this.icon,
    required this.onTap,
  });

  @override
  State<AnimatedColorIcon> createState() => _AnimatedColorIconState();
}

class _AnimatedColorIconState extends State<AnimatedColorIcon> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });

    animation = ColorTween(
      begin: Colors.grey[400],
      end: widget.selectedColor,
    ).animate(controller);

    Future.microtask(() {
      if (widget.selected) {
        controller.forward();
      } else {
        controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        widget.onTap();
        if (widget.selected) {
          controller.reverse();
          return;
        }
        controller.forward();
      },
      icon: Icon(
        widget.icon,
        color: animation.value,
      ),
    );
  }
}
