import 'package:flutter/material.dart';

class CreateView extends StatelessWidget {
  const CreateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Note'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.check,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.line_weight_sharp),
                hintText: "Title",
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                ),
                filled: true,
                fillColor: Colors.teal.withAlpha(25),
                contentPadding: EdgeInsets.only(top: 14),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              maxLines: 4,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.line_weight_sharp),
                hintText: "Content",
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                ),
                filled: true,
                fillColor: Colors.teal.withAlpha(25),
                contentPadding: EdgeInsets.only(top: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
