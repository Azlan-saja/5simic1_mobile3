import 'package:aplikasi_5simic1_mobile3/database/database_helper.dart';
import 'package:aplikasi_5simic1_mobile3/models/user_model.dart';
import 'package:aplikasi_5simic1_mobile3/views/home/home_view.dart';
import 'package:flutter/material.dart';

class LoginController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool isVisible = false;
  final db = DatabaseHelper();
  final formKey = GlobalKey<FormState>();

  void lihatPassword() {
    isVisible = !isVisible;
  }

  String? cekValidasi({required String label, required String? value}) {
    if (value!.isEmpty) {
      return "$label is required";
    }
    return null;
  }

  Future<void> login(BuildContext context) async {
    try {
      var response = await db.login(
        UserModel(
          userName: usernameController.text,
          userPassword: passwordController.text,
        ),
      );

      if (!context.mounted) return;
      if (response == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Login success'),
            backgroundColor: Colors.teal[400],
            behavior: SnackBarBehavior.floating,
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeView(),
          ),
        );
        // Navigasi ke halaman Notes jika login berhasil
        // akan dibuat nanti setelah halaman Notes dibuat
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login failed! Please try again.'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed! Please try again.'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
