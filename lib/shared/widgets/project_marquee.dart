import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/shared/theme/app_colors.dart';
import 'package:portfolio/shared/widgets/project_card.dart';

class ProjectMarquee extends StatefulWidget {
  final List<Project> projects;
  final double cardWidth;

  const ProjectMarquee({
    required this.projects,
    required this.cardWidth,
    super.key,
  });

  @override
  _ProjectMarqueeState createState() => _ProjectMarqueeState();
}

class _ProjectMarqueeState extends State<ProjectMarquee> {
  final ScrollController _scrollController = ScrollController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      final index = (_scrollController.offset / widget.cardWidth)
          .round()
          .clamp(0, widget.projects.length - 1);
      if (index != _currentIndex) {
        setState(() {
          _currentIndex = index;
        });
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients &&
          widget.projects.isNotEmpty &&
          widget.cardWidth > 0) {
        // Just jump to 0; padding handles centering
        _scrollController.jumpTo(0);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.projects.isEmpty || widget.cardWidth <= 0) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'No projects available',
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
      );
    }

    final horizontalPadding = (Get.width - widget.cardWidth) / 2;

    return Column(
      children: [
        SizedBox(
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            controller: _scrollController,
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            itemCount: widget.projects.length,
            itemBuilder: (context, index) {
              final project = widget.projects[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                width: widget.cardWidth,
                child: ProjectCard(project: project),
              );
            },
          ),
        ),
        if (widget.projects.length >= 5) _buildIndicators(),
      ],
    );
  }

  Widget _buildIndicators() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(widget.projects.length, (index) {
          return GestureDetector(
            onTap: () {
              final targetOffset = index * widget.cardWidth;
              _scrollController.animateTo(
                targetOffset,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
              setState(() {
                _currentIndex = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              width: _currentIndex == index ? 12 : 8,
              height: _currentIndex == index ? 12 : 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == index
                    ? AppColors.appAccentColor
                    : Colors.grey[600],
              ),
            ),
          );
        }),
      ),
    );
  }
}
