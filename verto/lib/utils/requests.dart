import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:verto/services/storage_service.dart';

enum RequestType { post, get }

Future<T?> makeRequest<T>({
  required RequestType type,
  required String path,
  T Function(dynamic)? fromJson,
  Map<String, dynamic>? data,
  int successCode = 200,
}) async {
  String? accessToken = StorageService().getAccessToken();

  if (accessToken == null) {
    // TODO: REFRESH
  }

  final Uri uri = Uri.parse("https://verto-5rad.onrender.com$path");

  final Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer $accessToken',
  };

  http.Response response;

  switch (type) {
    case RequestType.get:
      response = await http.get(uri, headers: headers);
      break;
    case RequestType.post:
      response = await http.post(uri, headers: headers, body: jsonEncode(data));
      break;
  }

  if (response.statusCode == successCode && fromJson != null) {
    return fromJson(jsonDecode(response.body)["data"]);
  }

  // TODO: Handle refreshing

  return null;
}
