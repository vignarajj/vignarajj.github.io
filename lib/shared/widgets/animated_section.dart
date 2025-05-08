// Widget to animate sections with slide, fade, and scale transitions
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnimatedSection extends StatefulWidget {
  final Widget child;
  final int delay;

  const AnimatedSection({required this.child, this.delay = 0, super.key});

  @override
  _AnimatedSectionState createState() => _AnimatedSectionState();
}

class _AnimatedSectionState extends State<AnimatedSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    // Initialize animations (updated in didChangeDependencies)
    _updateAnimations();

    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Update animations when inherited widgets change
    _updateAnimations();
  }

  void _updateAnimations() {
    final curve = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    // Safely access Get.width
    _offsetAnimation = Tween<Offset>(
      begin: Offset(0, Get.width < 600 ? 0.2 : 0.3),
      end: Offset.zero,
    ).animate(curve);

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(curve);

    _scaleAnimation = Tween<double>(
      begin: 0.9,
      end: 1.0,
    ).animate(curve);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: FadeTransition(
            opacity: _opacityAnimation,
            child: SlideTransition(
              position: _offsetAnimation,
              child: child,
            ),
          ),
        );
      },
      child: widget.child,
    );
  }
}