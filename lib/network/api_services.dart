import 'package:http/http.dart' as http;

Future<String> fetchXmlFeed() async {
  print("fetchXmlFeed");
  try {
    final response =
    await http.get(Uri.parse('https://medium.com/feed/@vignarajj'));
    // print("response:: ${response.statusCode}");
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load XML feed');
    }
  }catch(e, trace){
    // print("error:: $e");
    // print("trace:: $trace");
    return "error";
  }
}

