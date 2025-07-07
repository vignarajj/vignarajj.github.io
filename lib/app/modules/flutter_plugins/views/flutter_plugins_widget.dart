import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/app/modules/flutter_plugins/controllers/flutter_plugins_controller.dart';
import 'package:portfolio/shared/theme/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class FlutterPluginsWidget extends StatefulWidget {
  const FlutterPluginsWidget({super.key});

  @override
  State<FlutterPluginsWidget> createState() => _FlutterPluginsWidgetState();
}

class _FlutterPluginsWidgetState extends State<FlutterPluginsWidget> {
  final ScrollController _scrollController = ScrollController();
  final controller = Get.find<FlutterPluginsController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.updateCardWidth(Get.width < 600 ? Get.width * 0.6 : 250.0);
      if (_scrollController.hasClients && controller.plugins.isNotEmpty) {
        _scrollController.jumpTo(0);
      }
    });

    _scrollController.addListener(() {
      final index = (_scrollController.offset / controller.cardWidth.value)
          .round()
          .clamp(0, controller.plugins.length - 1);
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
    final controller = Get.find<FlutterPluginsController>();

    return Obx(() {
      if (controller.isLoading.value) {
        return const Padding(
          padding: EdgeInsets.all(16.0),
          child: CircularProgressIndicator(color: AppColors.appAccentColor),
        );
      }
      if (controller.plugins.isEmpty) {
        return const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'No plugins found',
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
              itemCount: controller.plugins.length,
              itemBuilder: (context, index) {
                final plugin = controller.plugins[index];
                return GestureDetector(
                  onTap: () => _launchUrl(plugin.pubDevUrl),
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
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                plugin.name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Get.width < 600 ? 14 : 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: Text(
                            plugin.description,
                            style: TextStyle(
                              color: Colors.grey[300],
                              fontSize: Get.width < 600 ? 12 : 13,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'View on pub.dev',
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
          if (controller.plugins.length > 1) _buildIndicators(),
        ],
      );
    });
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
    final plugins = Get.find<FlutterPluginsController>().plugins;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(plugins.length, (index) {
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
