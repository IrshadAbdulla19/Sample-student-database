import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:my_student_data_base/db/model/db_model.dart';
import 'package:my_student_data_base/screens/profile_screen.dart';
import 'package:my_student_data_base/screens/update_screen.dart';
import 'package:my_student_data_base/widgets/search_widget.dart';

import '../db/db_functions/functions.dart';

class StudentListWidget extends StatefulWidget {
  const StudentListWidget({super.key});

  @override
  State<StudentListWidget> createState() => _StudentListWidgetState();
}

class _StudentListWidgetState extends State<StudentListWidget> {
  late Box<StudentDetiles> studentBox;

  @override
  void initState() {
    // studentBox = Hive.box('student_db');
    super.initState();
    studentBox = Hive.box('student_db');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Student List'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (contx) {
                  return SearchScreen();
                }));
              },
              icon: Icon(Icons.search))
        ],
      ),
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.all(10),
              child: ValueListenableBuilder(
                valueListenable: studentListNoti,
                builder: (BuildContext cntx, List<StudentDetiles> studentList,
                    Widget? child) {
                  return ListView.separated(
                      itemBuilder: (cntx, index) {
                        final data = studentList[index];

                        return ListTile(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (ctx) {
                              return StudentProfile(
                                data: data,
                                indx: index,
                              );
                            }));
                          },
                          trailing: FittedBox(
                            fit: BoxFit.fill,
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => UpdateScreen(
                                            index: index,
                                          ),
                                          // UpdateStudent(index: index),
                                        ));
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.teal,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      deleteStudentAlert(context, index);
                                    },
                                    icon: const Icon(
                                      Icons.delete_forever,
                                      color: Colors.red,
                                    ))
                              ],
                            ),
                          ),
                          leading: CircleAvatar(
                            backgroundColor: Colors.teal[300],
                            backgroundImage: FileImage(File(data.image)),
                          ),
                          title: Text(data.name),
                        );
                      },
                      separatorBuilder: (cntx, index) {
                        return Divider();
                      },
                      itemCount: studentList.length);
                },
              ))),
    );
  }

  deleteStudentAlert(BuildContext context, index) {
    showDialog(
      context: context,
      builder: ((ctx) => AlertDialog(
            content: const Text('Really Want To Delete ?'),
            actions: [
              TextButton(
                onPressed: () {
                  deleteStudent(index).then((value) => deleteAlert());

                  Navigator.of(context).pop(ctx);
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(ctx),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          )),
    );
  }

  void deleteAlert() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.teal,
        content: Text('Student Deleted From database'),
      ),
    );
  }
}
