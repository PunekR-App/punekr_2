import 'package:flutter/material.dart';
import 'package:punekr/DisplayVendor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class products extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(children: [
      Center(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('product_details')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot ds = snapshot.data.docs[index];
                      return ShopItem(
                        product_name: ds['product_name'],
                        vendor_name: ds['vendor_name'],
                        product_id: ds['product_id'],
                        price: ds['price'],
                        description: ds['description'],
                       // product_img: ds['product_img'],
                      );
                    }
                );
              }
                      )
      )
                        ]
                        )

                      );

  }
}
class ShopItem extends StatelessWidget {
  final String product_name;
  final String vendor_name;
  final String product_id;
  final String price;
  final String description;
  final String product_img;

  ShopItem({
    this.product_name,
    this.vendor_name,
    this.product_id,
    this.price,
    this.description,
    this.product_img,
  });

  @override
  Widget build(BuildContext context) {

    return Column( children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              child:Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
//                                width: 360,
                      height: 400.0,

                      child:AspectRatio(
                        aspectRatio: 16 / 9,

                      ),
                    ),
                  )],

              ),


            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: Container(
                height: 40,
                width: 40,
                //child: NetworkImage(product_img),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 60,
              child: Container(
                child: Text(product_name,style: TextStyle(color: Colors.white,fontWeight:FontWeight.bold),),

              ),
            ),


            Container(
              alignment: Alignment.bottomRight,
              child:  Container(
                alignment: Alignment.bottomRight,
                //child: GFButton(
                  //onPressed: () => showProduct(context) ,
                 // text: "More",
                  //icon: Icon(Icons.card_travel),
                  //shape: GFButtonShape.pills,

                ),
              ),
           // ),

          ],

        ),
        Row(
          children: <Widget>[
            Container(
              child: Text(description,style: TextStyle(color: Colors.red,fontSize: 30.0,fontWeight:FontWeight.bold),),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Container(  child: Text('₹',style: TextStyle(color: Colors.red,)),
            ),
            Container(
              child: Text(price,style: TextStyle(color: Colors.red,fontSize: 20.0,fontWeight:FontWeight.bold),),
            ),

          ],
        ),
        Divider(color: Colors.red,),
      ],

      );

  }
}
