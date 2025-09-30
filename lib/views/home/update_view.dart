import 'package:aplikasi_5simic1_mobile3/controllers/note_controller.dart';
import 'package:aplikasi_5simic1_mobile3/models/note_model.dart';
import 'package:flutter/material.dart';

class UpdateView extends StatelessWidget {
  final NoteModel note;

  const UpdateView({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    final noteController = NoteController();
    noteController.titleUpdateController =
        TextEditingController(text: note.noteTitle);
    noteController.contenUpdatetController =
        TextEditingController(text: note.noteContent);

    return Scaffold(
      appBar: AppBar(
        title: Text('Update Note'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () => noteController.updateData(
              context,
              noteId: note.noteId!,
            ),
            icon: Icon(
              Icons.check,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: noteController.formKeyUpdate,
          child: Column(
            children: [
              TextFormField(
                validator: (value) =>
                    noteController.cekValidator(value, label: 'Title'),
                controller: noteController.titleUpdateController,
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
                validator: (value) =>
                    noteController.cekValidator(value, label: 'Content'),
                controller: noteController.contenUpdatetController,
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
      ),
    );
  }
}
