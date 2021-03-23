import 'package:flutter/material.dart';
import 'package:punekr/DisplayVendor.dart';
import 'package:punekr/grid.dart';

class Local extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(
        //title: Text('Local', style: Theme.of(context).textTheme.headline1,),
        //toolbarHeight: 70.0,
      //),
      body: DefaultTabController(
       length:2,
       child: Scaffold(
         appBar: AppBar(
             title: Text('Local', style: Theme.of(context).textTheme.headline1,),
             toolbarHeight: 100.0,
           bottom: TabBar(
             tabs: [
               Tab(text:"Services"),
               Tab(text: "Products"),
             ],
             indicatorColor:Color(0xFFFF6600),
           ),

         ),
           body:TabBarView(children: [BCard(),
             DisplayProd()],
           )
        )
       ),
      );//BCard(),
  }
}
