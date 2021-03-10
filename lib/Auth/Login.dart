import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _phone = new TextEditingController();
  FirebaseAuth fAuth = FirebaseAuth.instance;
  User user;
  @override
  Widget build(BuildContext context) {
    fAuth = FirebaseAuth.instance;
    return Scaffold(
        appBar: AppBar(
          iconTheme: Theme.of(context).iconTheme,
          title: Text(
            'Login',
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        body: Container(
          color: Theme.of(context).iconTheme.color,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.asset('assets/punekr_app_icon.png'),
              ),
              // Text('Login',style: Theme.of(context).textTheme.headline1,),
              SizedBox(
                height: 50.0,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 25.0),
                child: Container(
                  child: TextFormField(
                    style: Theme.of(context).textTheme.button,
                    controller: _phone,
                    keyboardType: TextInputType.number,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'Phone number',
                      hintStyle: TextStyle(color: Colors.white54),
                      suffixIcon: Icon(Icons.phone),
                      focusColor: Colors.deepOrange,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: ListTile(
                  title: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    child: Text('Login', style: Theme.of(context).textTheme.headline3,),
                    onPressed: () async {
                      print(_phone.text);
                      TextEditingController _smsController = TextEditingController();
                      User user;
                      await fAuth.verifyPhoneNumber(
                        phoneNumber: "+91" + _phone.text,
                        verificationCompleted: (credential) async {
                          await fAuth.signInWithCredential(credential).then(
                            (value){
                              user = fAuth.currentUser;
                              String name, add;
                              TextEditingController _name = TextEditingController();
                              TextEditingController _add = TextEditingController();
                              if(value.additionalUserInfo.isNewUser){
                                showDialog(
                                  context: context,
                                  builder: (context){
                                    return Center(
                                      child: Dialog(
                                        child: Column(
                                          children: [
                                            Text('Enter Name', style: Theme.of(context).textTheme.headline3,),
                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                                              child: TextFormField(
                                                controller: _name,
                                                autofocus: true,
                                              ),
                                            ),
                                            RaisedButton(
                                              child: Text('Next'),
                                              onPressed: (){
                                                if(_name.text.isNotEmpty){
                                                  name = _name.text;
                                                  Navigator.pop(context);
                                                }
                                              },
                                            )
                                          ],
                                        ),
                                      )
                                    );
                                  }
                                ).then((value) {
                                  print('name: ' + name);
                                  showDialog(
                                    context: context,
                                    builder: (context){
                                      return Center(
                                        child: Dialog(
                                          child: Column(
                                            children: [
                                              Text('Enter Address', style: Theme.of(context).textTheme.headline3),
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 15.0),
                                                child: TextFormField(
                                                  controller: _add,
                                                  autofocus: true,
                                                ),
                                              ),
                                              RaisedButton(
                                                child: Text('Submit'),
                                                onPressed: (){
                                                  if(_add.text.isNotEmpty){
                                                    add = _add.text;
                                                    Navigator.pop(context);
                                                  }
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                  ).then((value) {
                                    print(add);
                                    Map<String, dynamic> newUser = {
                                      'phone': user.phoneNumber,
                                      'uid': user.uid,
                                      'name': name,
                                      'add': add
                                    };
                                    print(newUser);
                                    FirebaseFirestore.instance.collection('users').doc(user.uid).set(newUser);
                                  });
                                });
                              }
                            }
                          );
                          Navigator.pop(context);
                        },
                        verificationFailed: (e){
                          print(e.message);
                        },
                        codeSent: (String verificationId, int resendToken){

                        },
                        timeout: Duration(seconds: 20),
                        codeAutoRetrievalTimeout: (verificationId){
                          showDialog(
                            context: context,
                            builder: (context){
                              return Center(
                                child: Dialog(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text('Enter OTP'),
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: TextFormField(
                                            controller: _smsController,
                                            maxLength: 6,
                                            keyboardType: TextInputType.number,
                                          ),
                                        ),
                                        RaisedButton(
                                          child: Text('Submit'),
                                          onPressed: ()async{
                                            if(_smsController.text != null){
                                              PhoneAuthCredential credential = PhoneAuthProvider.credential(
                                                  verificationId: verificationId,
                                                  smsCode: _smsController.text
                                              );
                                              await fAuth.signInWithCredential(credential).then(
                                                      (value){
                                                    user = value.user;
                                                    Navigator.pop(context);
                                                    user = fAuth.currentUser;
                                                    String name, add;
                                                    bool firstTime = value.additionalUserInfo.isNewUser;
                                                    print(firstTime);
                                                    TextEditingController _name = TextEditingController();
                                                    TextEditingController _add = TextEditingController();
                                                    if(firstTime){
                                                      showDialog(
                                                          context: context,
                                                          builder: (context){
                                                            return Dialog(
                                                                child: Column(
                                                                  children: [
                                                                    TextFormField(
                                                                      controller: _name,
                                                                      keyboardType: TextInputType.text,

                                                                    ),
                                                                    FlatButton(
                                                                      child: Text('Submit'),
                                                                      onPressed: (){
                                                                        Navigator.pop(context);
                                                                        name = _name.text;
                                                                      },
                                                                    )
                                                                  ],
                                                                )
                                                            );
                                                          }
                                                      ).then((value) {
                                                        print(name);
                                                        showDialog(
                                                            context: context,
                                                            builder: (context){
                                                              return Dialog(
                                                                  child: Column(
                                                                    children: [
                                                                      TextFormField(
                                                                        controller: _add,
                                                                        keyboardType: TextInputType.text,
                                                                      ),
                                                                      FlatButton(
                                                                        child: Text('Submit'),
                                                                        onPressed: (){
                                                                          Navigator.pop(context);
                                                                          add = _add.text;
                                                                        },
                                                                      )
                                                                    ],
                                                                  )
                                                              );
                                                            }
                                                        ).then((value) {
                                                          print(add);
                                                          Map<String, dynamic> newUser = {
                                                            'phone': user.phoneNumber,
                                                            'uid': user.uid,
                                                            'name': name,
                                                            'add': add
                                                          };
                                                          print(newUser);
                                                          FirebaseFirestore.instance.collection('users').doc(user.uid).set(newUser);
                                                        });
                                                      });
                                                    }
                                                    Navigator.pop(context);
                                                  },
                                                  onError: (error){
                                                    print(error);
                                                  }
                                              );
                                            }
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }  ,
                          );
                        }
                      );
                      if(fAuth.currentUser != null){
                        print('Logged In');
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }

  Future<String> getName(BuildContext context) {
    TextEditingController _name = TextEditingController();
    String name;
    showDialog(
      context: context,
      builder: (context){
        return Dialog(
            child: Column(
              children: [
                TextFormField(
                  controller: _name,
                  keyboardType: TextInputType.text,

                ),
                FlatButton(
                  child: Text('Submit'),
                  onPressed: (){
                    Navigator.pop(context);
                    return _name.text;
                  },
                )
              ],
            )
        );
      }
    ).then((value) => name = value);
    return Future.value(name);
  }

  Future<String> getAdd(BuildContext context) {
    TextEditingController _add = TextEditingController();
    String add;
    showDialog(
      context: context,
      builder: (context) {
        return  Dialog(
            child: Column(
              children: [
                TextFormField(
                  controller: _add,
                  keyboardType: TextInputType.text,
                ),
                FlatButton(
                  child: Text('Submit'),
                  onPressed: (){
                    Navigator.pop(context);
                    return _add.text;
                  },
                )
              ],
            )
        );
      }
    ).then((value) => add = value);
    return Future.value(add);
  }
}

class Password extends StatefulWidget {

  @override
  _PasswordState createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  bool _obscureText = true;

  String password;

  void toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {

    return TextField(
      obscureText: _obscureText,
      decoration: InputDecoration(
        hintText: 'Password',
        suffixIcon: IconButton(
          icon: Icon(Icons.visibility_off),
          onPressed: () {
            toggle();
          },
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }
}

