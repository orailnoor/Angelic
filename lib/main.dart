import 'dart:async';
import 'package:flutter/material.dart';

import 'package:pixel_paper/wallpaper.dart';
import 'package:lottie/lottie.dart';

void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData(primaryIconTheme: IconThemeData(color: Colors.red)),?
      // title: 'Splash Screen',
      // theme: ThemeData(
      //   primarySwatch: Colors.grey.shade100,
      // ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 2),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Wallpaper())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
        decoration: BoxDecoration(color: Colors.white
            // gradient: LinearGradient(
            //     begin: Alignment.topCenter,
            //     end: Alignment.bottomCenter,
            //     colors: [Color(0xff070919), Color(0xff191b29)]
            //     )
            ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      ),
      Column(children: [
        Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(children: [
            Spacer(),
            Container(height: 250, child: Image.asset('assets/logo.png')),
            SizedBox(
              height: 10,
            ),
            // CircularProgressIndicator(),
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "ANGEL",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 24,
                    fontFamily: 'roboto',
                  ),
                ),
                Text(
                  "IC",
                  style: TextStyle(
                    color: Colors.red.shade200,
                    fontSize: 24,
                    fontFamily: 'roboto',
                  ),
                ),
              ],
            )),

            // Container(
            //   child: Text(
            //     "Wallpapers",
            //     style: TextStyle(
            //       color: Colors.blue.shade100,
            //       fontFamily: 'roboto',
            //       fontSize: 20,
            //       fontWeight: FontWeight.w500,
            //     ),
            //   ),
            // ),

            Container(height: 100, child: Lottie.asset('assets/load.json')),
            Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "ORAIL",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 10,
                    fontFamily: 'roboto',
                  ),
                ),
                Text(
                  "NOOR",
                  style: TextStyle(
                    color: Colors.red.shade200,
                    fontSize: 10,
                    fontFamily: 'roboto',
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 10,
            )
          ]),
        ),
      ]),
    ]));
  }
}
