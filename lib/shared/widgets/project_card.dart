// In project_card.dart
// Widget to display a project card in a marquee
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/app_colors.dart';

class ProjectCard extends StatefulWidget {
  final Project project;

  const ProjectCard({required this.project, super.key});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  final RxDouble _scale = 1.0.obs;

  @override
  Widget build(BuildContext context) {
    final isMobile = Get.width < 600;
    final cardWidth = isMobile ? Get.width * 0.7 : 300.0;

    return GestureDetector(
      onTap: () => _launchUrl(widget.project.url),
      child: MouseRegion(
        onEnter: (_) => _scale.value = 1.05,
        onExit: (_) => _scale.value = 1.0,
        child: Obx(
          () => AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform: Matrix4.identity()..scale(_scale.value),
            width: cardWidth,
            margin: EdgeInsets.symmetric(
              horizontal: isMobile ? 6 : 8,
              vertical: isMobile ? 6 : 8,
            ),
            padding: EdgeInsets.all(isMobile ? 10 : 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.grey[850]!.withAlpha(90),
                  Colors.grey[900]!.withAlpha(90),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(30),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  child: Text(
                    widget.project.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isMobile ? 13 : 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: isMobile ? 4 : 6),
                Flexible(
                  flex: 2,
                  child: Text(
                    widget.project.description,
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: isMobile ? 9 : 12,
                      height: 1.3,
                    ),
                    maxLines: isMobile ? 3 : 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: isMobile ? 4 : 6),
                Text(
                  'Visit',
                  style: TextStyle(
                    color: AppColors.pureWhite,
                    fontSize: isMobile ? 11 : 14,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      Get.snackbar(
        'Error',
        'Could not launch $url',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
      );
    }
  }
}

class Project {
  final String title;
  final String description;
  final String url;

  Project({required this.title, required this.description, required this.url});
}
