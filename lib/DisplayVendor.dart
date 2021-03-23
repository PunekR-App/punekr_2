import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:punekr/DisplayProducts.dart';

class DisplayProd extends StatefulWidget {
  final String vendor_name;

  DisplayProd({Key key, @required this.vendor_name }) : super(key: key);
  @override
  _DisplayProdState createState() => _DisplayProdState();
}

class _DisplayProdState extends State<DisplayProd> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LinearProgressIndicator();
          }
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(8.0),
                // color: Colors.blue,
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(accentColor: Colors.deepOrange[700]),
                      child: ExpansionTile(
                        title: Text(
                          snapshot.data.docs[index]['vendor_name'],
                          textAlign: TextAlign.center,
                        ),
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width - 8.0,
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisSize: ,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Products:' +
                                        snapshot.data.docs[index]
                                            ['product_names'],
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Contact no: ' +
                                        snapshot.data.docs[index]['contact_no'],
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextButton(
                                    child: Text(
                                      'View Products',
                                    ),
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context){
                                            return DisplayProducts(vendor_name:widget.vendor_name, snapshot: snapshot);
                                          }));
                                    }
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              );
            },
          );
        });
  }
}


