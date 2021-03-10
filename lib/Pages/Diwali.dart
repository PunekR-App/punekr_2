import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:punekr/Pages/Cart.dart';
import 'package:punekr/Prod.dart';

class Diwali extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.shopping_cart_outlined,
                  size: 30.0,),
        onPressed: () => Cart().showSheet(context),
      ),
      appBar: AppBar(
        title: Text('Diwali'),
        toolbarHeight: 70.0,
      ),
      body: DiwaliShops(),
    );
  }
}

class DiwaliShops extends StatefulWidget {
  @override
  _DiwaliShopsState createState() => _DiwaliShopsState();
}

class _DiwaliShopsState extends State<DiwaliShops> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('business').where('marketing_type', isEqualTo: 'ecommerce').snapshots(),
          builder: (context, snapshot) {
            if(!snapshot.hasData){
              return LinearProgressIndicator();
            }
            return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(builder: (context) {
                            return Scaffold(
                              floatingActionButton: FloatingActionButton(
                                child: Icon(Icons.shopping_cart_outlined,
                                  size: 30.0,),
                                onPressed: () => Cart().showSheet(context),
                              ),
                              appBar: AppBar(
                                title: Text(snapshot.data.docs[index]['name'],),
                                toolbarHeight: 70.0,
                              ),
                              body: Products(snapshot: snapshot, index: index),
                            );
                          })
                      );
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * (1/3),
                      child: Stack(
                        fit: StackFit.passthrough,
                        children: [
                          Container(
                            // color: CupertinoColors.black,
                            padding: EdgeInsets.fromLTRB(10.0, 25.0, 10.0, 0),
                            width: MediaQuery.of(context).size.width,
                            height: 150,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.network(snapshot.data.docs[index]['banner_img']),
                            ),
                          ),
                          Positioned(
                            bottom: -20,
                            child: Container(
                              height: MediaQuery.of(context).size.height * (1/8),
                              width: MediaQuery.of(context).size.width,
                              // color: Colors.black,
                              padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
                              child: Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                elevation: 10.0,
                                color: Colors.white,
                                // child: Padding(
                                //   padding: EdgeInsets.symmetric(),
                                child: Padding(
                                  padding: EdgeInsets.only(top: 20.0, ),
                                  child: Text(
                                    snapshot.data.docs[index]['name'],
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.headline1
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                        clipBehavior: Clip.none,
                      ),
                    ),
                  );
                }
            );
          }
      ),
    );
  }
}


class Products extends StatefulWidget {
  final String shop_name;
  final AsyncSnapshot<QuerySnapshot> snapshot;
final int index;

