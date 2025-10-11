import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:verto/services/auth.dart';
import 'package:verto/services/storage_service.dart';

enum RequestType { post, get }

Future<T?> makeRequest<T>({
  required RequestType type,
  required String path,
  T Function(dynamic)? fromJson,
  Function? onError,
  BuildContext? context,
  Map<String, dynamic>? data,
  int successCode = 200,
}) async {
  String? accessToken = StorageService().getAccessToken();

  print("[TOKEN]: $accessToken");

  if (accessToken == null) {
    // TODO: HANDLE
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

  print(jsonDecode(response.body));

  if (response.statusCode == successCode) {
    if (fromJson != null) return fromJson(jsonDecode(response.body)["data"]);

    return null;
  }

  print("BACH GYA");

  if (response.statusCode == 401) {
    http.Response res = await http.post(
      Uri.parse("https://verto-5rad.onrender.com/api/auth/refresh"),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: {'refresh_token': StorageService().getRefreshToken()},
    );

    Map<String, dynamic> data = jsonDecode(res.body);

    if (data["error"] != null) {
      await StorageService().setAccessToken(data["access_token"]);
      await StorageService().setRefreshToken(data["refresh_token"]);

      switch (type) {
        case RequestType.get:
          response = await http.get(uri, headers: headers);
          break;
        case RequestType.post:
          response = await http.post(
            uri,
            headers: headers,
            body: jsonEncode(data),
          );
          break;
      }

      if (response.statusCode == successCode && fromJson != null) {
        return fromJson(jsonDecode(response.body)["data"]);
      }
    } else {
      logout(context: context!);
    }
  }

  if (onError != null) onError();

  return null;
}
