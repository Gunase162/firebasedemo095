import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasedemo/services/auth_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Register by Firestore Database'),
      ),
      body: ListView(
        children: [
          taxt(),
          name(),
          email(),
          password(),
          submit(),
        ],
      ),
    );
  }

  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  Future<void> addUser() {
    return users
        .add({
          'Name': _name.text,
          'Email': _email.text,
          'Password': _password.text,
        })
        .then((value) => print("Data has been successfully"))
        .catchError((error) => print("Failed to add data: $error"));
  }

  Container taxt() {
    return Container(
      margin: EdgeInsets.only(top: 40),
      alignment: Alignment.center,
      child:  Text(
        'Register',
      ),
    );
  }

  Container submit() {
    return Container(
      margin:  EdgeInsets.fromLTRB(0, 20, 0, 10),
      padding:  EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        onPressed: () {
          registerWithEmail(_email.text, _password.text);
          addUser();
        },
        child:  Text(
          "Register",
          style: TextStyle(fontSize: 18),
        ),
        style: ElevatedButton.styleFrom(
          fixedSize:  Size(150, 50),
        ),
      ),
    );
  }

  Container password() {
    return Container(
      margin:  EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: TextFormField(
        controller: _password,
        obscureText: true,
        decoration: InputDecoration(
         ),  
      ),
    );
  }

  Container email() {
    return Container(
      margin:  EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: TextFormField(
        controller: _email,
        decoration: InputDecoration(
         ),  
      ),
    );
  }

  Container name() {
    return Container(
      margin:  EdgeInsets.fromLTRB(20, 40, 20, 0),
      child: TextFormField(
        controller: _name,
        decoration: InputDecoration(
         ),  
      ),
    );
  }
}