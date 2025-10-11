import 'package:verto/models/user.dart';
import 'package:verto/utils/requests.dart';

Future<User?> fetchUser() async => await makeRequest<User>(
  type: RequestType.get,
  path: "/api/",
  fromJson: (data) => User.fromJson(data),
);
