import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wrestling_news/secrets/secrets.dart';

class NewsStoriesService {
  final String baseUrl = "https://professional-wrestling.p.rapidapi.com";
  final String apiKey = Secrets.apiKey;
  final String apiHost = Secrets.apiHost;

  Future<dynamic> fetchWrestlingNewsStories(String endpoint) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    try {
      final response = await http.get(
        url,
        headers: {
          "X-RapidAPI-Key": apiKey,
          "X-RapidAPI-Host": apiHost,
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load data: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
