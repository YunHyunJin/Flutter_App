

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_go/array.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class explain extends StatefulWidget {
  @override
  _explainState createState() => _explainState();
}

class _explainState extends State<explain> {
  bool like = currentlike ;

  @override
  Widget build(BuildContext context) {
    //String sort_ex = exersort+"exercise";

    return Scaffold(
      appBar: AppBar(
        title: Text(exertag),
        backgroundColor: (sex == "Man") ? Colors.indigo : Colors.pinkAccent,
        actions: [
          IconButton(icon: Icon(
            like ? Icons.check_box_outlined : Icons.check_box_outline_blank_sharp,
            color: like ? Colors.yellow : null,
          ),
          onPressed:(){
            setState(() {
                if (like) {
                  like = false;
                  deleteRecord(context);
                } else {
                  createRecord(context);
                  like = true;
                }
                add(context);
            });
          },
          )
        ],
      ),  
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Center(
              child: Hero(
                tag: exersort,
                child: Image.network(explainurl,
                width: 370,
                  height: 350,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(25),
              child: Text(information),

            )
          ],
        ),

      )



    );
  }
  Future add(BuildContext context) async {

    print('Here is add');

    await FirebaseFirestore.instance
        .collection(exersort)
        .doc(exertag)
        .update({
      'like' : like,
    });
  }
  Future createRecord(BuildContext context) async {
    print('Here is createRecord');
    print(sex);
    int i;
    var listset  = new List();
    var listurl  = new List();

    bool what = false;

    print(Womanexercise);
    print(Manexercise);

    if(sex == "Man"){
      for(i=0 ; i<Manexercise.length  ; i++){
        if(Manexercise[i] == exertag){
          what = true;
          print("true");
        }
      }
      if(what == false){
        print("add Man");
        Manexercise.add(exertag);
        Manfarurl.add(explainurl);
        listset = Manexercise;
        listurl = Manfarurl;
      }
    }
    else{
      for(i=0 ; i<Womanexercise.length  ; i++){
        if(Womanexercise[i] == exertag){
          what = true;
          print("true");
        }
      }
      if(what == false){
        print("add Woman");
        Womanexercise.add(exertag);
        Womanfarurl.add(explainurl);
        listset = Womanexercise;
        listurl = Womanfarurl;

      }
    }

    await FirebaseFirestore.instance
        .collection("mypage")
        .doc(sex)
        .update({
      'favorite': listset,
      'favoriteurl' : listurl,

    });
  }
  Future deleteRecord(BuildContext context) async {
    print('Here is deleteRecord');
    print(Womanexercise);
    print(Manexercise);

    int i;
    var listset  = new List();
    var listurl  = new List();
    bool what = false;
    print(Womanexercise);

    if(sex == "Man"){
        print("delete Man");
        Manexercise.remove(exertag);
        Manfarurl.remove(explainurl);
        listset = Manexercise;
        listurl = Manfarurl;
    }
    else{
        print("delete Woman");
        Womanexercise.remove(exertag);
        Womanfarurl.remove(explainurl);
        listset = Womanexercise;
        listurl = Womanfarurl;
    }

    await FirebaseFirestore.instance
        .collection("mypage")
        .doc(sex)
        .update({
      'favorite': listset,
      'favoriteurl' : listurl,
    });
  }
}
