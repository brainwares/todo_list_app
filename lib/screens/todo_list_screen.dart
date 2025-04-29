import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/todo.dart'; // Import file todo.dart
import '../widgets/todo_item.dart'; // Import file todo_item.dart  

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final Box _todoBox = Hive.box('todos'); // Membuka box untuk menyimpan to-do
  List<Todo> _todos = []; // Daftar untuk menyimpan to-do

  @override
  void initState() {
    super.initState();
    _loadTodos(); // Memuat to-do saat halaman diinisialisasi
  }

  void _loadTodos() {
    _todos = _todoBox.values.map((item) => item as Todo).toList();
    setState(() {});
  }
  void _addTodo() {
    if (_todoController.text.isNotEmpty) {
      final newTodo = Todo(task: _todoController.text); // Membuat to-do baru
      _todoBox.add(newTodo); // Menambahkan to-do baru ke box
      _loadTodos();
      _todoController.clear(); // Mengosongi TextField setelah menambahkan to-do
    }
  }

  // Hapus tugas
  void _deleteTodo(int index) {
    _todoBox.deleteAt(index); // Menghapus to-do berdasarkan indeks
    _loadTodos(); // Memuat ulang to-do setelah dihapus
  }

  void _toggleTodo(int index, bool? value) {
    final todo = _todos[index]; // Mengambil to-do berdasarkan indeks
    todo.completed = value ?? false; // Mengubah status selesai
    _todoBox.putAt(index, todo); // Memperbarui to-do di box
    _loadTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'), // Judul aplikasi
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _todoController, // Menghubungkan kontroler dengan TextField
                    decoration: const InputDecoration(
                      hintText: 'Masukkan tugas baru', // Placeholder untuk input
                      border: OutlineInputBorder(), // Gaya border untuk TextField
                    ),
                    onSubmitted: (_) => _addTodo(), // Menambahkan to-do saat tombol enter ditekan
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add), // Ikon untuk menambahkan to-do
                  onPressed: _addTodo, // Fungsi untuk menambahkan to-do saat ditekan
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _todos.length, // Jumlah to-do yang ditampilkan
              itemBuilder: (context, index) {
                final todo = _todos[index]; // Mengambil to-do berdasarkan indeks
                return TodoItem(
                  todo: todo,
                  onDelete: () => _deleteTodo(index), // Fungsi untuk menghapus to-do
                  onToggle: (value) => _toggleTodo(index, value),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}