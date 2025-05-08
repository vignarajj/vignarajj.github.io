import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/app/modules/comp-detailview/core_competency_controller.dart';
import 'package:portfolio/shared/models/core_compentency.dart';
import 'package:portfolio/shared/theme/app_colors.dart';

class CoreCompetencyDetailView
    extends GetResponsiveView<CoreCompetencyController> {
  final CoreCompetency competency;

  CoreCompetencyDetailView({required this.competency, super.key});

  @override
  final controller = Get.put(CoreCompetencyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              competency.title,
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.appAccentColor),
            ),
            const SizedBox(height: 20),
            Text(
              competency.description,
              style: const TextStyle(fontSize: 18,),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
