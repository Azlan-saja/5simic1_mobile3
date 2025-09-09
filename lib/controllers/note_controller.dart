import 'package:aplikasi_5simic1_mobile3/database/database_helper.dart';
import 'package:aplikasi_5simic1_mobile3/models/note_model.dart';
import 'package:flutter/material.dart';

class NoteController {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final db = DatabaseHelper();
  late Future<List<NoteModel>> notes;

  String? cekValidator(String? value, {required String label}) {
    if (value!.isEmpty) {
      return '$label wajib diisi';
    }
    return null;
  }

  void createData(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    try {
      int result = await db.createNote(
        NoteModel(
          noteTitle: titleController.text,
          noteContent: contentController.text,
          createdAt: DateTime.now().toIso8601String(),
        ),
      );
      if (result > 0) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Simpan Berhasil.'),
            backgroundColor: Colors.teal[400],
            behavior: SnackBarBehavior.floating,
          ),
        );
        Navigator.pop(context);
      } else {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Gagal Simpan Data.'),
            backgroundColor: Colors.red[400],
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error kawan. $e'),
          backgroundColor: Colors.red[400],
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
