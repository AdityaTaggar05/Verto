import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:verto/models/session.dart';
import 'package:verto/utils/requests.dart';

Future<List<Session>?> fetchRecent({required BuildContext context}) async =>
    await makeRequest<List<Session>>(
      type: RequestType.post,
      path: "/api/sessions/recent?count=10",
      fromJson: (fetched) =>
          fetched.map<Session>((session) => Session.fromJson(session)).toList(),
    );

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
    "description": description,
  };

  Session? session = await makeRequest<Session>(
    type: RequestType.post,
    path: "/api/sessions/create",
    data: req,
    fromJson: (fetched) => Session.fromJson(fetched),
  );

  return session;
}

void book({required String id}) async {
  void book = await makeRequest<void>(
    type: RequestType.post,
    path: "/api/session/book/$id",
  );
  return;
}

Future<List<Session>?> fetchSessionsDaywise({
  required BuildContext context,
  // day should be either today or tomorrow
  required String day,
}) async {
  List<Session>? sessions = await makeRequest<List<Session>>(
    type: RequestType.get,
    path: "/api/sessions/timeline?mode=$day",
    fromJson: (fetched) =>
        fetched.map<Session>((session) => Session.fromJson(session)).toList(),
  );

  return sessions;
  // TODO: handle errors in daywise fetching
}

Future<List<Session>?> fetchSessionSearchwise({
  required BuildContext context,
  required int count,
  required String search,
}) async {
  List<Session>? sessions = await makeRequest<List<Session>>(
    type: RequestType.get,
    path: "/api/sessions?count=$count&search=$search",
    fromJson: (fetched) =>
        fetched.map<Session>((session) => Session.fromJson(session)).toList(),
  );

  return sessions;
  // TODO: handle errors in searcwise fetching
}

Future<List<Session>?> fetchUpcoming(BuildContext context) async =>
    await makeRequest<List<Session>>(
      type: RequestType.get,
      path: "/api/sessions/upcoming",
      fromJson: (fetched) {
        return fetched
            .map<Session>((session) => Session.fromJson(session))
            .toList();
      },
    );
