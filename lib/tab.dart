import 'package:final_project_go/array.dart';
import 'package:final_project_go/home.dart';
import 'package:final_project_go/map.dart';
import 'package:final_project_go/mypage.dart';
import 'package:final_project_go/record.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

import 'main.dart';
class TabBarDemo extends StatefulWidget {
  @override
  _TabBarDemoState createState() => _TabBarDemoState();
}

class _TabBarDemoState extends State<TabBarDemo> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Gym Pack"),
            leading: FlatButton(
              child: Icon(Icons.share),
            ),
            backgroundColor: (sex == "Man") ? Colors.indigo : Colors.pinkAccent,
            actions: [
              IconButton(icon: Icon(Icons.exit_to_app),
                onPressed: logout,
              )
            ],
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.account_tree_sharp),text: "Exercise",),
                Tab(icon: Icon(Icons.add_location_alt_sharp),text: "Search",),
                Tab(icon: Icon(Icons.account_circle_rounded), text: "My page",),
                Tab(icon: Icon(Icons.description), text: "Record",),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              HomePage(),
              map(),
              mypage(),
              App(),
            ],
          ),
        ),
      ),
    );
  }
  Future logout() async {
    await FirebaseAuth.instance.signOut();
    print("logout complete");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => login()),
    );
  }
}