import 'package:get/get.dart';
import 'package:portfolio/network/api_services.dart';

class ChatService extends GetxService {
  final ApiServices _apiServices = Get.find<ApiServices>();

  // Fallback responses for common questions
  final Map<String, String> _fallbackResponses = {
    'experience': 'I have 5+ years of experience in mobile development with Flutter, Android (Kotlin/Java), and backend technologies like Python/FastAPI. I\'ve built numerous mobile apps, published Flutter packages, and worked on AI/ML integrations.',
    'skills': 'My core skills include Flutter, Dart, Android Development (Kotlin/Java), Python, FastAPI, AI/ML integration, CI/CD with CodeMagic, testing frameworks like Maestro, and modern architecture patterns.',
    'contact': 'You can reach me via email at vignarajj@gmail.com, connect on LinkedIn, or schedule a meeting through the calendar link in this app. All contact details are available in the contact section.',
    'location': 'I\'m based in India and work remotely with clients worldwide. I\'m available for both remote and on-site projects depending on the requirements.',
    'projects': 'I\'ve worked on various projects including mobile apps, web applications, and Flutter packages. You can see my featured projects and Flutter plugins in the portfolio sections above.',
    'default': 'Thanks for your question! I\'m currently unable to provide a detailed response due to connectivity issues, but I\'d be happy to discuss this further if you reach out directly through the contact section.'
  };

  Future<String> sendMessage(String message) async {
    print("📡 Chat Service: Processing message: $message");
    
    try {
      // First try the API with extended timeout
      final response = await _apiServices.askQuestion(message).timeout(
        const Duration(seconds: 25),
        onTimeout: () {
          print("⏰ Chat Service: API timeout, using fallback");
          return _getFallbackResponse(message);
        },
      );
      
      print("✅ Chat Service: API response received");
      return response;
    } catch (e) {
      print("❌ Chat Service Error: $e");
      
      // If API fails, provide fallback response
      final fallbackResponse = _getFallbackResponse(message);
      print("🔄 Chat Service: Using fallback response");
      return fallbackResponse;
    }
  }

  String _getFallbackResponse(String message) {
    final lowercaseMessage = message.toLowerCase().trim();
    print("🔍 Chat Service: Matching keywords in: $lowercaseMessage");
    
    // Check for keyword matches
    if (lowercaseMessage.contains('experience') || lowercaseMessage.contains('work') || lowercaseMessage.contains('background')) {
      print("🎯 Chat Service: Matched 'experience' keywords");
      return _fallbackResponses['experience']!;
    }
    
    if (lowercaseMessage.contains('skill') || lowercaseMessage.contains('technology') || lowercaseMessage.contains('tech')) {
      print("🎯 Chat Service: Matched 'skills' keywords");
      return _fallbackResponses['skills']!;
    }
    
    if (lowercaseMessage.contains('contact') || lowercaseMessage.contains('reach') || lowercaseMessage.contains('email') || lowercaseMessage.contains('phone')) {
      print("🎯 Chat Service: Matched 'contact' keywords");
      return _fallbackResponses['contact']!;
    }
    
    if (lowercaseMessage.contains('location') || lowercaseMessage.contains('located') || lowercaseMessage.contains('where') || lowercaseMessage.contains('live')) {
      print("🎯 Chat Service: Matched 'location' keywords");
      return _fallbackResponses['location']!;
    }
    
    if (lowercaseMessage.contains('project') || lowercaseMessage.contains('portfolio') || lowercaseMessage.contains('app')) {
      print("🎯 Chat Service: Matched 'projects' keywords");
      return _fallbackResponses['projects']!;
    }
    
    // Return default fallback
    print("🛡 Chat Service: Using default fallback response");
    return _fallbackResponses['default']!;
  }
}
