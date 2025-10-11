import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:verto/models/session.dart';
import 'package:verto/models/user.dart';
import 'package:verto/utils/elements.dart';
import 'package:verto/utils/requests.dart';

Future<List<Session>?> fetchRecent({
}) async {
  Map<String, dynamic> req = {
    "id": id,
    "host_id": hostId,
    "host_name": hostName,
    "price": price,
    "created_at": createdAt,
    "is_booked": isBooked,
  };

  List<Session>? sessions = await makeRequest<List<Session>>(
    type: RequestType.post,
    path: "/api/sessions/recent?count=10",
    data: req,
    fromJson: (data) => data.map<Session>((s) => Session.fromJson(s)).toList(),
  );

  if (sessions == null) {
    showSnackBar(context, "please login again");
    
    return null;
  }
  return sessions;
}
