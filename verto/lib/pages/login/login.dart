import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:verto/pages/register/register.dart';
import 'package:verto/widgets/custom_textfield.dart';
import 'package:verto/widgets/password_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
  }

  void  login() {
    
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
                // 1. Verto banner
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
                // 2. login banner
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black54,
                      ),
                      children: <TextSpan>[
                        const TextSpan(text: ' New to the app? '),
                        TextSpan(
                          text: 'Register',
                          style: const TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => RegisterPage())
                              );
                              print('Navigate to register Screen');
                            },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40.0),

                // 3. Username Field
                CustomTextField(
                  controller: usernameController,
                  hintText: "Username",
                ),
                const SizedBox(height: 20.0),

                // 4. Password Field
                PasswordTextField(
                  hintText: "Password",
                  controller: passwordController,
                  obscureText: true,
                ),
                const SizedBox(height: 40.0),

                // 5. login button final
                ElevatedButton(
                  onPressed: () {
                    login();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    backgroundColor: Colors.blueAccent.shade700,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
