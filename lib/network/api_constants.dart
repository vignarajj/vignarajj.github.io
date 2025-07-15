import 'package:flutter/foundation.dart';

class ApiConstants {
  // Use different API endpoints based on environment
  static String get baseUrl {
    if (kDebugMode) {
      // Development: Try multiple endpoints
      return "https://portfoliobackend-production-724a.up.railway.app";
    } else {
      // Production: Use primary endpoint
      return "https://portfoliobackend-production-724a.up.railway.app";
    }
  }
  
  // Fallback endpoints to try if primary fails
  static const List<String> fallbackUrls = [
    "https://portfoliobackend-production-724a.up.railway.app",
  ];
  
  static const String trackVisit = "/track-visit";
  static const String contact = "/contact";
  static const String chatbot = "/chatbot/chat";
}
