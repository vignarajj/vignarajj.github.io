// Repository for fetching Medium RSS feed using Dio and xml
import 'package:dio/dio.dart';
import 'package:portfolio/shared/models/medium_post.dart';
import 'package:xml/xml.dart';

class MediumRepository {
  final Dio _dio = Dio(BaseOptions(
    headers: {
      'User-Agent':
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
      'Accept': 'application/rss+xml, application/xml, text/xml',
    },
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  // Fetch the latest Medium posts from RSS feed
  Future<List<MediumPost>> fetchMediumPosts(String username) async {
    final proxies = [
      'https://api.codetabs.com/v1/proxy?quest=',
      'https://corsproxy.io/?',
    ];
    final feedUrl = 'https://medium.com/feed/@$username';
    DioException? lastError;

    for (final proxy in proxies) {
      final requestUrl = '$proxy${Uri.encodeComponent(feedUrl)}';
      for (int attempt = 1; attempt <= 3; attempt++) {
        try {
          print('Attempt $attempt: Fetching Medium posts from: $requestUrl');
          final response = await _dio.get(
            requestUrl,
            options: Options(
              validateStatus: (status) => status != null && status < 500,
            ),
          );
          print('Response status: ${response.statusCode}, Data type: ${response.data.runtimeType}');

          if (response.statusCode == 200 && response.data is String) {
            return _parseXmlResponse(response.data as String);
          } else {
            throw Exception('Invalid response: Status ${response.statusCode}, Data ${response.data.runtimeType}');
          }
        } on DioException catch (e) {
          lastError = e;
          print('DioException (Attempt $attempt, Proxy $proxy): ${e.message}, Type: ${e.type}, Response: ${e.response}, Stack: ${e.stackTrace}');
          if (attempt < 3) {
            await Future.delayed(Duration(milliseconds: 500 * attempt));
            continue;
          }
        } catch (e) {
          print('Unexpected error (Proxy $proxy): $e, Stack: ${StackTrace.current}');
          lastError = DioException(
            requestOptions: RequestOptions(path: requestUrl),
            error: e,
            type: DioExceptionType.unknown,
          );
        }
      }
    }

    throw Exception('Failed to fetch Medium posts after retries: ${lastError?.message}');
  }

  // Parse XML response into MediumPost list
  List<MediumPost> _parseXmlResponse(String xmlString) {
    try {
      print('Parsing XML response: ${xmlString.substring(0, min(xmlString.length, 200))}...');
      final document = XmlDocument.parse(xmlString);
      final items = document.findAllElements('item').take(5).map((item) {
        final dcDate = item.findAllElements('dc:date').isNotEmpty
            ? item.findAllElements('dc:date').first.text
            : null;
        return MediumPost.fromXml({
          'title': item.findElements('title').isNotEmpty
              ? item.findElements('title').first.text
              : 'No Title',
          'link': item.findElements('link').isNotEmpty
              ? item.findElements('link').first.text
              : '',
          'pubDate': item.findElements('pubDate').isNotEmpty
              ? item.findElements('pubDate').first.text
              : dcDate ?? '',
        });
      }).toList();
      print('Parsed ${items.length} posts');
      return items;
    } catch (e) {
      print('XML parsing error: $e, Stack: ${StackTrace.current}');
      throw Exception('Failed to parse XML: $e');
    }
  }

  // Helper to find minimum for substring
  int min(int a, int b) => a < b ? a : b;
}