import 'package:flutter/material.dart';
import 'package:punekr/grid.dart';

class Local extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Local', style: Theme.of(context).textTheme.headline1,),
        toolbarHeight: 70.0,
      ),
      body: BCard(),
    );
  }
}
