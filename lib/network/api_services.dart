import 'dart:convert'; // Add this import for json encoding

import 'package:get/get.dart';
import 'package:http/http.dart' as http; // Add http package import
import 'package:portfolio/network/api_constants.dart';
import 'package:portfolio/shared/models/contact_model.dart';

class ApiServices extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = ApiConstants.baseUrl;
    httpClient.timeout = const Duration(seconds: 20);
    httpClient.defaultContentType = 'application/json';
    httpClient.followRedirects = true;
    httpClient.maxRedirects = 3;

    super.onInit();
  }

  // Generic GET request
  Future<T> getRequest<T>(
    String endpoint, {
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
  }) async {
    try {
      final defaultHeaders = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };

      final response = await get(
        endpoint,
        query: queryParams,
        headers: {...defaultHeaders, ...?headers},
      );

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
  Future<T> postRequest<T>(
    String endpoint,
    dynamic data, {
    Map<String, String>? headers,
  }) async {
    try {
      final defaultHeaders = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };

      final response = await post(
        endpoint,
        data,
        headers: {...defaultHeaders, ...?headers},
      );

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
      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };

      final response = await get(ApiConstants.trackVisit, headers: headers);

      if (response.status.hasError) {
        throw Exception(
          '❌ Visit tracking failed: ${response.statusCode} ${response.statusText}',
        );
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

  // Contact form submission using standard HTTP package
  Future<String> sendContact(ContactModel contact) async {
    print("📡 Sending contact: ${contact.toJson()}"); // Debug log
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.contact}');
      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };

      final jsonData = contact.toJson();
      final jsonString = jsonEncode(jsonData);
      print("📤 JSON String: $jsonString"); // Debug log
      print("📤 URL: $url"); // Debug log

      final response = await http.post(url, headers: headers, body: jsonString);

      print("📥 Response Status: ${response.statusCode}"); // Debug log
      print("📥 Response Body: ${response.body}"); // Debug log

      if (response.statusCode == 200) {
        print("✅ Contact sent");
        return "Message sent successfully!";
      } else if (response.statusCode == 429) {
        return "You've reached the message limit. Please try again later.";
      } else if (response.statusCode == 400) {
        return "Invalid input data. Please check your entries.";
      } else {
        throw Exception("❌ Failed: ${response.statusCode} ${response.body}");
      }
    } catch (e, trace) {
      print("❌ Contact Error: $e");
      print("Stack Trace: $trace");
      return "Something went wrong. Please try again.";
    }
  }

  // Chatbot question submission
  Future<String> askQuestion(String question) async {
    print("📡 Sending question to chatbot: $question");

    // Try multiple endpoints if primary fails
    for (int i = 0; i < ApiConstants.fallbackUrls.length; i++) {
      final baseUrl = ApiConstants.fallbackUrls[i];

      try {
        print("🗺 Trying endpoint $i: $baseUrl");

        // Create a new HTTP client for each attempt
        final client = GetConnect();
        client.baseUrl = baseUrl;
        client.timeout = const Duration(seconds: 8);
        client.defaultContentType = 'application/json';

        // Add headers directly to the request
        final headers = {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'User-Agent': 'Flutter-Portfolio-App',
        };

        final response = await client
            .post(ApiConstants.chatbot, {
              'question': question,
            }, headers: headers)
            .timeout(
              const Duration(seconds: 10),
              onTimeout: () {
                throw Exception('Request timeout for $baseUrl');
              },
            );

        if (response.status.hasError) {
          print("⚠ Endpoint $baseUrl failed: ${response.statusText}");
          if (i == ApiConstants.fallbackUrls.length - 1) {
            throw Exception('All endpoints failed: ${response.statusText}');
          }
          continue; // Try next endpoint
        }

        if (response.body is Map<String, dynamic>) {
          final data = response.body as Map<String, dynamic>;
          if (data['status'] == 'success') {
            print("✅ Success with endpoint: $baseUrl");
            return data['answer'] as String;
          } else {
            print("⚠ API returned error: ${data['status']}");
            if (i == ApiConstants.fallbackUrls.length - 1) {
              throw Exception('API error: ${data['status']}');
            }
            continue; // Try next endpoint
          }
        } else {
          print("⚠ Invalid response format from: $baseUrl");
          if (i == ApiConstants.fallbackUrls.length - 1) {
            throw Exception('Invalid response format');
          }
          continue; // Try next endpoint
        }
      } catch (e) {
        print("❌ Error with endpoint $baseUrl: $e");
        if (i == ApiConstants.fallbackUrls.length - 1) {
          // Last attempt failed, re-throw
          throw Exception('All chatbot endpoints failed: $e');
        }
        // Continue to next endpoint
      }
    }

    throw Exception('No endpoints available');
  }
}
