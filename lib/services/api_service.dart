// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class ApiService {
//   static const String baseUrl = 'http://192.168.1.2:8000/api';

//   static Future<List<dynamic>> get(String endpoint) async {
//     final response = await http.get(Uri.parse('$baseUrl/$endpoint'));

//     if (response.statusCode == 200) {
//       return json.decode(response.body);
//     } else {
//       throw Exception('Failed to fetch $endpoint');
//     }
//   }
// }

// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class ApiService {
//   static Future<Map<String, dynamic>> get(String endpoint) async {
//     final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/$endpoint'));

//     if (response.statusCode == 200) {
//       return json.decode(response.body);
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }
// }


// import 'package:http/http.dart' as http;

// class ApiService {
//   static const String _baseUrl = 'http://10.0.2.2:8000/api/';

//   static Future<http.Response> get(String endpoint) async {
//     final url = Uri.parse('$_baseUrl$endpoint');
//     try {
//       final response = await http.get(url);
//       return response;
//     } catch (e) {
//       throw Exception('Gagal terhubung ke server: $e');
//     }
//   }
// }

// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class ApiService {
//   static Future<dynamic> get(String endpoint) async {
//     final response = await http.get(
//       Uri.parse('http://10.0.2.2:8000/api/$endpoint'),
//       headers: {
//         'Authorization': 'Bearer <8|skYWvLmps29Mi74Cmix2h0sR3QCOTumXtXyHku5v70f3c6dd>',
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//       },
//     );

//     if (response.statusCode == 200) {
//       return json.decode(response.body);
//     } else {
//       throw Exception('Failed to load data (status ${response.statusCode})');
//     }
//   }
// }


import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/config.dart';

class ApiService {
  static Future<dynamic> get(String endpoint) async {
    final response = await http.get(
      Uri.parse('${Config.baseApiUrl}/$endpoint'),
      headers: {
        'Authorization': Config.authToken,
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data (status ${response.statusCode})');
    }
  }
}