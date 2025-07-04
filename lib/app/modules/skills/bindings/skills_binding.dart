import 'package:get/get.dart';
import '../controllers/skill_controller.dart';

class SkillsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SkillController>(
      () => SkillController(),
    );
  }
} 