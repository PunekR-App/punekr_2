// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_pay/google_pay.dart';
//
// class Checkout extends StatefulWidget {
//   @override
//   _CheckoutState createState() => _CheckoutState();
// }
//
// class _CheckoutState extends State<Checkout> {
//   String _platformVersion = 'Unknown';
//   String _googlePayToken = 'Unknown';
//
//
//   @override
//   void initState() {
//     super.initState();
//     initPlatformState();
//   }
//
//   Future<void> initPlatformState() async {
//     String platformVersion;
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     try {
//       platformVersion = await GooglePay.platformVersion;
//     } on PlatformException {
//       platformVersion = 'Failed to get platform version.';
//     }
//
//     await GooglePay.initializeGooglePay("pk_test_H5CJvRiPfCrRS44bZJLu46fM00UjQ0vtRN");
//
//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) return;
//
//     setState(() {
//       _platformVersion = platformVersion;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 70.0,
//         title: Text('Checkout'),
//       ),
//       body: StreamBuilder<DocumentSnapshot>(
//         stream: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).snapshots(),
//         builder: (context, snapshot){
//           if(snapshot.hasError){
//             print('Error');
//             return Container();
//           }
//           if(snapshot.connectionState == ConnectionState.waiting){
//             return LinearProgressIndicator();
//           }
//           List<dynamic> cart = snapshot.data.get('cart');
//           print(cart);
//           List<Map<String, dynamic>> products = [];
//
//           return StreamBuilder<QuerySnapshot>(
//             stream: FirebaseFirestore.instance.collectionGroup('products').snapshots(),
//             builder: (context, snapshot){
//               if(snapshot.hasError){
//                 print('Error');
//                 return Container();
//               }
//               if(snapshot.connectionState == ConnectionState.waiting){
//                 return LinearProgressIndicator();
//               }
//               print(snapshot.data.docs);
//               var prods = snapshot.data.docs;
//               Map<String, dynamic> prods_map = {};
//               for(var i in prods){
//                 prods_map.update(i.data()['product_id'], (value) => i.data(), ifAbsent: () => i.data());
//               }
//               print(prods_map);
//               return Center(
//                 child: Container(
//                   height: MediaQuery.of(context).size.height - 200,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Text('Google pay token: $_googlePayToken\n'),
//                       Text('Cart'),
//                       ListView.builder(
//                         shrinkWrap: true,
//                         itemCount: cart.length,
//                         itemBuilder: (context, index){
//                           return ListTile(
//                             title: Text(prods_map[cart[index]['id']]['name']),
//                             trailing: Text(cart[index]['qty'].toString()),
//                           );
//                         },
//                       ),
//                       Text('Pay Now', style: Theme.of(context).textTheme.headline3,),
//                       RaisedButton.icon(
//                         icon: Icon(Icons.payment),
//                         label: Text('GPay'),
//                         color: Colors.blue,
//                         onPressed: onButtonPressed,
//                       )
//                     ],
//                   ),
//                 ),
//               );
//             }
//           );
//         }
//       ),
//     );
//   }
//
//   void onButtonPressed() async{
//     setState((){_googlePayToken = "Fetching";});
//     try {
//       await GooglePay.openGooglePaySetup(
//           price: "5.0",
//           onGooglePaySuccess: onSuccess,
//           onGooglePayFailure: onFailure,
//           onGooglePayCanceled: onCancelled);
//       setState((){_googlePayToken = "Done Fetching";});
//     } on PlatformException catch (ex) {
//       print(ex);
//       setState((){_googlePayToken = "Failed Fetching";});
//     }
//
//   }
//
//   void onSuccess(String token){
//     setState((){_googlePayToken = token;});
//   }
//
//   void onFailure(){
//     setState((){_googlePayToken = "Failure";});
//   }
//
//   void onCancelled(){
//     setState((){_googlePayToken = "Cancelled";});
//   }
//
// }
