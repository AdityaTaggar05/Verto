import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:verto/models/user.dart';
import 'package:verto/services/storage_service.dart';

Future<User?> registerUser({
  required String firstName,
  required String lastName,
  required String email,
  required String password,
  required String username,

}) async {
  Map<String, dynamic> req = {
    "first_name": firstName,
    "last_name": lastName,
    "username": username,
    "email": email,
    "password": password,
  };
  
  final http.Response response = await http.post(
    Uri.parse("https://verto-5rad.onrender.com/api/auth/register"),
    headers: {'Content-Type': 'application/json; charset=UTF-8'},
    body: jsonEncode(req),
  );

  if (response.statusCode == 201) {
    Map<String, dynamic> fetchedData = jsonDecode(response.body);

    StorageService().setAccessToken(fetchedData['data']['access_token']);
    StorageService().setRefreshToken(fetchedData['data']['refresh_token']);
    User user = User.fromJson(fetchedData["data"]["user"]);

    return user;
  }
  return null;
}

Future<User?> loginUser({
  required String username,
  required String password,
}) async {
  Map<String, dynamic> req = {
    "username": username,
    "password": password
  };

  final http.Response response = await http.post(
    Uri.parse("https://verto-5rad.onrender.com/api/auth/login"),
    headers: {'Content-Type': 'application/json; charset=UTF-8'},
    body: jsonEncode(req),
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> fetchedData = jsonDecode(response.body);

    User user = User.fromJson(fetchedData["data"]["user"]);

    return user;
  } else {
    return null;
  }
}
