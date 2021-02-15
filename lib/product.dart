

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class Record {
  final String chesturl;
  final String backurl;
  final String legurl;
  final String shoulderurl;
  final String name;
  final String imageurl;
  final String info;

  final String url;
  final int date;
  final String todayword;


  var detailimage = new List();
  var detailname = new List();
  bool like ;


  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : //assert(map['chesturl'] != null),
        //assert(map['backurl'] != null),
        //assert(map['legurl'] != null),
        //assert(map['shoulderurl'] != null),
  //assert(map['uid'] != null),
        url = map['url'],
        date = map['date'],
        todayword = map['todayword'],

      info = map['info'],
        like = map['like'],
        name = map['name'],
        imageurl = map['imageurl'],
        detailimage = map['detailimage'],
        detailname = map['detailname'],
        chesturl = map['chesturl'],
        backurl = map['backurl'],
        legurl = map['legurl'],
        shoulderurl = map['shoulderurl'];


  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override
  String toString() => "Record<$chesturl:$legurl>";

}

