import 'package:aplikasi_5simic1_mobile3/database/database_helper.dart';
import 'package:aplikasi_5simic1_mobile3/models/note_model.dart';
import 'package:aplikasi_5simic1_mobile3/views/home/home_view.dart';
import 'package:flutter/material.dart';

class NoteController {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final db = DatabaseHelper();
  late List<NoteModel> notes;

  late TextEditingController titleUpdateController;
  late TextEditingController contenUpdatetController;
  final formKeyUpdate = GlobalKey<FormState>();

  final searchController = TextEditingController();

  Future<List<NoteModel>> getData() async {
    if (searchController.text.isNotEmpty) {
      notes = await db.searchNotes(searchController.text);
    } else {
      notes = await db.getNotes();
    }
    return notes;
  }

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
        Navigator.pop(context, 'OKE');
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

  void updateData(BuildContext context, {required int noteId}) async {
    if (!formKeyUpdate.currentState!.validate()) return;
    // Proses Update
    try {
      int result = await db.updateNote(
        titleUpdateController.text,
        contenUpdatetController.text,
        noteId,
      );

      if (result > 0) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Perubahan Berhasil disimpan.'),
            backgroundColor: Colors.teal[400],
            behavior: SnackBarBehavior.floating,
          ),
        );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeView()),
          (route) => false,
        );
      } else {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Gagal Update Data.'),
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

  Future<bool> deleteData(BuildContext context, {required int noteId}) async {
    // PORSES DELETE
    int result = await db.deleteNote(noteId);
    if (result > 0) {
      await getData();
      if (!context.mounted) return true;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Note deleted successfully!'),
          backgroundColor: Colors.teal[400],
          behavior: SnackBarBehavior.floating,
        ),
      );
      return true;
    } else {
      if (!context.mounted) return false;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to delete note. Please try again.'),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return false;
    }
  }
}
