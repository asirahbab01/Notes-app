import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/notes_controller.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final notesController = Get.put(NotesController());

  @override
  Widget build(BuildContext context) {
    notesController.fetchNotes(); // Initial fetch

    return Scaffold(
      appBar: AppBar(title: const Text("Your's Notes"), backgroundColor: Colors.lightBlueAccent),

      body: Obx(() {
        if (notesController.notesList.isEmpty) {
          return const Center(child: Text("No notes found."));
        }
        return ListView.builder(
          itemCount: notesController.notesList.length,
          itemBuilder: (context, index) {
            final note = notesController.notesList[index];
            return Card(
              child: ListTile(
                title: Text(note['title'] ?? ''),
                subtitle: Text(note['description'] ?? ''),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to AddNotePage
          GoRouter.of(context).go('/add_note');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
