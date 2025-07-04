import 'package:get/get.dart';
import '../controllers/core_competency_controller.dart';

class CoreCompetencyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CoreCompetencyController>(
      () => CoreCompetencyController(),
    );
  }
} 