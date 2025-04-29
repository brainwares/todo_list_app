import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/todo_list_screen.dart'; // Import file todo.dart

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Memastikan binding widget sudah diinisialisasi
  await Hive.initFlutter(); // Inisialisasi Hive
  await Hive.openBox('todos'); // Membuka box untuk menyimpan to-do
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TodoListScreen(), // Halaman utama
      debugShowCheckedModeBanner: false,
    );
  }
}