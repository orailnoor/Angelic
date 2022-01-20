import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

// import 'package:flowder/flowder.dart';
class FullScreen extends StatefulWidget {
  final String imageurl;

  const FullScreen({Key key, this.imageurl}) : super(key: key);
  @override
  _FullScreenState createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  String _wallpaperUrlHome = 'Unknown';

  Future<void> setWallpaperHome() async {
    setState(() {
      _wallpaperUrlHome = 'Loading';
    });
    String result;
    try {
      String url = widget.imageurl;
      result =
          await AsyncWallpaper.setWallpaper(url, AsyncWallpaper.HOME_SCREEN);
    } on PlatformException {
      result = 'Failed to get wallpaper.';
    }

    if (!mounted) return;

    setState(() {
      _wallpaperUrlHome = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
        activeBackgroundColor: Colors.red.shade300,
        label: _wallpaperUrlHome == 'Loading'
            ? const Text(
                "Setting",
                style: TextStyle(
                  fontSize: 16,
                ),
              )
            : const Text(
                'Set ',
              ),
        backgroundColor: Colors.red.shade200,
        animatedIcon: AnimatedIcons.menu_arrow,
        gradientBoxShape: BoxShape.rectangle,
        children: [
          SpeedDialChild(
              child: Icon(Icons.home_outlined),
              label: 'Home',
              onTap: () {
                setWallpaperHome();
              }),
          SpeedDialChild(
              child: Icon(Icons.lock_outlined),
              label: 'Lock',
              onTap: () {
                setWallpaperLock();
              }),
          SpeedDialChild(
              child: Icon(Icons.picture_in_picture_alt_outlined),
              label: 'Both',
              onTap: () {
                setWallpaperBoth();
              }),
        ],
      ),

      // FloatingActionButton.extended(
      //   onPressed: () {
      //     setWallpaperHome();
      //   },
      //   backgroundColor: Colors.grey.shade400,
      //   icon: Icon(Icons.filter),
      // label: _wallpaperUrlHome == 'Loading'
      //     ? const Text("Setting..")
      //     : const Text('Set '),
      // ),
      body: Column(
        children: [
          Container(
            child: Image.network(
              widget.imageurl,
              // fit: BoxFit.fill,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.red.shade200,
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes
                        : null,
                  ),
                );
              },
            ),
            height: 700,
            decoration: BoxDecoration(
              color: Colors.white,
              // image: DecorationImage(image: NetworkImage(widget.imageurl))
            ),
          ),
        ],
      ),
    );
  }

  void setWallpaperLock() async {
    {
      setState(() {
        _wallpaperUrlHome = 'Loading';
      });
      String result;
      try {
        String url = widget.imageurl;
        result =
            await AsyncWallpaper.setWallpaper(url, AsyncWallpaper.LOCK_SCREEN);
      } on PlatformException {
        result = 'Failed to get wallpaper.';
      }

      if (!mounted) return;

      setState(() {
        _wallpaperUrlHome = result;
      });
    }
  }

  void setWallpaperBoth() async {
    {
      setState(() {
        _wallpaperUrlHome = 'Loading';
      });
      String result;
      try {
        String url = widget.imageurl;
        result =
            await AsyncWallpaper.setWallpaper(url, AsyncWallpaper.BOTH_SCREENS);
      } on PlatformException {
        result = 'Failed to get wallpaper.';
      }

      if (!mounted) return;

      setState(() {
        _wallpaperUrlHome = result;
      });
    }
  }
}
