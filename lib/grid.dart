import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:punekr/DisplayVendor.dart';
import 'package:punekr/Pages/PageData.dart';

class Grid extends StatefulWidget {
  final String cname, title, img;

  Grid({Key key, @required this.cname, @required this.title, @required this.img,}) : super(key: key);
  @override
  _GridState createState() => _GridState();
}

class _GridState extends State<Grid> {

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection(widget.cname).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print("error: " + snapshot.error.toString());
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LinearProgressIndicator();
            }
            print(snapshot.data.docs.length);
            return GridView.builder(
              itemCount: snapshot.data.docs.length,
              padding: EdgeInsets.all(5.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, int index) {
                return InkWell(
                    onTap: (){
                      Navigator.push(
                          context,
                          new MaterialPageRoute(builder: (context){
                            return PageData(cname: widget.cname, snapshot: snapshot, index: index);
                          })
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Stack(
                        fit: StackFit.passthrough,
                        children: [
                          Container(
                            // color: Colors.black,
                            padding: EdgeInsets.fromLTRB(30, 90, 0, 0),
                            child: Container(
                              child: Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                                elevation: 10.0,
                                color: Colors.white,
                                // child: Padding(
                                //   padding: EdgeInsets.symmetric(),
                                child: Padding(
                                  padding: EdgeInsets.only(top: 40, bottom: 0.0),
                                  child: Container(
                                    child: Text(
                                      snapshot.data.docs[index][widget.title],
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.headline2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 50, 50),
                            child:
                            Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                              elevation: 8.0,
                              // color: Colors.black,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Image.network(snapshot.data.docs[index][widget.img], fit: BoxFit.fill),

                              ),
                            ),
                          ),
                        ],
                        clipBehavior: Clip.none,
                      ),
                    )
                );
              },
            );
          }
      ),
    );
  }
}



class BCard extends StatefulWidget {
  @override
  _BCardState createState() => _BCardState();
}

class _BCardState extends State<BCard> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('business').where('marketing_type', isEqualTo: 'In-app banner ads').snapshots(),
      builder: (context, snapshot) {
        if(!snapshot.hasData){
          return LinearProgressIndicator();
        }
        return ListView.builder(
          itemCount: snapshot.data.docs.length,
          itemBuilder:(context, index){
            return
                Container(
                  padding: EdgeInsets.all(8.0),
                  // color: Colors.blue,
                  child:  Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                        child: Theme(
                          data: Theme.of(context).copyWith(accentColor: Colors.deepOrange[700]),
                          child: ExpansionTile(
                            title: Text(snapshot.data.docs[index]['name'], textAlign: TextAlign.center,),
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
                                      child: Text(snapshot.data.docs[index]['type'], textAlign: TextAlign.start,),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Location: ' + snapshot.data.docs[index]['location'], textAlign: TextAlign.start,),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Contact: ' + snapshot.data.docs[index]['contact_details'], textAlign: TextAlign.start,),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),


                                      ),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        )
                      ),
                    );
                  },
                );

      });
  }

}


