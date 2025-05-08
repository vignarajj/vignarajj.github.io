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
  _SkillChipState createState() => _SkillChipState();
}

class _SkillChipState extends State<SkillChip> {
  double _scale = 1.0;
  double _avatarSize = 20.0;
  double _fontSize = 16.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Update responsive sizes
    _avatarSize = Get.width < 600 ? 16.0 : 20.0;
    _fontSize = Get.width < 600 ? 14.0 : 16.0;

    // Precache SVG
    precachePicture(
      SvgPicture.asset(widget.skill.iconPath).pictureProvider,
      context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: (_) => setState(() => _scale = 1.05),
        onExit: (_) => setState(() => _scale = 1.0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.identity()..scale(_scale),
          child: Material(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.appAccentColor,
                    AppColors.appAccentColor.withAlpha(80)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(30),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Chip(
                label: Text(
                  widget.skill.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: _fontSize,
                  ),
                ),
                backgroundColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                avatar: SvgPicture.asset(
                  widget.skill.iconPath,
                  color: Colors.white,
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
    );
  }
}
