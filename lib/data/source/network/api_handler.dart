import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiHandler {
  static Future<T> get<T>({
    required String url,
    required Map<String, String> headers,
    required T Function(Map<String, dynamic>) fromJson,
    required String errorMessage,
  }) async {
    debugPrint("ApiHandler::[GET] url: $url");
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        debugPrint("ApiHandler::Success. response body: $body");
        return fromJson(body);
      } else {
        debugPrint(
            "ApiHandler::Failed to get data. Status code: ${response.statusCode}");
        debugPrint("ApiHandler::Failed to get data. body: ${response.body}");
        return Future.error(errorMessage);
      }
    } catch (e) {
      debugPrint("ApiHandler::An error occurred. error: $e");
      return Future.error(e);
    }
  }

  static Future<T> post<T>({
    required String url,
    required Map<String, String> headers,
    required Map<String, dynamic> body,
    required T Function(Map<String, dynamic>) fromJson,
    required String errorMessage,
  }) async {
    debugPrint("ApiHandler::[POST] url: $url");
    debugPrint("ApiHandler::[POST] request body: $body");
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        var body = json.decode(response.body);
        debugPrint("ApiHandler::Success. response body: $body");
        return fromJson(body);
      } else {
        debugPrint(
            "ApiHandler::Failed to get data. Status code: ${response.statusCode}");
        debugPrint("ApiHandler::Failed to get data. body: ${response.body}");
        return Future.error(errorMessage);
      }
    } catch (e) {
      debugPrint("ApiHandler::An error occurred. error: $e");
      return Future.error(e);
    }
  }

  static Future<T> postWithImage<T>({
    required String url,
    required List<int> bytes,
    required String filename,
    required Map<String, String> headers,
    required Map<String, String> body,
    required T Function(Map<String, dynamic>) fromJson,
    required String errorMessage,
  }) async {
    debugPrint("ApiHandler::[POST] url: $url");
    debugPrint("ApiHandler::[POST] request body: $body");
    try {
      final request = http.MultipartRequest(
        "POST",
        Uri.parse(url),
      );

      final file = http.MultipartFile.fromBytes(
        "photo",
        bytes,
        filename: filename,
      );

      request.fields.addAll(body);
      request.files.add(file);
      request.headers.addAll(headers);

      final http.StreamedResponse streamedResponse = await request.send();
      final int statusCode = streamedResponse.statusCode;
      final Uint8List responseList = await streamedResponse.stream.toBytes();
      final String responseData = String.fromCharCodes(responseList);

      if (statusCode == 200 || statusCode == 201) {
        var body = json.decode(responseData);
        debugPrint("ApiHandler::Success. response body: $body");
        return fromJson(body);
      } else {
        debugPrint(
            "ApiHandler::Failed to get data. Status code: $statusCode");
        debugPrint("ApiHandler::Failed to get data. body: $responseData");
        return Future.error(errorMessage);
      }
    } catch (e) {
      debugPrint("ApiHandler::An error occurred. error: $e");
      return Future.error(e);
    }
  }
}
