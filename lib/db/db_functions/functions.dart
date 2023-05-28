import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_student_data_base/db/model/db_model.dart';

ValueNotifier<List<StudentDetiles>> studentListNoti = ValueNotifier([]);

Future<void> getStudents() async {
  final studentdb = await Hive.openBox<StudentDetiles>('student_db');
  studentListNoti.value.clear();
  // studentListNoti.value.addAll(studentdb.values);
  studentdb.addAll(studentdb.values);
  studentListNoti.notifyListeners();
}

Future<void> addStudent(StudentDetiles value) async {
  final studentdb = await Hive.openBox<StudentDetiles>('student_db');
  final _id = await studentdb.add(value);
  value.id = _id;
  getStudents();
  studentListNoti.value.add(value);
  studentListNoti.notifyListeners();
}

Future<void> deleteStudent(int id) async {
  final studentdb = await Hive.openBox<StudentDetiles>('student_db');
  studentdb.deleteAt(id);
  getStudents();
}
