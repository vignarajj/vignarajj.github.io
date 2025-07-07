import 'package:get/get.dart';
import '../controllers/medium_controller.dart';

class MediumBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MediumController>(() => MediumController());
  }
}
