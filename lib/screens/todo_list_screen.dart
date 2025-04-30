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
  final List<Todo> _todos = [];
  final TextEditingController _todoController = TextEditingController(); // Tambahkan ini
  final Box _todoBox = Hive.box<Todo>('todos'); // Mengakses box Hive untuk menyimpan to-do

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  void _loadTodos() {
    _todos.clear();
    _todos.addAll(_todoBox.values.cast<Todo>());
    setState(() {});
  }

  void _addTodo() {
    if (_todoController.text.isNotEmpty) {
      final newTodo = Todo(task: _todoController.text);
      _todoBox.add(newTodo);
      _loadTodos();
      _todoController.clear();
    }
  }

  void _deleteTodo(int index) {
    _todoBox.deleteAt(index);
    _loadTodos();
  }

  void _toggleTodo(int index, bool? value) {
    final todo = _todos[index];
    todo.completed = value ?? false;
    _todoBox.putAt(index, todo);
    _loadTodos();
  }

  @override
  void dispose() {
    _todoController.dispose(); // Jangan lupa dispose controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('To-Do List')),
      body: Column(
        children: [
          // Input Box
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _todoController, // Controller dihubungkan di sini
                    decoration: const InputDecoration(
                      hintText: 'Masukkan tugas baru...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _addTodo(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addTodo,
                ),
              ],
            ),
          ),
          // List
          Expanded(
            child: ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                final todo = _todos[index];
                return TodoItem(
                  todo: todo,
                  onDelete: () => _deleteTodo(index),
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