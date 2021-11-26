// Tela com a listView com a lista de notas
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/services/notes_service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static const String id = 'main_screen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    // print(_auth.currentUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: const Text('Chat geral'),
        backgroundColor: Colors.red,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: NotesService.getNotes(),
                builder: (context, snapshot) {
                  List<NoteTile> noteList = [];

                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final notes = snapshot.data!.docs;
                  for (var note in notes) {
                    final String title = note.data()['title'];
                    final String subtitle = note.data()['description'];
                    final String id = note.id;
                    noteList.add(NoteTile(
                      title: title,
                      subtitle: subtitle,
                      id: id,
                    ));
                  }

                  return Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 20.0),
                      children: noteList,
                    ),
                  );
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          // Navigator.pushNamed(context, AddNotesScreen.id);
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}

class NoteTile extends StatelessWidget {
  const NoteTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.id,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        onTap: () {
          // Navigator.pushNamed(context, EditNotesScreen.id,
          //     arguments: EditNotesScreenArguments(
          //       title: title,
          //       description: subtitle,
          //       noteId: id,
          //     ));
        },
        onLongPress: () {
          NotesService.deleteNote(id: id);
        },
        title: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          subtitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        tileColor: Colors.red[100],
      ),
    );
  }
}
