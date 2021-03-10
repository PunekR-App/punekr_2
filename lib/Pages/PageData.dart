import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PageData extends StatefulWidget {
  final String cname;
  final AsyncSnapshot<QuerySnapshot> snapshot;
  final int index;

  PageData({Key key,
    @required this.cname,
    @required this.snapshot,
    @required this.index,

  }) : super(key: key);
  @override
  _PageDataState createState() => _PageDataState();
}

class _PageDataState extends State<PageData> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Colors.white,
      ),
      body: getPageData(context, widget.cname, widget.snapshot, widget.index),
      floatingActionButton: widget.cname == 'plays'?FloatingActionButton(
        child: Icon(Icons.play_circle_fill),
        onPressed: (){
          natakLauncher(widget.snapshot, widget.index);
        },
      ): null

    );
  }

  natakLauncher(AsyncSnapshot<QuerySnapshot> snapshot, int index) async{
    if(await canLaunch(snapshot.data.docs[index].data()['url'])){
      await launch(snapshot.data.docs[index].data()['url']);
    }
  }
}

Widget getPageData(BuildContext context, String cname, AsyncSnapshot<QuerySnapshot> snapshot, int index){
    if(cname == "plays") {
      return Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      fit: StackFit.passthrough,
                      children: [
                        Container(
                          margin: EdgeInsets.all(12.0),
                          constraints: BoxConstraints(maxWidth: 280),
                          width: 280,
                          height: 300,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image.network(snapshot.data.docs[index]['img'], fit: BoxFit.fill),
                          ),
                        ),
                        Positioned(
                          bottom: -25,
                          left: 25,
                          right: 25,
                          child:
                          Container(
                            constraints: BoxConstraints(maxWidth: double.infinity),
                            height: 50,
                            width: 200,
                            child: Material(
                              elevation: 8.0,
                              shape: StadiumBorder(),
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.all(9.0),
                                child: Center(
                                  child: Text(snapshot.data.docs[index]['title'],
                                    style: Theme.of(context).textTheme.headline3,
                                    textAlign: TextAlign.center,),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                      clipBehavior: Clip.none,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      constraints: BoxConstraints(maxWidth: double.infinity),
                      height: 80,
                      width: 220,
                      child: Card(
                        elevation: 8.0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 12.0),
                              child: Text(
                                'Genre: ' + snapshot.data.docs[index]['genre'],
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(left: 12.0),
                              child: Text(
                                'Language: ' + snapshot.data.docs[index]['language'],
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]
                ),
                Container(
                  margin: EdgeInsets.all(12.0),
                  constraints: BoxConstraints(maxWidth: double.infinity),
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                    elevation: 8.0,
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        snapshot.data.docs[index]['about'],
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else if(cname == "sangeet"){
      List<dynamic> urls = snapshot.data.docs[index].data()['videos'];
      List<YoutubePlayerController> _controllers = urls.map((url) {
        return YoutubePlayerController(
          initialVideoId: YoutubePlayer.convertUrlToId(url),
          flags: YoutubePlayerFlags(
            autoPlay: false,
            mute:false,
            disableDragSeek: true,
          ),
        );
      }).toList();
      print(urls);
      return ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: urls.length + 1,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, i){
          if(i == 0){
            return Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0, bottom: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    fit: StackFit.passthrough,
                    children: [
                      Container(
                        margin: EdgeInsets.all(12.0),
                        constraints: BoxConstraints(maxWidth: 280),
                        width: 280,
                        height: 300,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image.network(snapshot.data.docs[index].data()['img'], fit: BoxFit.fill),
                        ),
                      ),
                      Positioned(
                        bottom: -20,
                        left: 20,
                        right: 20,
                        child:
                        Container(
                          height: 50,
                          width: 200,
                          child: Material(
                            elevation: 8.0,
                            shape: StadiumBorder(),
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 15.0),
                              child: Text(snapshot.data.docs[index].data()['title'],
                                style: Theme.of(context).textTheme.headline3,
                                textAlign: TextAlign.center,),
                            ),
                          ),
                        ),
                      ),
                    ],
                    clipBehavior: Clip.none,
                  ),
                ],
              ),
            );
          } else if(i == 1){
            return Divider(
              height: 50.0,
              indent: MediaQuery.of(context).size.width * 0.3,
              endIndent: MediaQuery.of(context).size.width * 0.3,
              color: Theme.of(context).iconTheme.color,
            );
          } else {
            i -=2;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
              child: YoutubePlayerBuilder(
                player: YoutubePlayer(
                  controller: _controllers[i],
                  liveUIColor: Colors.amber,
                  progressIndicatorColor: Theme.of(context).iconTheme.color,
                  progressColors: ProgressBarColors(
                      backgroundColor: Colors.black,
                      bufferedColor: Colors.white,
                      playedColor: Theme.of(context).iconTheme.color,
                      handleColor: Theme.of(context).iconTheme.color
                  ),
                  topActions: [
                    IconButton(
                      icon: Icon(Icons.launch),
                      color: Colors.white,
                      onPressed: () async{
                        var url = urls[i];
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      }
                    ),
                  ],
                  width: MediaQuery.of(context).size.width,
                ),
                builder: (context, player){
                  return Column(
                    children: [
                      player,
                    ],
                  );
                },
              ),
            );
          }
        },
      );

              //   Container(
              //     margin: EdgeInsets.only(top: 30),
              //     child: RaisedButton.icon(
              //       elevation: 7.0,
              //       color: Colors.deepOrange[700],
              //       shape: StadiumBorder(),
              //       icon: Icon(Icons.play_arrow, color: Colors.white,),
              //       label: Text(
              //         '  Watch now',
              //         style: Theme.of(context).textTheme.button,
              //       ),
              //       onPressed: () async {
              //         if (await canLaunch(snapshot.data.docs[index]['url'])) {
              //           await launch(snapshot.data.docs[index]['url']);
              //         } else {
              //           throw 'Could not launch';
              //         }
              //       },
              //     ),
              //   ),


    } else if (cname == "temples" || cname == "parks" || cname == "places_to_visit"){
      return Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(maxWidth: double.infinity),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      fit: StackFit.passthrough,
                      children: [
                        Container(
                          margin: EdgeInsets.all(12.0),
                          constraints: BoxConstraints(maxWidth: 280),
                          width: 280,
                          height: 300,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image.network(snapshot.data.docs[index]['img1'], fit: BoxFit.fill),
                          ),
                        ),
                        Positioned(
                          bottom: -20,
                          left: 20,
                          right: 20,
                          child:
                          Container(
                            height: 50,
                            width: 200,
                            child: Material(
                              elevation: 8.0,
                              shape: StadiumBorder(),
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.all(9.0),
                                child: Text(snapshot.data.docs[index]['title'],
                                  style: Theme.of(context).textTheme.headline3,
                                  textAlign: TextAlign.center,),
                              ),
                            ),
                          ),
                        ),
                      ],
                      clipBehavior: Clip.none,
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 30, left: 10.0, right: 10.0),
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                    elevation: 8.0,
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        snapshot.data.docs[index]['place'],
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(15.0),
                  constraints: BoxConstraints(maxWidth: double.infinity),
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                    elevation: 8.0,
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        snapshot.data.docs[index]['about'],
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                  ),
                ),
                Container(
                  constraints: BoxConstraints(maxWidth: double.infinity),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 220,
                        width: 180,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image.network(snapshot.data.docs[index]['img2'], fit: BoxFit.fill),
                        ),
                      ),
                      Container(
                        height: 220,
                        width: 180,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image.network(snapshot.data.docs[index]['img3'], fit: BoxFit.fill),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
  }
