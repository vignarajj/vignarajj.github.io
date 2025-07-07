import 'package:get/get.dart';
import 'package:portfolio/shared/models/skill_model.dart';

class SkillController extends GetxController {
  late Skill skill;

  @override
  void onInit() {
    skill = Get.arguments as Skill;
    super.onInit();
  }
}
