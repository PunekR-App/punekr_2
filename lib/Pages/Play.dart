import 'package:flutter/material.dart';
import 'package:punekr/grid.dart';

class Play extends StatefulWidget {
  @override
  _PlayState createState() => _PlayState();
}

class _PlayState extends State<Play> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70.0,
        iconTheme: IconThemeData(color: Colors.deepOrange),
        title: Text(
          'Plays',
          style: Theme.of(context).textTheme.headline1,
        ),

        backgroundColor: Colors.white,
      ),

      // body: (),
      body: Grid(cname: "plays", title: "title", img: "img"),


    );
  }
}

