import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:portfolio/app/modules/skills/controllers/skill_controller.dart';
import 'package:portfolio/shared/theme/app_colors.dart';

class SkillView extends GetResponsiveView<SkillController> {
  SkillView({super.key});

  @override
  final controller = Get.put(SkillController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: controller.skill.name,
              child: SvgPicture.asset(
                controller.skill.iconPath,
                width: 75,
                height: 75,
                colorFilter: ColorFilter.mode(
                  AppColors.appAccentColor,
                  BlendMode.color,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              controller.skill.description,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            _buildProficiencyBar(controller.skill.proficiency),
          ],
        ),
      ),
    );
  }

  Widget _buildProficiencyBar(double proficiency) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: proficiency),
        duration: const Duration(seconds: 2),
        builder: (context, double value, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(
                  value: value,
                  strokeWidth: 8,
                  backgroundColor: Colors.grey[300],
                  color: AppColors.appAccentColor,
                ),
              ),
              Text(
                '${(value * 100).toInt()}%', // Display percentage
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
