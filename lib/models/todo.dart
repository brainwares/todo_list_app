import 'package:hive/hive.dart'; // Import Hive untuk penyimpanan lokal

part 'todo.g.dart'; // Menghasilkan file todo.g.dart untuk Hive

@HiveType(typeId: 0) // Menentukan typeId untuk model Todo
class Todo {
  @HiveField(0)
  String task; // Field untuk menyimpan tugas

  @HiveField(1)
  bool completed; // Field untuk menyimpan status selesai

  Todo({required this.task, this.completed = false}); // Constructor untuk inisialisasi task dan status completed
}
