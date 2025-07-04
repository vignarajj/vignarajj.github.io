import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/shared/theme/app_colors.dart';

class EnhancedPageTransitions {
  static Route<T> slideTransition<T extends Object?>(
    Widget page, {
    SlideDirection direction = SlideDirection.left,
    Duration duration = const Duration(milliseconds: 400),
  }) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final begin = _getSlideOffset(direction);
        const end = Offset.zero;
        const curve = Curves.easeInOutCubic;

        final tween = Tween(begin: begin, end: end);
        final offsetAnimation = animation.drive(tween.chain(CurveTween(curve: curve)));

        return SlideTransition(
          position: offsetAnimation,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    );
  }

  static Route<T> fadeTransition<T extends Object?>(
    Widget page, {
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  static Route<T> scaleTransition<T extends Object?>(
    Widget page, {
    Duration duration = const Duration(milliseconds: 400),
  }) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const curve = Curves.easeInOutCubic;
        final tween = Tween(begin: 0.8, end: 1.0);
        final scaleAnimation = animation.drive(tween.chain(CurveTween(curve: curve)));

        return ScaleTransition(
          scale: scaleAnimation,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    );
  }

  static Route<T> morphTransition<T extends Object?>(
    Widget page, {
    Duration duration = const Duration(milliseconds: 600),
  }) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const curve = Curves.easeInOutQuart;
        
        final slideAnimation = Tween<Offset>(
          begin: const Offset(0, 0.1),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: animation, curve: curve));

        final scaleAnimation = Tween<double>(
          begin: 0.9,
          end: 1.0,
        ).animate(CurvedAnimation(parent: animation, curve: curve));

        return SlideTransition(
          position: slideAnimation,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          ),
        );
      },
    );
  }

  static Offset _getSlideOffset(SlideDirection direction) {
    switch (direction) {
      case SlideDirection.left:
        return const Offset(-1.0, 0.0);
      case SlideDirection.right:
        return const Offset(1.0, 0.0);
      case SlideDirection.up:
        return const Offset(0.0, -1.0);
      case SlideDirection.down:
        return const Offset(0.0, 1.0);
    }
  }
}

enum SlideDirection {
  left,
  right,
  up,
  down,
}

class AnimatedNavigationButton extends StatefulWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Duration animationDelay;

  const AnimatedNavigationButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.animationDelay = Duration.zero,
  });

  @override
  State<AnimatedNavigationButton> createState() => _AnimatedNavigationButtonState();
}

class _AnimatedNavigationButtonState extends State<AnimatedNavigationButton>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _isHovered
                ? [AppColors.pureWhite, AppColors.lightAccent]
                : [AppColors.cardBackground, AppColors.surfaceColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isHovered ? AppColors.pureWhite : AppColors.borderColor,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.pureBlack.withValues(alpha: 0.3),
              blurRadius: _isHovered ? 12 : 4,
              offset: Offset(0, _isHovered ? 6 : 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onPressed,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    widget.icon,
                    color: _isHovered ? AppColors.pureBlack : AppColors.primaryText,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.text,
                    style: TextStyle(
                      color: _isHovered ? AppColors.pureBlack : AppColors.primaryText,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ).animate(delay: widget.animationDelay).fadeIn(duration: 400.ms).slideX(
        begin: -0.2,
        duration: 600.ms,
        curve: Curves.easeOutCubic,
      ),
    );
  }
}

class FloatingActionButtonAnimated extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Duration delay;

  const FloatingActionButtonAnimated({
    super.key,
    required this.onPressed,
    required this.child,
    this.delay = Duration.zero,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: AppColors.pureWhite,
      foregroundColor: AppColors.pureBlack,
      elevation: 8,
      child: child,
    ).animate(delay: delay).scale(
      begin: const Offset(0.5, 0.5),
      duration: 800.ms,
      curve: Curves.elasticOut,
    ).fadeIn(duration: 400.ms);
  }
}

class EnhancedBottomSheet extends StatelessWidget {
  final Widget child;
  final double? height;
  final bool isFullScreen;

  const EnhancedBottomSheet({
    super.key,
    required this.child,
    this.height,
    this.isFullScreen = false,
  });

  static Future<T?> show<T>(
    BuildContext context, {
    required Widget child,
    double? height,
    bool isFullScreen = false,
    bool isDismissible = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      isDismissible: isDismissible,
      backgroundColor: Colors.transparent,
      builder: (context) => EnhancedBottomSheet(
        height: height,
        isFullScreen: isFullScreen,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final sheetHeight = isFullScreen 
        ? screenHeight * 0.9 
        : height ?? screenHeight * 0.6;

    return Container(
      height: sheetHeight,
      decoration: const BoxDecoration(
        color: AppColors.primaryBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        border: Border(
          top: BorderSide(color: AppColors.borderColor, width: 1),
          left: BorderSide(color: AppColors.borderColor, width: 1),
          right: BorderSide(color: AppColors.borderColor, width: 1),
        ),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.borderColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Expanded(child: child),
        ],
      ),
    ).animate().slideY(
      begin: 1.0,
      duration: 400.ms,
      curve: Curves.easeOutCubic,
    );
  }
}

class LoadingAnimation extends StatelessWidget {
  final String? text;
  final Duration delay;

  const LoadingAnimation({
    super.key,
    this.text,
    this.delay = Duration.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: const BoxDecoration(
            color: AppColors.cardBackground,
            shape: BoxShape.circle,
            border: Border.fromBorderSide(
              BorderSide(color: AppColors.borderColor, width: 2),
            ),
          ),
          child: const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.pureWhite),
            strokeWidth: 3,
          ),
        ).animate(onPlay: (controller) => controller.repeat()).rotate(
          duration: 1500.ms,
        ),
        if (text != null) ...[
          const SizedBox(height: 16),
          Text(
            text!,
            style: const TextStyle(
              color: AppColors.secondaryText,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ).animate(delay: 200.ms).fadeIn().slideY(
            begin: 0.2,
            duration: 400.ms,
          ),
        ],
      ],
    ).animate(delay: delay).fadeIn(duration: 300.ms);
  }
}

class SuccessAnimation extends StatelessWidget {
  final String? text;
  final Duration delay;

  const SuccessAnimation({
    super.key,
    this.text,
    this.delay = Duration.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: const BoxDecoration(
            color: AppColors.pureWhite,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check,
            color: AppColors.pureBlack,
            size: 32,
          ),
        ).animate(delay: delay).scale(
          begin: const Offset(0.5, 0.5),
          duration: 600.ms,
          curve: Curves.elasticOut,
        ),
        if (text != null) ...[
          const SizedBox(height: 16),
          Text(
            text!,
            style: const TextStyle(
              color: AppColors.primaryText,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ).animate(delay: delay + 300.ms).fadeIn().slideY(
            begin: 0.2,
            duration: 400.ms,
          ),
        ],
      ],
    );
  }
} 