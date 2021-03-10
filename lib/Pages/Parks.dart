import 'package:flutter/material.dart';
import 'package:punekr/grid.dart';

class Parks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70.0,
        iconTheme: IconThemeData(color: Colors.deepOrange),
        title: Text(
          'Parks',
          style:  Theme.of(context).textTheme.headline1,
        ),
      ),
      body: Grid(cname: "parks", title: "title", img: "img1"),
    );
  }
}


