import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart'as http;
import 'package:verto/models/user.dart';

Future<User?> fetchRecent({
  required String id,
  required String hostId,
  required String startTime,
  required int price,
  required String createdAt,
  required bool isBooked,
}) async {
  Map<String,dynamic> req = {
    "id":id,
    "host_id":hostId,
    "start_time":startTime,
    "price":price,
    "created_at":createdAt,
    "is_booked":isBooked,
  };

  final http.Response response = await http.post(
    Uri.parse("https://verto-5rad.onrender.com/api/sessions/recent?count=<10>"),
    headers: {'Content-Type':'application/json; charset=UTF-8'},
    body: jsonEncode(req),
  );

  if(response.statusCode == 200) {
    Map<String,dynamic> resBody = jsonDecode(response.body);

    User user = User.fromJson(resBody["data"]["user"]);

    return user;

  }

  return null;
}