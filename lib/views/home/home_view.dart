import 'package:aplikasi_5simic1_mobile3/views/home/create_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes App'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.logout_rounded,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: "Search Notes",
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(7)),
            ),
            filled: true,
            fillColor: Colors.teal.withAlpha(25),
            contentPadding: EdgeInsets.only(top: 14),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateView(),
            ),
          );
        },
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
    );
  }
}
