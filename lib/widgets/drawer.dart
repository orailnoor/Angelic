import 'package:flutter/material.dart';

class _drawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: const <Widget>[
          DrawerHeader(
            curve: Curves.bounceIn,
            decoration: BoxDecoration(
              color: Colors.black54,
            ),
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text('Share'),
          ),
          ListTile(
            leading: Icon(Icons.rate_review_outlined),
            title: Text('Rate'),
          ),
          ListTile(
            leading: Icon(Icons.privacy_tip_outlined),
            title: Text('Privacy Policy'),
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Exit'),
          ),
        ],
      ),
    );
  }
}