  Products({Key key,
    this.shop_name,
    @required this.snapshot,
    @required this.index,

  }) : super (key: key);

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: widget.snapshot.data.docs[widget.index].reference.collection('products').snapshots(),
      builder: (context, snapshot) {
        if(snapshot.hasError){
          print(snapshot.error.toString());
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return CircularProgressIndicator();
        }
        // if(snapshot.data.docs[widget.index]['image'] == ""){
        return ListView.builder(
          scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
            print(index);
            if(index != 6){
              return Container(
                  padding: EdgeInsets.all(5.0),
                  width: MediaQuery.of(context).size.width/2 - 10.0,
                  // height: MediaQuery.of(context).size.height * (1/5),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
                  child: Card(
                    child: Theme(
                      data: Theme.of(context).copyWith(accentColor: Colors.deepOrange[700]),
                      child: ExpansionTile(
                        leading: Image.network(snapshot.data.docs[index]['image']),
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 30.0,
                              child: Text(snapshot.data.docs[index]['name'], style: TextStyle(fontSize: 16.0),),
                            ),
                            SizedBox(
                              height: 20.0,
                              child: Text(snapshot.data.docs[index]['price'].toString(), style: TextStyle(fontSize: 16.0),),
                            )
                          ],
                        ),
                        children: [
                          InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      print(snapshot.data.docs[index]['product_id'].toString().substring(0,2));
                                    if(snapshot.data.docs[index]['product_id'].toString().substring(0,2) == "00" )
                                    {
                                      return Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: MediaQuery.of(context).size.height/3,
                                        child: AlertDialog(
                                          content: Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              Positioned(
                                                  top: -40,
                                                  right: -40,
                                                  child: InkResponse(
                                                    onTap: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: CircleAvatar(
                                                      child: Icon(Icons.close),
                                                      backgroundColor: Colors.black,
                                                    ),
                                                  )),
                                              MyList(snapshot: snapshot, index: index,),
                                            ],
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: MediaQuery.of(context).size.height/3,
                                        child: AlertDialog(
                                          content: Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              Positioned(
                                                  top: -40,
                                                  right: -40,
                                                  child: InkResponse(
                                                    onTap: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: CircleAvatar(
                                                      child: Icon(Icons.close),
                                                      backgroundColor: Colors.black,
                                                    ),
                                                  )),
                                              Prod(shop_id: snapshot.data.docs[index]['product_id'].toString().substring(0,2), snapshot: snapshot, index: index,),
                                            ],
                                          ),
                                        ),
                                      );

                                    }
                                   }
                                );
                              },

                            child: Container(
                              padding: EdgeInsets.all(16.0),
                              width: MediaQuery.of(context).size.width - 16.0,
                              // height: MediaQuery.of(context).size.height / 3,
                              // alignment: ,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Products: '),
                                  Container(
                                    width: MediaQuery.of(context).size.width - 10.0,
                                    // height: MediaQuery.of(context).size.height / 4,
                                    child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: snapshot.data.docs[index]['products'].length,
                                      itemBuilder: (context, index1){
                                        return Text(snapshot.data.docs[index]['products'][index1]);
                                      }),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                // ),
              );
            }
            return Container();
          }
        );
      }
    );
  }
}

class Qty extends StatefulWidget {
  String soap;
  List<String> soaps;
  List<int> flavor_qty;
  String prod_id;
  int index, count, item_qty;
  User user = FirebaseAuth.instance.currentUser;

  Qty({Key key,
    this.prod_id,
    this.soaps,
    this.flavor_qty,
    this.index,
    this.count,
    this.item_qty,
    this.soap,
  }) : super(key : key);


  @override
  _QtyState createState() => _QtyState();
}

class _QtyState extends State<Qty> {

  @override
  void initState(){
    super.initState();
    widget.item_qty = 1;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.item_qty);
    if(widget.prod_id.substring(0,2) == "00"){
      return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          child: Text('  -  '),
          onTap: () {
            if(widget.flavor_qty[widget.index] != 0) {
              setState(() {
                widget.flavor_qty[widget.index] = widget.flavor_qty[widget.index] - 1;
              });
            }else{
              return null;
            }
          },
        ),
        Text(widget.flavor_qty[widget.index].toString()),
        InkWell(
          child: Text('  +  '),
          onTap: () {
            int sum = 0;
            for (var i = 0; i < widget.flavor_qty.length; i++) {
              sum = sum + widget.flavor_qty[i];
            }
            if (sum == widget.count) {
              return null;
            }
            else{
              setState(() {
                widget.flavor_qty[widget.index] = widget.flavor_qty[widget.index] + 1;
              });
              print(widget.flavor_qty);
            }
          },
        ),
      ],
    );
    } else {
      print(widget.item_qty);
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            child: Text('  -  '),
            onTap: () {
              if(widget.item_qty != 0) {
                setState(() {
                  widget.item_qty = widget.item_qty - 1;
                });
              } else {
                return null;
              }
            },
          ),
          Text(widget.item_qty.toString()),
          InkWell(
            child: Text('  +  '),
            onTap: () {
              setState(() {
                widget.item_qty = widget.item_qty + 1;
              });
              // print(widget.flavor_qty);
            },
          ),
        ],
      );
    }
  }
}

