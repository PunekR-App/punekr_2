import 'package:flutter/material.dart';
import 'package:punekr/grid.dart';

class Temples extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70.0,
        iconTheme: IconThemeData(color: Colors.deepOrange),
        title: Text(
          'Temples',
          style: Theme.of(context).textTheme.headline1,
        ),
        backgroundColor: Colors.white,
      ),
      body: Grid(cname: "temples", title: "title", img: "img1"),
    );
  }
}


