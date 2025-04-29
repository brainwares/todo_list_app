import 'package:flutter/material.dart';
import '../models/todo.dart'; // Import file todo.dart

class TodoItem extends StatelessWidget {
  final Todo todo;
  final Function() onDelete; // Fungsi untuk menghapus to-do
  final Function(bool?) onToggle; // Fungsi untuk menandai to-do sebagai selesai atau belum selesai

  const TodoItem({
    super.key,
    required this.todo,
    required this.onDelete,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: todo.completed,
        onChanged: onToggle, // Fungsi untuk menandai to-do saat checkbox ditekan
      ),
      title: Text(
        todo.task,
        style: TextStyle(
          decoration: todo.completed ? TextDecoration.lineThrough : null, // Menandai teks sebagai dicoret jika sudah selesai
        ),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete), // Ikon untuk menghapus to-do
        onPressed: onDelete, // Fungsi untuk menghapus to-do saat ikon ditekan
      ),
    );
  }
}