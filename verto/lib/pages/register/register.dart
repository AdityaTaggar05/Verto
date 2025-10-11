import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:verto/pages/login/login.dart';
import 'package:verto/pages/main.dart';
import 'package:verto/services/auth.dart';
import 'package:verto/utils/validators.dart';
import 'package:verto/widgets/custom_textfield.dart';
import 'package:verto/widgets/password_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final usernameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 32.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40.0),
                const Text(
                  'verto',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 80.0,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black54,
                      ),
                      children: <TextSpan>[
                        const TextSpan(text: 'Already a user? '),
                        TextSpan(
                          text: 'Login',
                          style: const TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40.0),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: firstNameController,
                        hintText: 'First Name',
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: CustomTextField(
                        controller: lastNameController,
                        hintText: 'Last Name',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                CustomTextField(
                  controller: emailController,
                  hintText: 'E-mail',
                  validator: emailValidator,
                ),
                const SizedBox(height: 20.0),
                CustomTextField(
                  controller: usernameController,
                  hintText: 'Username',
                ),
                const SizedBox(height: 20.0),
                PasswordTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 20.0),
                PasswordTextField(
                  controller: confirmController,
                  hintText: 'Confirm',
                  obscureText: true,
                ),
                const SizedBox(height: 40.0),
                RegisterButton(
                  onPressed: () async {
                    final bool status = await register(
                      context: context,
                      email: emailController.text,
                      password: passwordController.text,
                      confirm: confirmController.text,
                      username: usernameController.text,
                      firstName: firstNameController.text,
                      lastName: lastNameController.text,
                    );

                    if (status) {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MainPage()),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterButton extends StatefulWidget {
  const RegisterButton({super.key, required this.onPressed});

  final Future Function() onPressed;

  @override
  State<RegisterButton> createState() => _RegisterButtonState();
}

class _RegisterButtonState extends State<RegisterButton> {
  bool status = true;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: status
          ? () async {
              setState(() => status = false);
              await widget.onPressed();
              setState(() => status = true);
            }
          : null,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        backgroundColor: status
            ? Colors.blueAccent.shade700
            : Colors.grey.shade800,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
      child: const Text(
        'Register',
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    );
  }
}
