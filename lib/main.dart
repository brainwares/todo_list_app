import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/todo.dart'; // Import model Todo
import 'screens/todo_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Memastikan binding widget sudah diinisialisasi
  await Hive.initFlutter(); // Inisialisasi Hive

  // Tutup box jika sudah terbuka sebelumnya
  if (Hive.isBoxOpen('todos')) {
    await Hive.box('todos').close();
  }

  Hive.registerAdapter(TodoAdapter()); // Mendaftarkan adapter untuk model Todo
  await Hive.openBox<Todo>('todos'); // Membuka box untuk menyimpan to-do
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