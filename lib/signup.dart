import 'package:face_recognition/face-recog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpWidget extends StatefulWidget {
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUpWidget> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController nameTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController confirmPasswordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                    controller: nameTextController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Full Name',
                      hintText: 'Enter Your Full Name',
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
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    controller: confirmPasswordTextController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Confirm Password',
                      hintText: 'Enter Confirm Password',
                    ),
                  ),
                ),
                Row(children: [
                  Padding(
                      padding: EdgeInsets.all(15),
                      child: MaterialButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    child: Text('Sign In'),
                    onPressed: (){
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => FaceRecogView()));
                      Navigator.pop(context);
                    },
                  )
                  ),
                  Padding(
                      padding: EdgeInsets.all(15),
                      child: MaterialButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    child: Text('Sign Up'),
                    onPressed: () async {
                      try {
                        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: emailTextController.text,
                            password: passwordTextController.text
                        );
                        Navigator.push(context, MaterialPageRoute(builder: (context) => FaceRecogView(
                            {
                              "type": "authentication",
                              "user": credential.user,
                              "name": nameTextController.text
                            }
                        )));
                      } on FirebaseAuthException catch (e) {
                        final scaffold = ScaffoldMessenger.of(context);
                        if (e.code == 'weak-password') {
                          scaffold.showSnackBar(SnackBar(content: const Text('The password provided is too weak.')));
                        } else if (e.code == 'email-already-in-use') {
                          scaffold.showSnackBar(SnackBar(content: const Text('The account already exists for that email.')));
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                  )
                  )
                ],)
              ],
            )
        )
    );
  }
}