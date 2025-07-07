// Widget to display a skill chip with animated hover/tap effects
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:portfolio/shared/models/skill_model.dart';
import 'package:portfolio/shared/theme/app_colors.dart';

class SkillChip extends StatefulWidget {
  final Skill skill;
  final VoidCallback onTap;

  const SkillChip({required this.skill, required this.onTap, super.key});

  @override
  State<SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<SkillChip> {
  final RxDouble _scale = 1.0.obs;
  double _avatarSize = 20.0;
  double _fontSize = 16.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Update responsive sizes
    _avatarSize = Get.width < 600 ? 16.0 : 20.0;
    _fontSize = Get.width < 600 ? 14.0 : 16.0;

    // Precache SVG
    // TODO: Implement proper SVG precaching for Flutter 3.8.1+
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: (_) => _scale.value = 1.05,
        onExit: (_) => _scale.value = 1.0,
        child: Obx(
          () => AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform: Matrix4.identity()..scale(_scale.value),
            child: Material(
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.borderColor, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.pureBlack.withValues(alpha: 0.4),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Chip(
                  label: Text(
                    widget.skill.name,
                    style: TextStyle(
                      color: AppColors.primaryText,
                      fontSize: _fontSize,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                  ),
                  backgroundColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  avatar: SvgPicture.asset(
                    widget.skill.iconPath,
                    colorFilter: const ColorFilter.mode(
                      AppColors.primaryText,
                      BlendMode.srcIn,
                    ),
                    width: _avatarSize,
                    height: _avatarSize,
                  ),
                  labelPadding: const EdgeInsets.only(left: 4, right: 8),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  clipBehavior: Clip.antiAlias,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
