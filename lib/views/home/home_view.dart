import 'package:aplikasi_5simic1_mobile3/controllers/note_controller.dart';
import 'package:aplikasi_5simic1_mobile3/views/home/create_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final noteController = NoteController();

  @override
  void initState() {
    super.initState();
    noteController.notes = noteController.db.getNotes();
  }

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
        child: Column(
          children: [
            TextFormField(
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
            Expanded(
              child: FutureBuilder(
                future: noteController.notes,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Gagal Tampil Data. Error ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text('Data Kosong. '),
                    );
                  } else {
                    // return Text('Oke Ada Data');
                    final items = snapshot.data!;
                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return Text(items[index].noteTitle);
                      },
                    );
                  }
                },
              ),
            ),
          ],
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
