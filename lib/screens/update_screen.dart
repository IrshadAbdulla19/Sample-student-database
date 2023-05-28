import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_student_data_base/db/db_functions/functions.dart';
import 'package:my_student_data_base/db/model/db_model.dart';
import 'package:my_student_data_base/screens/home_screen.dart';

class UpdateScreen extends StatefulWidget {
  final int index;
  const UpdateScreen({super.key, required this.index});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  late TextEditingController _idController;
  late TextEditingController _nameController;
  late TextEditingController _placeController;
  late TextEditingController _ageController;
  late TextEditingController _numberController;

  int id = 0;
  String? name;
  String? place;
  String? imagePath;
  int age = 0;
  int number = 0;
  late Box<StudentDetiles> studentBox;
  late StudentDetiles student;

  @override
  void initState() {
    super.initState();
    studentBox = Hive.box('student_db');
    _idController = TextEditingController();
    _nameController = TextEditingController();
    _placeController = TextEditingController();
    _ageController = TextEditingController();
    _numberController = TextEditingController();
    student = studentBox.getAt(widget.index) as StudentDetiles;
    _idController.text = student.id.toString();
    _nameController.text = student.name.toString();
    _placeController.text = student.place.toString();
    _ageController.text = student.age.toString();
    _numberController.text = student.number.toString();
  }

  Future<void> StudentAddBtn(int index) async {
    final _name = _nameController.text.trim();
    final _age = _ageController.text.trim();
    final _number = _numberController.text.trim();
    final _place = _placeController.text.trim();
    final _image = imagePath;

    if (_name.isEmpty || _place.isEmpty || _age.isEmpty || _number.isEmpty) {
      return;
    }

    final _students = StudentDetiles(
      name: _name,
      image: imagePath ?? student.image,
      place: _place,
      age: _age,
      number: _number,
    );
    final studentDataB = await Hive.openBox<StudentDetiles>('student_db');
    studentDataB.putAt(index, _students);
    getStudents();
  }

  Future<void> takePhoto() async {
    // ignore: non_constant_identifier_names
    final PickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (PickedFile != null) {
      setState(() {
        imagePath = PickedFile.path;
      });
    }
  }

  Widget profilepic() {
    return Container(
      width: 300,
      height: 200,
      alignment: Alignment.center,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue,
            backgroundImage: imagePath == null
                ? FileImage(File(student.image))
                : FileImage(File(imagePath ?? student.image)),
            radius: 70,
          ),
          IconButton(
              onPressed: () {
                takePhoto();
              },
              icon: Icon(Icons.camera_alt))
        ],
      ),
    );
  }

  Widget elavatedbtn() {
    return ElevatedButton.icon(
      onPressed: () {
        StudentAddBtn(widget.index).then((value) => updateSnackBar());

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (ctx) => const HomeScreen()),
            (route) => false);
      },
      icon: const Icon(Icons.update_rounded),
      label: const Text('Update'),
    );
  }

  Widget textFieldName({
    required TextEditingController myController,
    required String hintName,
  }) {
    return TextFormField(
      controller: myController,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        suffixIcon: const Icon(
          Icons.abc,
          color: Colors.teal,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: hintName,
      ),
    );
  }

  Widget textFieldplace({
    required TextEditingController myController,
    required String hintName,
  }) {
    return TextFormField(
      controller: myController,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        suffixIcon: const Icon(
          Icons.abc,
          color: Colors.teal,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: hintName,
      ),
    );
  }

  Widget textFieldAge({
    required TextEditingController myController,
    required String hintName,
  }) {
    return TextFormField(
      controller: myController,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        suffixIcon: const Icon(
          Icons.abc,
          color: Colors.teal,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: hintName,
      ),
      keyboardType: TextInputType.number,
      maxLength: 2,
    );
  }

  Widget textFieldphnNum({
    required TextEditingController myController,
    required String hintName,
  }) {
    return TextFormField(
      controller: myController,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        suffixIcon: const Icon(
          Icons.abc,
          color: Colors.teal,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: hintName,
      ),
      keyboardType: TextInputType.number,
      maxLength: 10,
    );
  }

  Widget szdBox = const SizedBox(height: 20);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_circle_left_sharp,
            size: 40,
          ),
          onPressed: () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (ctx) => const HomeScreen()),
              (route) => false),
        ),
        title: const Text('Edit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            profilepic(),
            szdBox,
            textFieldName(
              myController: _nameController,
              hintName: student.name,
            ),
            szdBox,
            textFieldplace(
                myController: _placeController, hintName: student.place),
            szdBox,
            textFieldAge(myController: _ageController, hintName: student.age),
            szdBox,
            textFieldphnNum(
                myController: _numberController, hintName: student.number),
            szdBox,
            elavatedbtn(),
          ]),
        ),
      ),
    );
  }

  void updateSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.teal,
        content: Text('Details Updated'),
      ),
    );
  }
}
