part of 'app_pages.dart';

abstract class AppRoutes {
  static const home = _Paths.home;
  static const skill = _Paths.skill;
  static const coreCompetency = _Paths.coreCompetency;
  static const contact = _Paths.contact;
  AppRoutes._();
}

abstract class _Paths {
  static const home = '/home';
  static const skill = '/skill';
  static const coreCompetency = '/core-competency';
  static const contact = '/contact';

  _Paths._();
}
