import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  final FirebaseAuth fAuth = FirebaseAuth.instance;
  final User user = FirebaseAuth.instance.currentUser;
  String soap;
  List<String> soaps;
  List<int> flavor_qty;
  String prod_id;
  int index, count, item_qty;

  Cart({Key key,
    this.prod_id,
    this.soaps,
    this.flavor_qty,
    this.index,
    this.count,
    this.item_qty,
    this.soap,
  }) : super(key : key);


  void pushToCart() async {
    print('Hello yaar');
    String soap_name;
    int qty;
    List<Map<String, dynamic>> cart = [];
    print(item_qty);
    Map<String, dynamic> prod = {
      'id': prod_id,
      'qty': item_qty,
      'flavors': {}
    };
    print(prod);
    Map<String, dynamic> flavors = {};

    if(prod_id.substring(0,2) == "00") {
      for(var i = 0; i < soaps.length; i++) {
        soap_name = soaps[i];
        qty = flavor_qty[i];
        if(qty != 0) {
          flavors.putIfAbsent(soap_name, () => qty);
        }
      }
      prod['flavors'] = flavors;
    }

    print(prod);
    Map<String, dynamic> userdata = new Map<String, dynamic>();
    await FirebaseFirestore.instance.collection('users').doc(user.uid).get().then((value) => userdata = value.data());
    if(userdata['cart'] != null) {
      for(var i in userdata['cart']){
        cart.add(i);
      }
    }
    cart.add(prod);
    print('Cart');
    print(cart);
    userdata.update('cart', (value) => cart, ifAbsent: () => cart);
    print(userdata);
    print(cart);
    FirebaseFirestore.instance.collection('users').doc(user.uid).set(userdata);
  }

  void showSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true, // set this to true
        builder: (_) {
          return DraggableScrollableSheet(
              expand: false,
              builder: (_, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance.collection('users').doc(user.uid).snapshots(),
                    builder: (context, snapshot) {
                      if(snapshot.hasError){
                        return Center(
                            child: Container(
                              child: Text(snapshot.error.toString()),
                            )
                        );
                      }
                      // print(snapshot.data.data()['cart'].length);
                      return Expanded(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              controller: controller,
                              itemCount: snapshot.data.data()['cart'].length,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width - 10.0,
                                  height: 120,
                                  child: Card(
                                    child: Text(snapshot.data['cart'][index].toString()),
                                  ),
                                );
                              }
                          ),
                      );
                    },
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height/10,
                      padding: EdgeInsets.all(8.0),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                        color: Colors.deepOrange[700],
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Checkout'),
                        ),
                        onPressed: () {
                          // print('Cart: ');
                          // print(cart);
                        }
                      ),
                  ),
                ],
              );
            },
          );
        },
      );
    }
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    // print(widget.cart);
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').doc(widget.user.uid).snapshots(),
        builder: (context, snapshot){
          print(widget.user.uid);
          return Container();
        },
      ),
    );
  }
}
