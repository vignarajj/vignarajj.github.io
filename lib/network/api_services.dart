import 'package:get/get.dart';
import 'package:portfolio/network/api_constants.dart';
import 'package:portfolio/shared/models/contact_model.dart';

class ApiServices extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = ApiConstants.baseUrl;
    httpClient.timeout = const Duration(minutes: 3);
    httpClient.defaultContentType = 'application/json';
    httpClient.timeout = const Duration(seconds: 10);
    super.onInit();
  }

  // Generic GET request
  Future<T> getRequest<T>(String endpoint,
      {Map<String, dynamic>? queryParams}) async {
    try {
      final response = await get(endpoint, query: queryParams);
      if (response.status.hasError) {
        throw Exception('GET failed: ${response.statusText}');
      }
      return response.body;
    } catch (e) {
      print("❌ GET Error: $e");
      throw Exception('Failed to fetch data');
    }
  }

  // Generic POST request
  Future<T> postRequest<T>(String endpoint, dynamic data) async {
    try {
      final response = await post(endpoint, data);
      if (response.status.hasError) {
        throw Exception('POST failed: ${response.statusText}');
      }
      return response.body;
    } catch (e) {
      print("❌ POST Error: $e");
      throw Exception('Failed to send data');
    }
  }

  // Track visitor count
  Future<int> getVisitorsCount() async {
    print("📡 Calling: ${httpClient.baseUrl}${ApiConstants.trackVisit}");
    try {
      final response = await get(ApiConstants.trackVisit);

      if (response.status.hasError) {
        throw Exception(
            '❌ Visit tracking failed: ${response.statusCode} ${response.statusText}');
      }

      if (response.body is Map<String, dynamic>) {
        return response.body['unique_visits'] ?? 0;
      } else {
        throw Exception('Invalid response format');
      }
    } catch (e, trace) {
      print("❌ Visit Count Error: $e $trace");
      return 0;
    }
  }

  // Contact form submission
  Future<String> sendContact(ContactModel contact) async {
    try {
      final response = await post(ApiConstants.contact, contact.toJson());

      if (response.statusCode == 200) {
        print("✅ Contact sent");
        return "Message sent successfully!";
      } else if (response.statusCode == 429) {
        return "You've reached the message limit. Please try again later.";
      } else if (response.statusCode == 400) {
        return "Invalid input data. Please check your entries.";
      } else {
        throw Exception("❌ Failed: ${response.statusText}");
      }
    } catch (e) {
      print("❌ Contact Error: $e");
      return "Something went wrong. Please try again.";
    }
  }

  // Chatbot question submission
  Future<String> askQuestion(String question) async {
    try {
      print("📡 Sending question to chatbot: $question");
      final response = await post(
        ApiConstants.chatbot,
        {'question': question},
      );

      if (response.status.hasError) {
        throw Exception('Chatbot request failed: ${response.statusText}');
      }

      if (response.body is Map<String, dynamic>) {
        final data = response.body as Map<String, dynamic>;
        if (data['status'] == 'success') {
          return data['answer'] as String;
        } else {
          throw Exception('Chatbot returned error status: ${data['status']}');
        }
      } else {
        throw Exception('Invalid response format from chatbot');
      }
    } catch (e) {
      print("❌ Chatbot Error: $e");
      return "I'm having trouble connecting right now. Please try again later.";
    }
  }
}
