import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:portfolio/network/api_services.dart';
import 'package:portfolio/app/modules/chat/services/chat_service.dart';

// GetIt instance
final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  // Register ApiServices as a singleton
  Get.lazyPut<ApiServices>(() => ApiServices(), fenix: true);

  // Register ChatService as a singleton
  Get.lazyPut<ChatService>(() => ChatService(), fenix: true);
}

ApiServices get apiServices => locator<ApiServices>();
