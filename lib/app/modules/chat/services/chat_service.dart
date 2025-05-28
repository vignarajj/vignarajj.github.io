import 'package:get/get.dart';
import 'package:portfolio/network/api_services.dart';

class ChatService extends GetxService {
  final ApiServices _apiServices = Get.find<ApiServices>();

  Future<String> sendMessage(String message) async {
    try {
      return await _apiServices.askQuestion(message);
    } catch (e) {
      print("❌ Chat Service Error: $e");
      return "I'm having trouble connecting right now. Please try again later.";
    }
  }
} 