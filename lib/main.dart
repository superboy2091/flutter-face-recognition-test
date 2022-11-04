import 'package:face_recognition/attendace.dart';
import 'package:face_recognition/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'face-recog.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    themeMode: ThemeMode.light,
    theme: ThemeData(brightness: Brightness.light),
    home: MyApp(),
    title: "Face Recognition",
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MyApp> {

  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Attendance App'),
        ),
        body: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    controller: emailTextController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Enter Your Email Address',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    controller: passwordTextController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter Password',
                    ),
                  ),
                ),
                Row(children: [
                  Padding(
                      padding: EdgeInsets.all(15),
                      child: MaterialButton(
                        textColor: Colors.white,
                        color: Colors.blue,
                        child: Text('Sign In/Attend'),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => FaceRecogView(
                              {
                                "type": "attendance"
                              }
                          )));
                        },
                      )
                  ),
                  Padding(padding: EdgeInsets.all(15),
                    child: MaterialButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Sign Up'),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpWidget()));
                      },
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(15),
                    child: MaterialButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Today'),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AttendanceWidget()));
                      },
                    ),
                  )
                ],)
              ],
            )
        )
    );
  }
}