import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:verto/models/session.dart';
import 'package:verto/services/auth.dart';
import 'package:verto/utils/elements.dart';
import 'package:verto/utils/requests.dart';

Future<List<Session>?> fetchRecent({
  required BuildContext context,
}) async {

  List<Session>? sessions = await makeRequest<List<Session>>(
    type: RequestType.post,
    path: "/api/sessions/recent?count=10",
    fromJson: (fetched) => fetched.map<Session>((session) => Session.fromJson(session)).toList(),
  );

  if (sessions == null) {
    showSnackBar(context, "please login again");
    logout(context: context);
    return null;
  }
  return sessions;
}

Future<Session?> create({
  required String startTime,
  required int price,
  required String title,
  required String description,
}) async {
  Map<String, dynamic> req = {
    "start_time": startTime,
    "price": price,
    "title": title,
    "description": description
  };

  Session? session = await makeRequest<Session>(
    type: RequestType.post,
    path: "/api/sessions/create",
    data: req,
    fromJson : (fetched) => Session.fromJson(fetched)
  );

  return session;
}

void book({
  required String id
}) async {
  void book = await makeRequest<void>(
    type: RequestType.post,
    path: "/api/session/book/$id"
  );

  return;
}


