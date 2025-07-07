// Model for Medium posts parsed from RSS feed
import 'package:intl/intl.dart';

class MediumPost {
  final String title;
  final String link;
  final DateTime? pubDate;

  MediumPost({required this.title, required this.link, this.pubDate});

  // Factory constructor to create MediumPost from XML data
  factory MediumPost.fromXml(Map<String, String> xmlData) {
    // Parse date with RFC 2822 format
    DateTime? parsedDate;
    final dateStr = xmlData['pubDate'] ?? xmlData['dc:date'] ?? '';
    if (dateStr.isNotEmpty) {
      try {
        // RFC 2822 format: "ddd, dd MMM yyyy HH:mm:ss zzz"
        final formatter = DateFormat('EEE, dd MMM yyyy HH:mm:ss z');
        parsedDate = formatter.parseUTC(dateStr);
      } catch (e) {
        print('Failed to parse date: $dateStr, Error: $e');
        // Fallback to DateTime.parse with cleaned format
        try {
          parsedDate = DateTime.parse(dateStr.replaceAll('GMT', '+0000'));
        } catch (e) {
          print('Fallback parse failed: $dateStr, Error: $e');
        }
      }
    }

    return MediumPost(
      title: xmlData['title'] ?? 'No Title',
      link: xmlData['link'] ?? '',
      pubDate: parsedDate,
    );
  }
}
