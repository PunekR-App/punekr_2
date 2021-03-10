import 'package:flutter/material.dart';
import 'package:punekr/grid.dart';

class Places extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70.0,
        iconTheme: Theme.of(context).iconTheme,
        title: Text(
          'Tourism',
          style: Theme.of(context).textTheme.headline1,
        ),
        backgroundColor: Colors.white,
      ),
      body: Grid(cname: "places_to_visit", title: "title", img: "img1"),
    );
  }
}


