import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/shared/theme/app_colors.dart';
import 'package:portfolio/shared/theme/text_styles.dart';

class EnhancedAnimatedText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Duration delay;
  final TextAlign textAlign;
  final AnimationType animationType;

  const EnhancedAnimatedText({
    super.key,
    required this.text,
    this.style,
    this.delay = Duration.zero,
    this.textAlign = TextAlign.center,
    this.animationType = AnimationType.fadeSlide,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text, style: style, textAlign: textAlign)
        .animate(delay: delay)
        .then(delay: const Duration(milliseconds: 200))
        .fadeIn(duration: 800.ms, curve: Curves.easeOutCubic)
        .slideY(
          begin: 0.3,
          end: 0,
          duration: 800.ms,
          curve: Curves.easeOutCubic,
        );
  }

  List<Effect> _getEffects() {
    switch (animationType) {
      case AnimationType.fadeSlide:
        return [
          FadeEffect(duration: 800.ms, curve: Curves.easeOutCubic),
          SlideEffect(
            begin: const Offset(0, 0.3),
            end: Offset.zero,
            duration: 800.ms,
            curve: Curves.easeOutCubic,
          ),
        ];

      case AnimationType.typewriter:
        return [
          FadeEffect(
            duration: Duration(milliseconds: text.length * 50),
            curve: Curves.easeInOut,
          ),
        ];

      case AnimationType.shimmer:
        return [
          FadeEffect(duration: 600.ms),
          ShimmerEffect(
            duration: 1500.ms,
            colors: [
              AppColors.primaryText,
              AppColors.lightAccent,
              AppColors.pureWhite,
              AppColors.lightAccent,
              AppColors.primaryText,
            ],
          ),
        ];

      case AnimationType.glow:
        return [
          FadeEffect(duration: 600.ms),
          const TintEffect(color: AppColors.pureWhite),
        ];

      case AnimationType.bounce:
        return [
          ScaleEffect(
            begin: const Offset(0.5, 0.5),
            end: const Offset(1.0, 1.0),
            duration: 600.ms,
            curve: Curves.elasticOut,
          ),
          FadeEffect(duration: 400.ms),
        ];

      case AnimationType.slide:
        return [
          SlideEffect(
            begin: const Offset(-1, 0),
            end: Offset.zero,
            duration: 800.ms,
            curve: Curves.easeOutCubic,
          ),
          FadeEffect(duration: 600.ms),
        ];
    }
  }
}

enum AnimationType { fadeSlide, typewriter, shimmer, glow, bounce, slide }

class AnimatedHeroTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Duration delay;

  const AnimatedHeroTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.delay = Duration.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EnhancedAnimatedText(
          text: title,
          style: TextStyles.heroTitle,
          delay: delay,
          animationType: AnimationType.shimmer,
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 16),
          EnhancedAnimatedText(
            text: subtitle!,
            style: TextStyles.heroSubtitle,
            delay: delay + const Duration(milliseconds: 400),
            animationType: AnimationType.typewriter,
          ),
        ],
      ],
    );
  }
}

class AnimatedSectionTitle extends StatelessWidget {
  final String title;
  final Duration delay;

  const AnimatedSectionTitle({
    super.key,
    required this.title,
    this.delay = Duration.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        children: [
          EnhancedAnimatedText(
            text: title,
            style: TextStyles.sectionTitle,
            delay: delay,
            animationType: AnimationType.slide,
          ),
          const SizedBox(height: 12),
          Container(
                height: 2,
                width: 80,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.pureWhite,
                      AppColors.lightAccent,
                      AppColors.pureWhite,
                    ],
                  ),
                ),
              )
              .animate(delay: delay + const Duration(milliseconds: 300))
              .scaleX(begin: 0, duration: 600.ms, curve: Curves.easeOutCubic),
        ],
      ),
    );
  }
}

class AnimatedCard extends StatelessWidget {
  final Widget child;
  final Duration delay;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const AnimatedCard({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.width,
    this.height,
    this.margin,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
          width: width,
          height: height,
          margin: margin ?? const EdgeInsets.all(8),
          padding: padding ?? const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.borderColor, width: 0.5),
            boxShadow: [
              BoxShadow(
                color: AppColors.pureBlack.withValues(alpha: 0.5),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: child,
        )
        .animate(delay: delay)
        .slideY(begin: 0.3, duration: 800.ms, curve: Curves.easeOutCubic)
        .fadeIn(duration: 600.ms);
  }
}

class AnimatedChip extends StatelessWidget {
  final String text;
  final Duration delay;
  final VoidCallback? onTap;
  final bool isSelected;

  const AnimatedChip({
    super.key,
    required this.text,
    this.delay = Duration.zero,
    this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.pureWhite : AppColors.cardBackground,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? AppColors.pureWhite : AppColors.borderColor,
              width: 1,
            ),
          ),
          child: Text(
            text,
            style: TextStyles.chipText.copyWith(
              color: isSelected ? AppColors.pureBlack : AppColors.primaryText,
            ),
          ),
        )
        .animate(delay: delay)
        .scale(
          begin: const Offset(0.8, 0.8),
          duration: 400.ms,
          curve: Curves.elasticOut,
        )
        .fadeIn(duration: 300.ms);
  }
}

class StaggeredAnimationBuilder extends StatelessWidget {
  final List<Widget> children;
  final Duration initialDelay;
  final Duration staggerDelay;
  final Axis direction;

  const StaggeredAnimationBuilder({
    super.key,
    required this.children,
    this.initialDelay = Duration.zero,
    this.staggerDelay = const Duration(milliseconds: 100),
    this.direction = Axis.vertical,
  });

  @override
  Widget build(BuildContext context) {
    return direction == Axis.vertical
        ? Column(children: _buildAnimatedChildren())
        : Row(children: _buildAnimatedChildren());
  }

  List<Widget> _buildAnimatedChildren() {
    return children.asMap().entries.map((entry) {
      final index = entry.key;
      final child = entry.value;

      return child
          .animate(delay: initialDelay + (staggerDelay * index))
          .slideY(
            begin: direction == Axis.vertical ? 0.3 : 0,
            duration: 600.ms,
            curve: Curves.easeOutCubic,
          )
          .slideX(
            begin: direction == Axis.horizontal ? 0.3 : 0,
            duration: 600.ms,
            curve: Curves.easeOutCubic,
          )
          .fadeIn(duration: 400.ms);
    }).toList();
  }
}
