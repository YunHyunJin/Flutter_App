import 'package:final_project_go/array.dart';
import 'package:final_project_go/favoriteexer.dart';
import 'package:flutter/material.dart';

class start extends StatefulWidget {
  @override
  _startState createState() => _startState();
}

class _startState extends State<start> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("exercise"),
        backgroundColor: (sex == "Man") ? Colors.indigo : Colors.pinkAccent,
      ),
      body: exerplay(sex),



    );
  }
}
