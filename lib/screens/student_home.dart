import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:my_student_data_base/db/db_functions/functions.dart';
import 'package:my_student_data_base/widgets/student_list.dart';

class StudentHome extends StatelessWidget {
  const StudentHome({super.key});

  @override
  Widget build(BuildContext context) {
    getStudents();
    return Scaffold(
      body: StudentListWidget(),
    );
  }
}
