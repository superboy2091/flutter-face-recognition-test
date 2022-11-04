import 'dart:convert';

import 'package:face_recognition/face-recog.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AttendanceWidget extends StatefulWidget {
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<AttendanceWidget> {
  dynamic items = [];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance App'),
      ),
      body: FutureBuilder(
          future: FirebaseDatabase.instance
              .ref('attendance/' +
                  DateTime.now().year.toString() +
                  "_" +
                  DateTime.now().month.toString() +
                  "_" +
                  DateTime.now().day.toString() + "/")
              .once(),
          builder: (context, event) {
            event.data?.snapshot.children.forEach((child) {
              dynamic user = child.value;
              this.items.add(user);
            });
            print(json.encode(this.items));
            return ListView.builder(
                itemCount: this.items.length,
                itemBuilder: (_, int index) {
                  print(this.items[index]["name"]);
                  print(this.items[index]["time"]);
                  return ListTile(
                      title: Text(this.items[index]["name"]),
                      subtitle: Text(this.items[index]["time"])
                  );
                });
          }),
    );
  }
}
