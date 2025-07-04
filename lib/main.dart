import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:portfolio/app/modules/medium/controllers/medium_controller.dart';
import 'package:portfolio/core/services/injector.dart';
import 'package:portfolio/routes/app_pages.dart';
import 'package:portfolio/shared/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(MediumController());
  await setupLocator();
  runApp(const MyPortfolio());
}

class MyPortfolio extends StatelessWidget {
  const MyPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.home,
      title: "Welcome",
      //Routes.BASE_PAGE,
      // initialBinding: InitialBindings(),
      getPages: AppPages.routes,
      defaultTransition: Transition.rightToLeftWithFade,
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.darkTheme,
      locale: const Locale("en", "US"),
      fallbackLocale: const Locale("en", "US"),
    );
  }
}
