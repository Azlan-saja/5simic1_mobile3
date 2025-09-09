import 'package:aplikasi_5simic1_mobile3/database/database_helper.dart';
import 'package:aplikasi_5simic1_mobile3/views/home/home_view.dart';
import 'package:aplikasi_5simic1_mobile3/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';

void main() async {
  DatabaseHelper().initDB;
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.light,
        ),
      ),
      // home: LoginView(),
      home: HomeView(),
    );
  }
}
