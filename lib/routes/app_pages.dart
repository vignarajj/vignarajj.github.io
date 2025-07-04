import 'package:get/get.dart';
import 'package:portfolio/app/modules/core_competency/views/core_competency_view.dart';
import 'package:portfolio/app/modules/home/views/home_view.dart';
import 'package:portfolio/app/modules/skills/views/skill_view.dart';
import 'package:portfolio/shared/models/core_compentency.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = _Paths.home;
  static final routes = [
    GetPage(name: _Paths.home, page: () => HomeView()),
    GetPage(name: _Paths.skill, page: () => SkillView()),
    GetPage(
      name: _Paths.coreCompetency,
      page: () {
        final CoreCompetency competency = Get.arguments as CoreCompetency;
        return CoreCompetencyDetailView(competency: competency);
      },
    ),
  ];
}
