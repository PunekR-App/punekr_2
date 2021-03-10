import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatelessWidget {
  static FirebaseAuth fAuth;
  @override
  Widget build(BuildContext context) {
    List<String> ent = ['Plays', 'Sangeet'];
    List<String> entM = ['नाटक', 'संगीत'];
    List<String> explore = ['Tourism', 'Temples', 'Public Parks'];
    List<String> exploreM = ['पर्यटन स्थळ', 'मंदिरे', 'बाग'];
    List<String> more = ['Local Businesses'];
    List<String> moreM = ['उद्योग'];
    List<String> entImg = ['assets/solid/natak.svg', 'assets/gradient/sangeet_gradient.svg'];
    List<String> exploreImg = ['assets/solid/travel-guide.svg', 'assets/solid/temple_3.svg', 'assets/gradient/parks_gradient.svg'];
    List<String> moreImg = ['assets/gradient/businesses_gradient.svg'];
    double iconWidth = 75.0;
    fAuth = FirebaseAuth.instance;
    return Scaffold(
      drawer: Container(
        width: 80.0,
        child: Drawer(
          child: Column(
            children: [
              DrawerHeader(
                child: Container()
              ),
              ListTile(
                title: Image.asset("assets/forms_icon.png", width: 30,),
                onTap: ()async{
                  if(await canLaunch('https://forms.gle/MFCj8QbzLE7xuf2n6')){
                    await launch('https://forms.gle/MFCj8QbzLE7xuf2n6');
                  }
                },
              ),
              ListTile(
                title: Image.asset("assets/insta_icon.png", width: 30,),
                onTap: ()async{
                  if(await canLaunch('https://www.instagram.com/punekr_app/')){
                    await launch('https://www.instagram.com/punekr_app/');
                  }
                },
              ),
              ListTile(
                title: Icon(Icons.share, size: 30.0,),
                onTap: ()async{
                  if(await canLaunch('https://play.google.com/store/apps/details?id=com.techrapp.punekr&hl=en_IN&gl=US')){
                    await launch('https://play.google.com/store/apps/details?id=com.techrapp.punekr&hl=en_IN&gl=US');
                  }
                },
              ),
              // AuthToggle(),
            ],
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("home").snapshots(),
        builder: (context, snapshot) {

          if (!snapshot.hasData) {
            return LinearProgressIndicator();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LinearProgressIndicator();
          }
          DocumentSnapshot icons = snapshot.data.docs[0];
          DocumentSnapshot banners = snapshot.data.docs[1];
          entImg[0] = icons.data()['play'];
          entImg[1] = icons.data()['sangeet'];
          exploreImg[0] = icons.data()['tourism'];
          exploreImg[1] = icons.data()['temple'];
          exploreImg[2] = icons.data()['park'];
          // more_img[0] = icons.data()['diwali'];
          moreImg[0] = icons.data()['business'];


          return Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15.0, top: 125.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // height: 180,
                        child: CarouselSlider(
                          items: banners.data().map((key, value){
                            return MapEntry(key, Container(
                              height: 230,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(value),
                                  fit: BoxFit.contain,                                    )
                                ),
                              )
                            );
                          }).values.toList(),
                          options: CarouselOptions(
                            height: 180,
                            autoPlay: true,
                            autoPlayCurve: Curves.easeInOut,
                            enlargeCenterPage: true,

                          ),
                        ),
                      ),
                      ListTile(
                        title: Text('Peth',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                      SizedBox(
                        height: 200.0,
                        child: ListView.builder(
                          itemCount: more.length,
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(horizontal: 0.0),
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                if (index == 0) {
                                  Navigator.pushNamed(context, '/local');
                                } else {
                                  // Navigator.pushNamed(context, '/local');
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal:8.0, vertical: 10.0),
                                child: Card(
                                  elevation: 7.0,
                                  shadowColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0))),
                                  child: Container(
                                    height: 120.0,
                                    width: 150.0,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceEvenly,
                                      children: [
                                        Text(moreM[index]),
                                        Image.network(moreImg[index], height: 80),
                                        Text(more[index])
                                      ],
                                    )
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      ListTile(
                        title: Text('Entertainment',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                      SizedBox(
                        height: 200.0,
                        child: ListView.builder(
                          itemCount: ent.length ,
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: (){
                                if(index == 0){
                                  Navigator.pushNamed(context, '/plays');
                                } else if (index == 1){
                                  Navigator.pushNamed(context, '/sangeet');
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                                child: Card(
                                  elevation: 7.0,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                  child: Container(
                                    height: 120.0,
                                    width: 150.0,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(entM[index]),
                                        Image.network(entImg[index], width: iconWidth),
                                        Text(ent[index])
                                      ],
                                    )
                                  )
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      ListTile(
                        title: Text('Explore',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                      SizedBox(
                        height: 200.0,
                        child: ListView.builder(
                          itemCount: explore.length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(horizontal: 0.0),
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: (){
                                if(index == 0){
                                  Navigator.pushNamed(context, '/places');
                                } else if (index == 1){
                                  Navigator.pushNamed(context, '/temples');
                                } else if(index == 2){
                                  print('Pushed Parks');
                                  Navigator.pushNamed(context, '/parks');
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                                child: Card(
                                  elevation: 7.0,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                  child: Container(
                                    height: 120.0,
                                    width: 150.0,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(exploreM[index]),
                                        Image.network(exploreImg[index], width: iconWidth,),
                                        Text(explore[index],)
                                      ],
                                    )
                                  )
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      // Container(
                      //   padding: EdgeInsets.only(top:12),
                      //   child: CarouselSlider(
                      //     // height: 180,
                      //     items: [
                      //       Container(
                      //         decoration: BoxDecoration(
                      //           image: DecorationImage(
                      //             image: AssetImage('assets/banner.jpg'),
                      //           ),
                      //         ),
                      //       )
                      //     ],
                      //     options: CarouselOptions(
                      //       scrollPhysics: NeverScrollableScrollPhysics(),
                      //       height: 94,
                      //       autoPlay: false,
                      //       autoPlayCurve: Curves.easeInOut,
                      //       enlargeCenterPage: true,
                      //
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              Positioned(
                child: SizedBox(
                  height: 100.0,
                  child: AppBar(
                    iconTheme: IconThemeData(color: Color(0xFFFF6600)),
                    toolbarHeight: 75,
                    centerTitle: true,
                    elevation: 15.0,
                    title: Container(
                      child: SvgPicture.asset('assets/app_title_2.svg',
                        height: 60,
                        width: 70,
                      ),
                    ),
                    backgroundColor: Color(0xFFFFFFFF),
                  ),
                ),
              ),
            ]
          );
        }
      ),
      backgroundColor: Colors.white,
    );
  }
}

class AuthToggle extends StatefulWidget {
  @override
  _AuthToggleState createState() => _AuthToggleState();
}

class _AuthToggleState extends State<AuthToggle> {
  FirebaseAuth fAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    if(fAuth.currentUser == null){
      return ListTile(
          title: Text('Sign In'),
          onTap: (){
            Navigator.pushNamed(context, '/auth/login').whenComplete(() => setState((){}));
          }
      );
    } else {
      return ListTile(
          title: Icon(Icons.exit_to_app),
          onTap: () {
            setState(() {
              fAuth.signOut();
            });
          }
      );
    }
  }
}

