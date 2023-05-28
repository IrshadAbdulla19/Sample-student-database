import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_student_data_base/db/db_functions/functions.dart';
import 'package:my_student_data_base/db/model/db_model.dart';
import 'package:my_student_data_base/screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StudentDetilesAdapter().typeId)) {
    Hive.registerAdapter(StudentDetilesAdapter());
  }
  await Hive.openBox<StudentDetiles>('student_db');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: HomeScreen(),
    );
  }
}
