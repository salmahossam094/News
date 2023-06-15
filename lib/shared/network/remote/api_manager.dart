import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:news/models/NewsResponse.dart';
import 'package:news/models/SourceResponse.dart';
import 'package:news/shared/components/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ApiManager {
  static Future<SourceResponse> getSources(String cat) async {
    Uri URL = Uri.https(
        BASE, "/v2/top-headlines/sources", {"apiKey": APIKEY, "category": cat});
    Response response = await http.get(URL);
    var responseJson = jsonDecode(response.body);
    SourceResponse sourceResponse = SourceResponse.fromJson(responseJson);
    return sourceResponse;
  }

  static Future<NewsResponse> getNewsData(String sourceId) async {
    Uri URL = Uri.https(BASE, "/v2/everything", {
      "apiKey": APIKEY,
      "sources": sourceId,
    });
    http.Response response = await http.get(URL);
    var jsonResponse = jsonDecode(response.body);
    NewsResponse newsResponse = NewsResponse.fromJson(jsonResponse);
    return newsResponse;
  }

  static Future<NewsResponse> search(word) async {
    Uri URL = Uri.https(BASE, "/v2/everything", {
      "apiKey": APIKEY,
      "q": word,
    });
    http.Response response= await http.get(URL);
    var jsonResponse =jsonDecode(response.body);
    NewsResponse newsResponse=NewsResponse.fromJson(jsonResponse);
    return newsResponse;
  }

  static Future<void> openUrl(String URL) async {
    final Uri url = Uri.parse(URL);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
