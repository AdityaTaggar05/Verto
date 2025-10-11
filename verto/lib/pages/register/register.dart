import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:verto/utils/validators.dart';
import 'package:verto/pages/login/login.dart';
import 'package:verto/widgets/custom_textfield.dart';
import 'package:verto/widgets/password_text_field.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
  }

  void register() {
    final email = emailController.text;
    final password = passwordController.text;
    final confirm = confirmController.text;
    final firstName = firstNameController.text;
    final lastName = lastNameController.text;

    print('Register button pressed');
    print('Email: $email');

    if(firstName.isEmpty) {
      const snackBar = SnackBar(
        content: Text(
          "Please enter your first name",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold
          )
        ),
        backgroundColor: Color.fromARGB(241, 235, 125, 57),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    if(lastName.isEmpty) {
      const snackBar = SnackBar(
        content: Text(
          "Please enter your last name",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold
          )
        ),
        backgroundColor: Color.fromARGB(241, 235, 125, 57),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    if (password != confirm) {
      const snackBar = SnackBar(
        content: Text(
          "Passwords do not match",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold
          )
        ),
        backgroundColor: Color.fromARGB(241, 235, 125, 57),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    if(emailValidator(email) == 'Please enter a valid email') {
      const snackBar = SnackBar(
        content: Text(
          "Please enter a valid email",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold
          )
        ),
        backgroundColor: Color.fromARGB(241, 235, 125, 57),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    
    else if(emailValidator(email) == 'Please enter an email') {
      const snackBar = SnackBar(
        content: Text(
          "No email was entered",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold
          )
        ),
        backgroundColor: Color.fromARGB(241, 235, 125, 57),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
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
                // 1. Verto Banner
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
                // 2. Login navigator
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
                                MaterialPageRoute(builder: (context) => LoginPage())
                              );
                              print('Navigate to Login Screen');
                            },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40.0),

                // 3. First Name & Last Name Fields
                Row(
                  children: [
                    Expanded(child: CustomTextField(hintText: 'First Name')),
                    const SizedBox(width: 16.0),
                    Expanded(child: CustomTextField(hintText: 'Last Name')),
                  ],
                ),
                const SizedBox(height: 20.0),

                // 4. E-mail Field
                CustomTextField(
                  controller: emailController,
                  hintText: 'E-mail',
                  validator: emailValidator,
                ),
                const SizedBox(height: 20.0),

                // 5. Username Field
                CustomTextField(hintText: 'Username'),
                const SizedBox(height: 20.0),

                // 6. Password & Confirm Password Fields
                Row(
                  children: [
                    Expanded(
                      child: PasswordTextField(
                        controller: passwordController,
                        hintText: 'Password',
                        obscureText: true,
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: PasswordTextField(
                        controller: confirmController,
                        hintText: 'Confirm',
                        obscureText: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40.0),

                // 7. Register Button
                ElevatedButton(
                  onPressed: () {
                    register();
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
                    'Register',
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
