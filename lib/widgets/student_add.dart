import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_student_data_base/db/db_functions/functions.dart';
import 'package:my_student_data_base/db/model/db_model.dart';
import 'package:my_student_data_base/screens/home_screen.dart';
import 'package:my_student_data_base/screens/student_home.dart';

class StudentAddWidget extends StatefulWidget {
  const StudentAddWidget({super.key});

  @override
  State<StudentAddWidget> createState() => _StudentAddWidgetState();
}

class _StudentAddWidgetState extends State<StudentAddWidget> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _placeController = TextEditingController();
  final _numberController = TextEditingController();
  String? imagePath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Student'),
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            CircleAvatar(
              backgroundColor: Color.fromARGB(255, 10, 121, 141),
              backgroundImage: imagePath == null
                  ? NetworkImage(
                          'https://thumbs.dreamstime.com/z/default-avatar-profile-icon-vector-unknown-social-media-user-photo-default-avatar-profile-icon-vector-unknown-social-media-user-184816085.jpg')
                      as ImageProvider
                  : FileImage(File(imagePath!)),
              radius: 60,
            ),
            IconButton(
                onPressed: () {
                  takePhoto();
                },
                icon: Icon(Icons.camera_alt)),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                        hintText: 'Name',
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10)),
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: Icon(
                          Icons.abc,
                          color: Color.fromARGB(255, 20, 136, 82),
                        )),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    controller: _placeController,
                    decoration: InputDecoration(
                        hintText: 'Place',
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10)),
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: Icon(
                          Icons.abc,
                          color: Color.fromARGB(255, 20, 136, 82),
                        )),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    controller: _ageController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10)),
                        hintText: 'Age',
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: Icon(
                          Icons.numbers,
                          color: Color.fromARGB(255, 20, 136, 82),
                        )),
                    keyboardType: TextInputType.number,
                    maxLength: 2,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _numberController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10)),
                        hintText: 'Phone Number',
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: Icon(
                          Icons.phone_android,
                          color: Color.fromARGB(255, 20, 136, 82),
                        )),
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            ElevatedButton.icon(
                onPressed: () {
                  if (
                      //imagepath != null &&
                      _nameController.text.isNotEmpty &&
                          _ageController.text.isNotEmpty &&
                          _numberController.text.isNotEmpty &&
                          _placeController.text.isNotEmpty) {
                    // studentAddSnackBar();

                    onAddStudentButtonClicked(context);
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (ctx) => const HomeScreen()),
                        (route) => false);
                  } else {
                    showSnackBar();
                  }
                },
                icon: Icon(Icons.add),
                label: Text('Add Student'))
          ],
        ),
      )),
    );
  }

  Future<void> takePhoto() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
      });
    }
  }

  Future<void> onAddStudentButtonClicked(BuildContext context) async {
    final _name = _nameController.text.trim();
    final _age = _ageController.text.trim();
    final _place = _placeController.text.trim();
    final _number = _numberController.text.trim();

    if (_name.isEmpty ||
        _age.isEmpty ||
        _place.isEmpty ||
        _number.isEmpty ||
        imagePath == null) {
      return;
    }

    final student = StudentDetiles(
      name: _name,
      place: _place,
      age: _age,
      number: _number,
      image: imagePath!,
    );

    addStudent(student).then((val) => studentAddSnackBar());
  }

  showSnackBar() {
    var _errMsg = "";

    if (imagePath == null &&
        _nameController.text.isEmpty &&
        _ageController.text.isEmpty &&
        _numberController.text.isEmpty) {
      _errMsg = "Please Insert Valid Data In All Fields ";
    } else if (imagePath == null) {
      _errMsg = "please choose profile pic to Continue";
    } else if (_placeController.text.isEmpty) {
      _errMsg = "Please enter the place to Continue";
    } else if (_nameController.text.isEmpty) {
      _errMsg = "Name  Must Be Filled";
    } else if (_ageController.text.isEmpty) {
      _errMsg = "Age  Must Be Filled";
    } else if (_numberController.text.isEmpty) {
      _errMsg = "Phone Number Must Be Filled";
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        margin: const EdgeInsets.all(10.0),
        content: Text(_errMsg),
      ),
    );
  }

  void studentAddSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.teal,
        content: Text('This Student Inserted Into Database'),
      ),
    );
  }
}
