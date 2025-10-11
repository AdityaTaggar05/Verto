import 'package:flutter/material.dart';
import 'package:verto/api/auth.dart';
import 'package:verto/models/user.dart';
import 'package:verto/pages/login/login.dart';
import 'package:verto/services/storage_service.dart';
import 'package:verto/utils/elements.dart';
import 'package:verto/utils/validators.dart';

Future<bool> register({
  required BuildContext context,
  required final email,
  required final password,
  required final confirm,
  required final username,
  required final firstName,
  required final lastName,
}) async {
  if (firstName.isEmpty) {
    showSnackBar(context, "Please enter your first name");
    return false;
  }

  if (lastName.isEmpty) {
    showSnackBar(context, "Please enter your last name");
    return false;
  }

  if (password != confirm) {
    showSnackBar(context, "Passwords do not match");
    return false;
  }

  // TODO: Change responses to int for condition checking
  if (emailValidator(email) == 'Please enter a valid email') {
    showSnackBar(context, "Please enter a valid email");
    return false;
  } else if (emailValidator(email) == 'Please enter an email') {
    showSnackBar(context, "Please enter an email");
    return false;
  }

  final User? user = await registerUser(
    firstName: firstName,
    lastName: lastName,
    email: email,
    password: password,
    username: username,
  );

  if (user != null) {
    await StorageService().setUsername(user.username);
    await StorageService().setFirstName(user.firstName);
    await StorageService().setLastName(user.lastName);

    return true;
  } else {
    showSnackBar(context, "Please try again later");
    return false;
  }
}

Future<bool> login({
  required BuildContext context,
  required final username,
  required final password,
}) async {
  final User? user = await loginUser(username: username, password: password);

  if (user != null) {
    StorageService().setFirstName(user.firstName);
    StorageService().setLastName(user.lastName);
    StorageService().setID(user.id);
    StorageService().setUsername(user.username);

    return true;
  }

  showSnackBar(context, "Please enter correct credentials");
  return false;
}

void logout({required BuildContext context}) {
  StorageService().setUsername("");
  StorageService().setFirstName("");
  StorageService().setLastName("");
  StorageService().setPassword("");
  StorageService().setAccessToken("");
  StorageService().setRefreshToken("");

  while (Navigator.canPop(context)) {
    Navigator.pop(context);
  }

  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
}
