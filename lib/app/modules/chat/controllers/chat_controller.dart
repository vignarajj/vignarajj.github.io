import 'package:get/get.dart';
import '../models/chat_message.dart';
import '../services/chat_service.dart';

class ChatController extends GetxController {
  final ChatService _chatService = Get.find<ChatService>();

  final RxList<ChatMessage> messages = <ChatMessage>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isFirstTime = true.obs;

  final List<String> predefinedQuestions = [
    'Tell me about your experience',
    'What are your skills?',
    'How can I contact you?',
  ];

  @override
  void onInit() {
    super.onInit();
    // Add initial bot message
    messages.add(ChatMessage.bot("Hello! How can I assist you today?"));
  }

  Future<void> sendMessage(String message) async {
    if (message.trim().isEmpty) return;

    // Add user message
    messages.add(ChatMessage.user(message));
    isFirstTime.value = false;

    // Show loading
    isLoading.value = true;

    try {
      // Get response from API
      final response = await _chatService.sendMessage(message);

      // Add bot response
      messages.add(ChatMessage.bot(response));
    } finally {
      isLoading.value = false;
    }
  }

  void handlePredefinedQuestion(String question) {
    sendMessage(question);
  }
}
