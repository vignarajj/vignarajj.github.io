import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:portfolio/app/controllers/medium_controller.dart';
import 'package:portfolio/shared/theme/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class MediumStoriesWidget extends StatefulWidget {
  const MediumStoriesWidget({super.key});

  @override
  _MediumStoriesWidgetState createState() => _MediumStoriesWidgetState();
}

class _MediumStoriesWidgetState extends State<MediumStoriesWidget> {
  final ScrollController _scrollController = ScrollController();
  int _currentIndex = 0;
  double _cardWidth = 250.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _cardWidth = Get.width < 600 ? Get.width * 0.6 : 250.0;
      });

      final totalPadding = (Get.width - _cardWidth) / 2;
      if (_scrollController.hasClients && Get.find<MediumController>().posts.isNotEmpty) {
        _scrollController.jumpTo(0);
      }
    });

    _scrollController.addListener(() {
      final index = (_scrollController.offset / _cardWidth).round().clamp(0, Get.find<MediumController>().posts.length - 1);
      if (index != _currentIndex) {
        setState(() {
          _currentIndex = index;
        });
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
    final controller = Get.find<MediumController>();

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

      final horizontalPadding = (Get.width - _cardWidth) / 2;

      return Column(
        children: [
          SizedBox(
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              padding: EdgeInsets.symmetric(
                horizontal: (Get.width - _cardWidth) / 2,
              ),
              itemCount: controller.posts.length,
              itemBuilder: (context, index) {
                final post = controller.posts[index];
                return GestureDetector(
                  onTap: () => _launchUrl(post.link),
                  child: Container(
                    width: _cardWidth,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(8),
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
                            color: AppColors.appAccentColor,
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
              final targetOffset = index * _cardWidth;
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
                color: _currentIndex == index ? AppColors.appAccentColor : Colors.grey[600],
              ),
            ),
          );
        }),
      ),
    );
  }
}
