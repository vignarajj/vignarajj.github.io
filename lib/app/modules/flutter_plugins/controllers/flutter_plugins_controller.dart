import 'package:get/get.dart';
import 'package:portfolio/shared/models/flutter_plugin.dart';

/// GetX controller for managing Flutter plugins data
class FlutterPluginsController extends GetxController {
  final RxList<FlutterPlugin> plugins = <FlutterPlugin>[].obs;
  final RxBool isLoading = false.obs;
  final RxInt currentIndex = 0.obs;
  final RxDouble cardWidth = 250.0.obs;

  @override
  void onInit() {
    _loadPlugins();
    super.onInit();
  }

  /// Load Flutter plugins data
  void _loadPlugins() {
    plugins.assignAll([
      FlutterPlugin.fromData(
        name: 'logitx',
        description:
            'A comprehensive logging package for Flutter with multiple levels, file output, and customizable formatting.',
        pubDevUrl: 'https://pub.dev/packages/logitx',
      ),
      FlutterPlugin.fromData(
        name: 'theme_maker',
        description:
            'A Flutter package that simplifies theme creation and management with dynamic theme switching capabilities.',
        pubDevUrl: 'https://pub.dev/packages/theme_maker',
      ),
      FlutterPlugin.fromData(
        name: 'quik_locale',
        description:
            'Quick and easy internationalization (i18n) for Flutter apps with minimal setup and maximum flexibility.',
        pubDevUrl: 'https://pub.dev/packages/quik_locale',
      ),
      FlutterPlugin.fromData(
        name: 'qutils',
        description:
            'A collection of utility functions and widgets for Flutter development to boost productivity.',
        pubDevUrl: 'https://pub.dev/packages/qutils',
      ),
      FlutterPlugin.fromData(
        name: 'qftools',
        description:
            'Essential development tools and helpers for Flutter projects with common patterns and solutions.',
        pubDevUrl: 'https://pub.dev/packages/qftools',
      ),
    ]);
  }

  void updateCurrentIndex(int index) => currentIndex.value = index;
  void updateCardWidth(double width) => cardWidth.value = width;
}
