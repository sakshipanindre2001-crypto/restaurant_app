import 'dart:convert';
import 'dart:io';

import 'config.dart';
import 'exception_handle.dart';

class ApiClient {
  final HttpClient _client = HttpClient();

  Future<Map<String, dynamic>> post(String url, Map body) async {
    try {
      final request = await _client.postUrl(Uri.parse(url));

      // Headers
      AppConfig.headers.forEach((key, value) {
        request.headers.set(key, value);
      });

      request.add(utf8.encode(jsonEncode(body)));

      final response = await request.close();

      final responseBody = await response.transform(utf8.decoder).join();

      if (response.statusCode == 200) {
        return jsonDecode(responseBody);
      } else {
        throw Exception("Error: ${response.statusCode}");
      }
    } catch (e) {
      throw ExceptionHandler.handle(e);
    }
  }

  Future<Map<String, dynamic>> get(String url) async {
    try {
      final request = await _client.getUrl(Uri.parse(url));

      AppConfig.headers.forEach((key, value) {
        request.headers.set(key, value);
      });

      final response = await request.close();

      final responseBody = await response.transform(utf8.decoder).join();

      if (response.statusCode == 200) {
        return jsonDecode(responseBody);
      } else {
        throw Exception("Error: ${response.statusCode}");
      }
    } catch (e) {
      throw ExceptionHandler.handle(e);
    }
  }
}



// import 'dart:convert';
// import 'dart:html';

// import 'config.dart';
// import 'exception_handle.dart';

// class ApiClient {

//   Future<Map<String, dynamic>> post(String url, Map body) async {
//     try {
//       final request = await HttpRequest.request(
//         url,
//         method: 'POST',
//         requestHeaders: AppConfig.headers,
//         sendData: jsonEncode(body),
//       );

//       if (request.status == 200) {
//         return jsonDecode(request.responseText!);
//       } else {
//         throw Exception("Error: ${request.status}");
//       }
//     } catch (e) {
//       throw ExceptionHandler.handle(e);
//     }
//   }

//   Future<Map<String, dynamic>> get(String url) async {
//     try {
//       final request = await HttpRequest.request(
//         url,
//         method: 'GET',
//         requestHeaders: AppConfig.headers,
//       );

//       if (request.status == 200) {
//         return jsonDecode(request.responseText!);
//       } else {
//         throw Exception("Error: ${request.status}");
//       }
//     } catch (e) {
//       throw ExceptionHandler.handle(e);
//     }
//   }
// }