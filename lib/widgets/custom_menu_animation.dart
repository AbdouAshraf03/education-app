import 'package:flutter/material.dart';

import 'package:iconsax_flutter/iconsax_flutter.dart';

class AnimatedMenuButton extends StatefulWidget {
  const AnimatedMenuButton({super.key});

  @override
  State<AnimatedMenuButton> createState() => _AnimatedMenuButtonState();
}

class _AnimatedMenuButtonState extends State<AnimatedMenuButton>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 0.0, end: 0.5).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleAnimation() {
    if (_controller.isCompleted) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        //drawer
        Scaffold.of(context).openEndDrawer();

        _toggleAnimation();
        // Add your onPressed logic here
      },
      icon: RotationTransition(
        turns: _animation,
        child: const Icon(Iconsax.menu_1_copy),
      ),
    );
  }
}
