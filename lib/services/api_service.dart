import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/config.dart';

class ApiService {
  static Future<dynamic> get(String endpoint, {Map<String, String>? headers}) async {
    Map<String, String> defaultHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final combinedHeaders = headers != null ? {...defaultHeaders, ...headers} : defaultHeaders;

    try {
      final response = await http.get(
        Uri.parse('${Config.baseApiUrl}/$endpoint'),
        headers: combinedHeaders,
      ).timeout(Duration(seconds: 30));

      print('Request URL: ${Config.baseApiUrl}/$endpoint');
      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data (status ${response.statusCode})');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw e;
    }
  }

  static Map<String, String> getImageHeaders() {
    return {
      'Accept': 'image/*',
    };
  }
}