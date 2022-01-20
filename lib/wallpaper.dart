import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'fullscreen.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class Wallpaper extends StatefulWidget {
  @override
  _WallpaperState createState() => _WallpaperState();
}

class _WallpaperState extends State<Wallpaper> {
  List images = [];

  int page = 1;
  ScrollController loadmoree = ScrollController();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    fetchapi();
    loadmoree.addListener(() {
      if (loadmoree.position.pixels == loadmoree.position.maxScrollExtent) {
        print("hore hai load");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.grey.shade50,
          content:
           Text(
            "loading..",
            style: TextStyle(
                fontFamily: 'roboto', fontSize: 23, color: Colors.black54),
          ),
        ));
        loadmore();
      }
    });
  }

  fetchapi() async {
    await http.get(Uri.parse('https://api.pexels.com/v1/curated?per_page=80'),
        headers: {
          'Authorization':
              '563492ad6f9170000100000140486e9681e6410b9e0ac0190c832ded'
        }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images = result['photos'];
      });
      print(images[0]);
    });
  }

  loadmore() async {
    setState(() {
      page = page + 1;
    });
    String url =
        'https://api.pexels.com/v1/curated?per_page=80&page=' + page.toString();
    await http.get(Uri.parse(url), headers: {
      'Authorization':
          '563492ad6f9170000100000140486e9681e6410b9e0ac0190c832ded'
    }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images.addAll(result['photos']);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/logo.png'),
                ),
              ),
              curve: Curves.bounceIn,
              decoration: BoxDecoration(
                color: Colors.black54,
              ),
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text('Share'),
              // selected: true,
              onTap: () {
                Share.share(
                    'Enjoy millions of beautiful wallpapers for your screen https://play.google.com/store/apps/details?id=com.orailnoor.walps',
                    subject: 'ANGELIC WALLPAPERS');
              },
            ),
            ListTile(
              leading: Icon(Icons.rate_review_outlined),
              title: Text('Rate'),
              onTap: () {
                launch(
                    'https://play.google.com/store/apps/details?id=com.orailnoor.walps');
              },
            ),
            ListTile(
              leading: Icon(Icons.privacy_tip_outlined),
              title: Text('Privacy Policy'),
              onTap: () => launch(
                  'https://heyt0uchme.blogspot.com/p/privacy-policy-t-c-about-disclaimer_10.html'),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Exit'),
              onTap: () {
                exit(0);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                scaffoldKey.currentState.openEndDrawer();
              },
              child: Icon(
                Icons.menu,
                color: Colors.black,
              ),
            ),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Text(
                      "ANGEL",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 26,
                        fontFamily: 'roboto',
                      ),
                    ),
                    Text(
                      "IC",
                      style: TextStyle(
                        color: Colors.red.shade200,
                        fontSize: 26,
                        fontFamily: 'roboto',
                      ),
                    ),
                  ],
                )),
            Divider()
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Card(
              child: GridView.builder(
                  controller: loadmoree,
                  physics: BouncingScrollPhysics(),
                  itemCount: images.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 2,
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 3,
                      mainAxisSpacing: 2),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onLongPress: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FullScreen(
                                      imageurl: images[index]['src']
                                          ['original'],
                                    )));
                      },
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FullScreen(
                                      imageurl: images[index]['src']['large2x'],
                                    )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                    images[index]['src']['medium'],
                                  ),
                                  fit: BoxFit.cover),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    );
                  }),
            ),
          ),
          // InkWell(
          //   onTap: () {
          //     loadmore();
          //   },
          //   child: Container(
          //     height: 60,
          //     width: double.infinity,
          //     // color: Colors.black,
          //     child: Center(
          //       child: Text('Load More',
          //           style: TextStyle(fontSize: 20, color: Colors.white)),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
