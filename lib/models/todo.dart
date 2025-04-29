import 'package:hive/hive.dart'; // Import Hive untuk penyimpanan lokal

part 'todo.g.dart'; // Menghasilkan file todo.g.dart untuk Hive

class Todo {
  @HiveField(0)
  String task; // Field untuk menyimpan tugas

  @HiveField(1)
  bool completed; // Field untuk menyimpan status selesai

  Todo({required this.task, this.completed = false}); // Constructor untuk inisialisasi task dan status completed
}
class Todo{
  String task;
  bool completed;

  Todo({required this.task, this.completed = false}); // Constructor untuk inisialisasi task dan status completed

  Map<String, dynamic> toMap() {
    return {
      'task': task, // Mengembalikan task sebagai map
      'completed': completed, // Mengembalikan status completed sebagai map
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      task: map['task'], // Mengambil task dari map
      completed: map['completed'] ?? false, // Mengambil status completed dari map
    );
  }
}