import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class NotesController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxList<Map<String, dynamic>> notesList = <Map<String, dynamic>>[].obs;

  final titleController = ''.obs;
  final descController = ''.obs;

  Future<void> fetchNotes() async {
    final user = _auth.currentUser;
    if (user == null) return;

    final notesSnapshot = await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('notes')
        .orderBy('createdAt', descending: true)
        .get();

    notesList.value =
        notesSnapshot.docs.map((doc) => doc.data()).toList();
  }

  Future<void> addNote(String title, String description) async {
    final user = _auth.currentUser;
    if (user == null) return;

    await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('notes')
        .add({
      'title': title,
      'description': description,
      'createdAt': FieldValue.serverTimestamp(),
    });

    await fetchNotes(); // refresh notes
  }
}
