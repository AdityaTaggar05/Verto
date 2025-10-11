import 'package:verto/models/session.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


Future<Session?> createSession({
  required int time,
  required int price,
  required String title,
  required String description,
}) async {
  Map<String,dynamic>creSession={
    "price":price,
    "start_time":time,
  };
  final http.Response response = await http.post(
    Uri.parse("https://verto-5rad.onrender.com/api/sessions/create"),
    headers: {'Content-Type': 'application/json; charset=UTF-8'},
    body: jsonEncode(creSession),
  );
   if (response.statusCode == 200) {
    Map<String, dynamic> resBody = jsonDecode(response.body);

    Session session  = Session.fromJson(resBody["data"]);

    return session ;
  }

  return null;

}
