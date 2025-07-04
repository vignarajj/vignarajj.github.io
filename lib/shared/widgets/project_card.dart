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
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    final cardWidth = Get.width < 600 ? Get.width * 0.6 : 300.0;

    return GestureDetector(
      onTap: () => _launchUrl(widget.project.url),
      child: MouseRegion(
        onEnter: (_) => setState(() => _scale = 1.05),
        onExit: (_) => setState(() => _scale = 1.0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.identity()..scale(_scale),
          width: cardWidth,
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.grey[850]!.withAlpha(90), Colors.grey[900]!.withAlpha(90)],
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
                child: Text(
                  widget.project.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Get.width < 600 ? 14 : 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 2),
              Flexible(
                child: Text(
                  widget.project.description,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: Get.width < 600 ? 10 : 12,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 2),
              Flexible(
                child: Text(
                  'Visit',
                  style: TextStyle(
                    color: AppColors.appAccentColor,
                    fontSize: Get.width < 600 ? 12 : 14,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
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
