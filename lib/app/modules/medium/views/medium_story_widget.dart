import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:portfolio/app/modules/medium/controllers/medium_controller.dart';
import 'package:portfolio/shared/theme/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class MediumStoriesWidget extends StatefulWidget {
  const MediumStoriesWidget({super.key});

  @override
  State<MediumStoriesWidget> createState() => _MediumStoriesWidgetState();
}

class _MediumStoriesWidgetState extends State<MediumStoriesWidget> {
  final ScrollController _scrollController = ScrollController();
  final controller = Get.find<MediumController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.updateCardWidth(Get.width < 600 ? Get.width * 0.6 : 250.0);
      if (_scrollController.hasClients && controller.posts.isNotEmpty) {
        _scrollController.jumpTo(0);
      }
    });

    _scrollController.addListener(() {
      final index = (_scrollController.offset / controller.cardWidth.value)
          .round()
          .clamp(0, controller.posts.length - 1);
      if (index != controller.currentIndex.value) {
        controller.updateCurrentIndex(index);
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
    return Obx(() {
      if (controller.isLoading.value) {
        return const Padding(
          padding: EdgeInsets.all(16.0),
          child: CircularProgressIndicator(color: AppColors.appAccentColor),
        );
      }
      if (controller.posts.isEmpty) {
        return const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'No posts found',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        );
      }

      return Column(
        children: [
          SizedBox(
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              padding: EdgeInsets.symmetric(
                horizontal: (Get.width - controller.cardWidth.value) / 2,
              ),
              itemCount: controller.posts.length,
              itemBuilder: (context, index) {
                final post = controller.posts[index];
                return GestureDetector(
                  onTap: () => _launchUrl(post.link),
                  child: Container(
                    width: controller.cardWidth.value,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.all(8),
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
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Get.width < 600 ? 14 : 16,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _formatDate(post.pubDate),
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: Get.width < 600 ? 12 : 14,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          'Read More',
                          style: TextStyle(
                            color: AppColors.pureWhite,
                            fontSize: Get.width < 600 ? 12 : 14,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          if (controller.posts.length >= 5) _buildIndicators(),
        ],
      );
    });
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'No Date';
    return DateFormat('MMM d, yyyy').format(date);
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      Get.snackbar('Error', 'Could not launch $url');
    }
  }

  Widget _buildIndicators() {
    final posts = Get.find<MediumController>().posts;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(posts.length, (index) {
          return GestureDetector(
            onTap: () {
              final targetOffset = index * controller.cardWidth.value;
              _scrollController.animateTo(
                targetOffset,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
              controller.updateCurrentIndex(index);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              width: controller.currentIndex.value == index ? 12 : 8,
              height: controller.currentIndex.value == index ? 12 : 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: controller.currentIndex.value == index
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
