import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:my_student_data_base/screens/student_home.dart';
import 'package:my_student_data_base/widgets/student_add.dart';
import 'package:my_student_data_base/widgets/student_list.dart';

import '../db/db_functions/functions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  final screen = [StudentHome(), StudentAddWidget()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[index],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Color.fromARGB(255, 2, 104, 53),
          unselectedItemColor: Color.fromARGB(255, 5, 160, 108),
          currentIndex: index,
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
              ),
              label: 'View Students ',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
              ),
              label: 'Add Student',
            ),
          ]),
    );
  }
}
