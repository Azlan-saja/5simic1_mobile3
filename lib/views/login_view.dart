import 'package:aplikasi_5simic1_mobile3/controllers/login_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(14),
          // padding: EdgeInsets.all(14),
          child: SingleChildScrollView(
            child: Form(
              key: loginController.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 1. Gambar
                  Image.asset(
                    "lib/assets/images/login.png",
                    height: 300,
                  ),
                  // 2. Judul
                  SizedBox(height: 10),
                  Text(
                    "Notes App",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // 3. Input Username
                  SizedBox(height: 10),
                  TextFormField(
                    controller: loginController.usernameController,
                    validator: (value) => loginController.cekValidasi(
                        label: 'Username', value: value),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: "Username",
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                      ),
                      filled: true,
                      fillColor:
                          Theme.of(context).colorScheme.primary.withAlpha(25),
                      contentPadding: EdgeInsets.only(top: 14),
                    ),
                  ),
                  // 4. Input Password
                  SizedBox(height: 10),
                  TextFormField(
                    obscureText: !loginController.isVisible,
                    controller: loginController.passwordController,
                    validator: (value) => loginController.cekValidasi(
                        label: 'Password', value: value),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            loginController.lihatPassword();
                          });
                        },
                        child: Icon(
                          loginController.isVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                      hintText: "Password",
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                      ),
                      filled: true,
                      fillColor:
                          Theme.of(context).colorScheme.primary.withAlpha(25),
                      contentPadding: EdgeInsets.only(top: 14),
                    ),
                  ),
                  // 5. Tombol Login
                  SizedBox(height: 10),
                  FilledButton.icon(
                    onPressed: () {
                      if (loginController.formKey.currentState!.validate()) {
                        loginController.login(context);
                      }
                    },
                    label: Text("Login"),
                    icon: Icon(Icons.login),
                  ),
                  // 6. Teks Buat Akun
                  SizedBox(height: 10),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      children: [
                        TextSpan(
                          text: "Create account",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Buka View Create Account!
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
