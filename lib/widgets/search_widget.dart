import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_student_data_base/db/model/db_model.dart';
import 'package:my_student_data_base/screens/home_screen.dart';
import 'package:my_student_data_base/screens/profile_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  List<StudentDetiles> studentsList =
      Hive.box<StudentDetiles>('student_db').values.toList();
  late List<StudentDetiles> students = List<StudentDetiles>.from(studentsList);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextFormField(
              controller: _searchController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                    onPressed: () {
                      if (_searchController.text.isEmpty) {
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (context) {
                          return HomeScreen();
                        }), (route) => false);
                      } else {
                        _searchController.clear();
                      }
                    },
                    icon: Icon(Icons.clear)),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(50)),
                hintText: 'search',
              ),
              onChanged: (value) {
                searchStudent(value.trim());
              },
            ),
            Expanded(
                child: students.isNotEmpty
                    ? ListView.builder(
                        itemCount: students.length,
                        itemBuilder: (context, index) {
                          File img = File(students[index].image);
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: FileImage(img),
                            ),
                            title: Text(students[index].name),
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return StudentProfile(
                                    data: students[index], indx: index);
                              }));
                            },
                          );
                        })
                    : Center(
                        child: Text('No Match Found'),
                      ))
          ],
        ),
      )),
    );
  }

  void searchStudent(String value) {
    setState(() {
      students = studentsList
          .where((element) =>
              element.name.toLowerCase().startsWith(value.toLowerCase().trim()))
          .toList();
    });
  }
}
