/// Model for Flutter plugins to showcase in the portfolio
class FlutterPlugin {
  final String name;
  final String description;
  final String pubDevUrl;

  FlutterPlugin({
    required this.name,
    required this.description,
    required this.pubDevUrl,
  });

  /// Factory constructor to create FlutterPlugin from static data
  factory FlutterPlugin.fromData({
    required String name,
    required String description,
    required String pubDevUrl,
  }) {
    return FlutterPlugin(
      name: name,
      description: description,
      pubDevUrl: pubDevUrl,
    );
  }
}
