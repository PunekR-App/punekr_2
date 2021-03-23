import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DisplayProducts extends StatefulWidget {
  final String vendor_name;
  final AsyncSnapshot<QuerySnapshot> snapshot;
  //final int index;

  DisplayProducts({Key key,
    @required this.vendor_name,
    @required this.snapshot,
    //@required this.index,

  }) : super(key: key);

  @override
  _DisplayProductsState createState() => _DisplayProductsState();
}

class _DisplayProductsState extends State<DisplayProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
        iconTheme: Theme
            .of(context)
            .iconTheme,
        backgroundColor: Colors.white,
      ),
      body: data(context, widget.vendor_name, widget.snapshot),

    );
  }
}

Widget data(BuildContext context, String vendor_name,
    AsyncSnapshot<QuerySnapshot> snapshot) {
  //return StreamBuilder<QuerySnapshot>(
    //      stream: FirebaseFirestore.instance.collection("product_details").where('vendor_name',isEqualTo: vendor_name)
             // .snapshots(),
      //    builder: (context, snapshot) {
        //    if (snapshot.hasError) {
         //     print("error: " + snapshot.error.toString());
          //  }
           // if (snapshot.connectionState == ConnectionState.waiting) {
            //  return LinearProgressIndicator();
            //}
           // print(snapshot.data.docs.length);
            return GridView.builder(
                itemCount: snapshot.data.docs.length,
                padding: EdgeInsets.all(5.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context,int index) {
                  return Container(
                        child:Text("Product:"+snapshot.data.docs[index]['product_name'],style: Theme.of(context).textTheme.headline3,
                    textAlign: TextAlign.center,)
                  );
                }
            );
          }
     // );
