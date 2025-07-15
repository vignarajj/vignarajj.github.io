import 'package:get/get.dart';
import 'package:portfolio/app/modules/contact/views/contact_screen.dart';
import 'package:portfolio/app/modules/core_competency/views/core_competency_view.dart';
import 'package:portfolio/app/modules/home/bindings/home_binding.dart';
import 'package:portfolio/app/modules/home/views/home_view.dart';
import 'package:portfolio/app/modules/skills/views/skill_view.dart';
import 'package:portfolio/shared/models/core_compentency.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = _Paths.home;
  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => HomeView(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: _Paths.skill,
      page: () => SkillView(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: _Paths.coreCompetency,
      page: () {
        final CoreCompetency competency = Get.arguments as CoreCompetency;
        return CoreCompetencyDetailView(competency: competency);
      },
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: _Paths.contact,
      page: () => ContactView(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 400),
    ),
  ];
}
