import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  FirebaseAuth fAuth = FirebaseAuth.instance;
  User user;
  @override
  Widget build(BuildContext context) {
    user = fAuth.currentUser;
    String name, add;
    TextEditingController _name = TextEditingController();
    TextEditingController _add = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        toolbarHeight: 70.0,
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Name'),
          TextFormField(
            controller: _name,
          ),
          Text('Address'),
          TextFormField(
            controller: _add,
          ),
          RaisedButton(
            child: Text('Submit'),
            onPressed: (){
              if(_name.text.isNotEmpty && _add.text.isNotEmpty){
                name = _name.text;
                add = _add.text;
                Map<String, dynamic> newUser = {
                  'phone': user.phoneNumber,
                  'uid': user.uid,
                  'name': name,
                  'add': add
                };
                print(newUser);
                FirebaseFirestore.instance.collection('users').doc(user.uid).set(newUser);
                Navigator.popUntil(context, (route) => route.isFirst);
              }
            },
          )
        ],
      ),
    );
  }
}
