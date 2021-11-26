import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final _notesCollection = _firestore.collection('notes');

class NotesService {
  static Stream<QuerySnapshot<Map<String, dynamic>>> getNotes() {
    return _notesCollection.snapshots();
  }

  static Future<void> updateNote({
    required String title,
    required String description,
    required String id,
  }) async {
    DocumentReference note = _notesCollection.doc(id);

    Map<String, dynamic> data = {
      'title': title,
      'description': description,
    };

    await note
        .update(data)
        .whenComplete(() => print('Nota atualizada'))
        .catchError((e) => print(e));
  }

  static Future<void> addNote({
    required String title,
    required String description,
  }) async {
    DocumentReference note = _notesCollection.doc();

    Map<String, dynamic> data = {
      'title': title,
      'description': description,
    };

    await note
        .set(data)
        .whenComplete(() => print('Nota atualizada'))
        .catchError((e) => print(e));
  }

  static Future<void> deleteNote({required String id}) async {
    DocumentReference note = _notesCollection.doc(id);
    await note
        .delete()
        .whenComplete(() => print('Nota removida'))
        .catchError((e) => print(e));
  }
}
