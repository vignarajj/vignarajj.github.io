import 'package:get/get.dart';
import '../controllers/flutter_plugins_controller.dart';

class FlutterPluginsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FlutterPluginsController>(() => FlutterPluginsController());
  }
}
