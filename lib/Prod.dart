import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:punekr/Pages/Cart.dart';
import 'package:punekr/Pages/Diwali.dart';

class MyList extends StatefulWidget {
  final AsyncSnapshot<QuerySnapshot> snapshot;
  final int index;

  MyList({Key key,
    @required this.snapshot,
    @required this.index,
  }) : super (key: key);

  @override
  _MyListState createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  int item_count, prod_qty = 1;
  List<int> item_qty = List<int>.filled(10, 0);
  var orders = new Map<String, int>();
  List<int> flag = List<int>.filled(15, 0);
  String selectedSoap;

  @override
  Widget build(BuildContext context) {
    print('ruko');
    print(widget.index);
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('business').doc(
          '6wxEVEKwqYxswJUGoaQ0').collection('products').snapshots(),
      builder: (context, snapshot) {
        if(snapshot.hasError){
          return Center(
              child: Container(
                child: Text(snapshot.error.toString()),
              )
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        List<String> soaps = List.from(snapshot.data.docs[6]['soaps']);
        print(soaps);
        int choice = widget.snapshot.data.docs[widget.index]['choice'];
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: Text('Select any ' + choice.toString() + ' soap(s)'),
            ),
            SingleChildScrollView(
              child: Container(
                // padding: EdgeInsets.all(5.0),
                height: MediaQuery
                    .of(context)
                    .size
                    .height * (3 / 4),
                width: MediaQuery
                    .of(context)
                    .size
                    .width * (3 / 4),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: soaps.length,
                    itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            // color: Colors.deepOrange[700],
                            border: Border.all(
                                color: Colors.deepOrange[700], width: 1.0),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * (1 / 9),
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * (2 / 3),
                          child: Center(
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              title: Text(soaps[index]),
                              trailing: Container(
                                margin: EdgeInsets.all(8.0),
                                // color: Colors.black,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 5,
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height / 7.5,
                                child: Qty(
                                  prod_id: snapshot.data.docs[widget.index]['product_id'],
                                  soaps: soaps,
                                  flavor_qty: item_qty,
                                  index: index,
                                  count: widget.snapshot.data.docs[widget
                                      .index]['choice'],),
                              ),
                            ),
                          ), // ),
                        );
                    }
                ),
              ),
            ),


            Container(
              margin: EdgeInsets.all(3.0),
              width: MediaQuery
                  .of(context)
                  .size
                  .width * (3 / 4),
              height: MediaQuery
                  .of(context)
                  .size
                  .height * (1 / 15),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: RaisedButton(
                  shape: StadiumBorder(),
                  color: Colors.deepOrange[700],
                  child: Text(
                    'Add to Cart', style: TextStyle(color: Colors.white),),
                  onPressed: () {
                    if (FirebaseAuth.instance.currentUser == null) {
                      Navigator.pushNamed(context, '/auth/login');
                    } else {
                      Cart(prod_id: snapshot.data.docs[widget.index]['product_id'],soaps: soaps, index: widget.index, flavor_qty: item_qty, item_qty: prod_qty,).pushToCart();
                      Cart().showSheet(context);
                    }
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}


class Prod extends StatefulWidget {
  int index;
  AsyncSnapshot<QuerySnapshot> snapshot;
  String shop_id;

  Prod({Key key,
    @required this.index,
    @required this.snapshot,
    @required this.shop_id,
  }) : super (key: key);

  @override
  _ProdState createState() => _ProdState();
}

class _ProdState extends State<Prod> {
  @override
  Widget build(BuildContext context) {
    String productId = widget.snapshot.data.docs[widget.index]['product_id'];
    print(productId);
      return Column(
        mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
         Container(
              height: MediaQuery.of(context).size.height * (3 / 4),
              width: MediaQuery.of(context).size.width * (3 / 4),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.network(widget.snapshot.data.docs[widget.index]['image']),
                    ),
                    Container(
                      // height: 120,
                      padding: EdgeInsets.all(16.0),
                      child: Text(widget.snapshot.data.docs[widget.index]['name'], style: TextStyle(fontSize: 20.0),),
                    ),
                    Container(
                      // height: 120,
                      margin: EdgeInsets.all(16.0),
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Price', style: TextStyle(fontSize: 20.0, color: Colors.deepOrange[700])),
                          Text(widget.snapshot.data.docs[widget.index]['price'], style: TextStyle(fontSize: 20.0)),
                        ],
                      )
                    ),
                    Row(
                      children: [
                        Text('Qty'),
                        Qty(prod_id: productId,),
                      ],
                    )
                  ],
                ),
              ),

            ),

          Container(
            margin: EdgeInsets.all(3.0),
            width: MediaQuery
                .of(context)
                .size
                .width * (3 / 4),
            height: MediaQuery
                .of(context)
                .size
                .height * (1 / 11),
            child: RaisedButton(
              shape: StadiumBorder(),
              color: Colors.deepOrange[700],
              child: Text(
                'Add to Cart', style: TextStyle(color: Colors.white),),
              onPressed: () {
                if (FirebaseAuth.instance.currentUser == null) {
                  Navigator.pushNamed(context, '/auth/login');
                } else {
                  // Qty(item_qty: item_qty,);
                  Cart(prod_id: productId).pushToCart();
                  Cart().showSheet(context);
                }
              },
            ),
          ),
        ],
      );
    // },
    // ) ;
  }
}
