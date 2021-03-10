import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:punekr/Auth/Login.dart';
import 'package:punekr/Home.dart';
import 'package:punekr/Pages/Diwali.dart';
import 'package:punekr/Pages/Local.dart';
import 'package:punekr/Pages/Parks.dart';
import 'package:punekr/Pages/Places.dart';
import 'package:punekr/Pages/Play.dart';
import 'package:punekr/Pages/Sangeet.dart';
import 'package:punekr/Pages/Temples.dart';


void main() {
  runApp(FirebaseInit());
}

class FirebaseInit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder:(context, snapshot){
          if(snapshot.hasError){
            print(snapshot.error.toString());
            return Center(child:Text('Error', textDirection: TextDirection.ltr,));
          }

          if(snapshot.connectionState == ConnectionState.done) {
            print('Connection OK');
            return MaterialApp(
              title: 'PunekR',
              home: Home(),
              routes: {
                '/auth/login': (context) => Login(),
                '/plays': (context) => Play(),
                '/sangeet': (context) => Sangeet(),
                '/temples': (context) => Temples(),
                '/local': (context) => Local(),
                '/parks': (context) => Parks(),
                '/places': (context) => Places(),
                '/diwali': (context) => Diwali(),
              },
              theme: ThemeData(
                primaryColor: Colors.white,
                fontFamily: 'PT_Serif',
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Color(0xFFFF6200)
                ),
                appBarTheme: AppBarTheme(
                  color: Colors.white,
                  iconTheme: IconThemeData(color: Color(0xFFFF6200)),
                  textTheme:  TextTheme(
                    headline6: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFFF6200),
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                iconTheme: IconThemeData(color: Color(0xFFFF6200)),
                textTheme: TextTheme(
                  headline1: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFFF6200),
                    fontFamily: 'Poppins',
                  ),
                  headline2: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFFF6200),
                    fontFamily: 'Poppins',
                  ),
                  headline3: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFFF6200),
                    fontFamily: 'Poppins',
                  ),
                  bodyText1: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFFF6200),
                    fontFamily: 'PT_Serif',
                  ),
                  bodyText2: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontFamily: 'PT_Serif',
                  ),
                  button: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  )
                ),
              ),
            );
          }
          return Center(child: Text('Loading', textDirection: TextDirection.ltr,));
        }
    );
  }
}
