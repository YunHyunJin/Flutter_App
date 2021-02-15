import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_go/array.dart';
import 'package:final_project_go/timer.dart';
import 'package:flutter/material.dart';

class exerlist extends StatelessWidget {
  final String documentId;

  exerlist(this.documentId);

  @override
  Widget build(BuildContext context) {
    print("dsadadda");
    CollectionReference users = FirebaseFirestore.instance.collection('mypage');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        Manfarurl = [];
        Manexercise = [];
        Womanfarurl = [];
        Womanexercise = [];
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          return Scaffold(
            body: ListView.builder(
              itemCount: data['favorite'].length,
              itemBuilder: (context, index) {
                if(sex=="Man"){
                  Manfarurl.add(data['favoriteurl'][index]);
                  Manexercise.add(data['favorite'][index]);
                }else{
                  Womanfarurl.add(data['favoriteurl'][index]);
                  Womanexercise.add(data['favorite'][index]);
                  print(Womanfarurl);

                }
                return ListTile(
                  leading: Image.network('${data['favoriteurl'][index]}',width: 80,),
                  title: Text('${data['favorite'][index]}', style: TextStyle(fontSize: 15),),
                );
              },
            ),
          );

        }
        return Text("loading");
      },
    );
  }
}

class profileurl extends StatelessWidget {
  final String documentId;

  profileurl(this.documentId);

  @override
  Widget build(BuildContext context) {
    print("dsadadda");
    CollectionReference users = FirebaseFirestore.instance.collection('mypage');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          return Image.network('${data['profileurl']}', fit: BoxFit.fill,);
            }
        return Text("loading");
      },
    );
  }
}
class firename extends StatelessWidget {
  final String documentId;

  firename(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('mypage');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          return Text('${data['name']}');
        }
        return Text("loading");
      },
    );
  }
}

class exerplay extends StatelessWidget {
  var whourl = new List();
  var whoname = new List();

  final String documentId;

  exerplay(this.documentId);

  @override
  Widget build(BuildContext context) {
    if(sex == "Man"){
      whourl = Manfarurl;
      whoname = Manexercise;
    }else{
      whourl = Womanfarurl;
      whoname = Womanexercise;
    }
    print(Manfarurl);
    CollectionReference users = FirebaseFirestore.instance.collection('mypage');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            body: Container(
              child: Column(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 200,
                      autoPlay: true,
                      enlargeCenterPage: true,
                    ),
                    items: whourl.map((i) {
                      int index = whourl.indexOf(i);
                      return Builder(
                        builder: (BuildContext context) {
                          return Stack(
                            children: [

                              Container(
                                  margin: EdgeInsets.only(top: 20),
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  height: 250,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: (sex == "Man")
                                        ? Colors.indigoAccent
                                        : Colors.deepOrange,
                                  ),
                                  child: GestureDetector(
                                    child:
                                    Image.network(
                                      whourl[index],
                                    ),
                                    onTap: (){
                                      null;
                                    },
                                  ) //child: Text('$i', style: TextStyle(fontSize: 16.0),)
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 30),
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Text(whoname[index],
                                    style: TextStyle(fontSize: 20, color: Colors.white,),),
                                ),
                              )

                            ],
                          );
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    height: 20,
                    color: (sex == "Man")
                      ? Colors.indigo
                      : Colors.pinkAccent,
                    indent: 40,
                    endIndent: 40,
                    thickness: 5,
                  ),
                  Container(
                    height: 550,
                    child: exertimer(),

                  )
                ],
              )

            )
          );

        }
        return Text("loading");
      },
    );
  }
}

