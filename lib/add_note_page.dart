import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../controller/notes_controller.dart';

class AddNotePage extends StatelessWidget {
  AddNotePage({super.key});
  final notesController = Get.find<NotesController>();

  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Note",), backgroundColor: Colors.lightBlue),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: "Title"),
          ),
          TextField(
            controller: _descController,
            maxLines: 4,
            decoration: const InputDecoration(labelText: "Description"),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              // Add the note
              await notesController.addNote(
                _titleController.text.trim(),
                _descController.text.trim(),
              );

              // Show a scaffold message
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Note has been added!"),backgroundColor: Colors.lightGreenAccent,),
              );

              // Redirect to the home page
              GoRouter.of(context).go('/home');
            },
            child: const Text("Save"),
          ),
        ]),
      ),
    );
  }
}
