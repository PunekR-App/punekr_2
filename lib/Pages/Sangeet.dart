import 'package:flutter/material.dart';
import 'package:punekr/grid.dart';

class Sangeet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 70.0,
          iconTheme: IconThemeData(color: Colors.deepOrange),
          title: Text(
            'Sangeet',
            style: Theme.of(context).textTheme.headline1,
          ),
          backgroundColor: Colors.white,
        ),
      body: Grid(cname: "sangeet", title: "title", img: "img"),

    );
  }
}


