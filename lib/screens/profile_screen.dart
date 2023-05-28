import 'dart:io';

import 'package:flutter/material.dart';

import '../db/model/db_model.dart';

class StudentProfile extends StatelessWidget {
  final double profileSize = 160;
  StudentProfile({required this.data, required this.indx, super.key});

  StudentDetiles data;
  final int indx;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          profilepic(),
          content()
        ],
      ),
    );
  }

  Widget content() {
    return Container(
      alignment: Alignment.center,
      width: 500,
      height: 500,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          sizeBox(),
          Text(
            data.name,
            style: TextStyle(fontSize: 30),
          ),
          sizeBox(),
          Text(
            'Place:${data.place}',
            style: TextStyle(fontSize: 30),
          ),
          sizeBox(),
          Text(
            'Age:${data.age}',
            style: TextStyle(fontSize: 30),
          ),
          sizeBox(),
          Text(
            'Number:${data.number}',
            style: TextStyle(fontSize: 30),
          )
        ],
      ),
    );
  }

  Widget profilepic() {
    return Container(
      width: 200,
      height: 200,
      child: CircleAvatar(
        radius: 100,
        backgroundImage: FileImage(
          File(data.image),
        ),
        backgroundColor: Color.fromARGB(255, 10, 121, 141),
      ),
    );
  }

  Widget sizeBox() {
    return SizedBox(
      height: 15,
    );
  }
}
