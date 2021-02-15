import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_go/array.dart';
import 'package:final_project_go/favoriteexer.dart';
import 'package:final_project_go/start.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class mypage extends StatefulWidget {
  @override
  _mypageState createState() => _mypageState();
}

class _mypageState extends State<mypage> {
  String currentname ;
  String exprofile;
  String exname;

  Query query =
  FirebaseFirestore.instance.collection('baby');

  File _image;
  final name = TextEditingController();


  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
            children: [
              Container(
                height: 150,
                padding: EdgeInsets.all(10),
               child: Card(
                 child: FlipCard(
                   direction: FlipDirection.HORIZONTAL,
                   front: Material(
                     color: Colors.white.withOpacity(0.8),
                     borderRadius: BorderRadiusDirectional.circular(30.0),
                     child: showpage(context),
                   ),
                   back: Material(
                     color: Colors.white.withOpacity(0.6),
                     borderRadius: BorderRadiusDirectional.circular(30.0),
                     child: setpage(context),
                   ),
                 ),
               )
              ),
              Center(
                child: Text("<My exercise>", style: TextStyle(fontWeight: FontWeight.bold),),
              ),
              Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: new BorderRadius.circular(16.0),
                    border: (sex == "Man")
                        ?Border.all(color: Colors.indigo)
                        :Border.all(color: Colors.pinkAccent)
                ),
                height: 200,
                child: exerlist(sex),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                      child: Icon(
                        Icons.account_tree,
                        size: 200,
                      ),
                      onPressed:(){
                        Navigator.of(context).push(new MaterialPageRoute<Null>(
                            builder: (BuildContext context) {
                              return new start();
                            },
                            fullscreenDialog: true
                        ));
                      }
                  ),
                  Text("운동 시작하기",style: TextStyle(fontSize: 20),)
                ],
              )

             ]
      ),

    );
  }
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
  Widget showpage(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 120,
          width: 120,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(100)),
            child: (profileImageURL !=null)
                ? profileurl(sex)
                : Icon(Icons.account_circle, size: 120, color: Colors.grey,),

          ),
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Name : "),

                Container(
                  width: 180,
                  child: (savename == "")
                      ?Text("Not yet set your name", style: TextStyle(color: Colors.grey),)
                      :firename(sex)
                  ),
              ],
            ),
          ],
        )
      ],
    );
  }
  Widget setpage(BuildContext context){
    if(sex == "Man"){
      exprofile = manprofile;
      exname = mann;
    }else{
      exprofile = womanprofile;
      exname = womann;
    }
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 120,
            width: 120,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(100)),
              child: (_image !=null)
                  ?Image.file(_image,fit: BoxFit.fill)
                  : Icon(Icons.account_circle, size: 120, color: Colors.grey,),

            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children:[
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.camera,
                  size: 20,
                ),
                onPressed:(){
                  getImage();
                },
              ),
            ]
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text("Name : "),
                  Container(
                    width: 100,
                    child: TextField(
                      controller: name,
                      decoration: InputDecoration(
                        hintText: (exname == null)
                            ?"이름 입력"
                            :exname
                        ,
                      ),
                    ),
                  )

                ],
              ),
              SizedBox(
                width: 70,
                child: RaisedButton(
                  child:Text("확인"),
                  onPressed: (){
                    uploadPic(context);
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("저장완료! 프로필을 한번 더 탭해주세요."),
                    ));
                  },
                ),
              )

            ],
          )
        ],
      ),
    );
  }
  Future uploadPic(BuildContext context) async{
    print("Name: ${name.text}");

    if(_image !=null){
      firebase_storage.UploadTask task = firebase_storage.FirebaseStorage.instance
          .ref('profile/')
          .child(name.text)
          .putFile(_image);

      firebase_storage.TaskSnapshot snapshot = await task;
      String storagePath = await snapshot.ref.getDownloadURL();
      profileImageURL = storagePath;

      if(sex == "Man"){
        manprofile = storagePath;
      }else{
        womanprofile = storagePath;

      }
    }else{
      print("nullnullnullnullnullnullnullnullnullnullnull");
      if(sex == "Man"){
        profileImageURL =  manprofile ;
      }else{
        profileImageURL = womanprofile ;
      }
    }


    setState(() {
      if(name.text == ""){
        print(exname);
        currentname = exname;
        savename = exname;
      }else{
        if(sex == "Man"){
          mann = name.text;
          currentname = mann;
          savename = name.text;
        }else{
          womann = name.text;
          currentname = womann;
          savename = name.text;
        }
      }
      print("Url: "+profileImageURL);

      createRecord(context);

    });
  }
  Future createRecord(BuildContext context) async {
    print('Here is createRecord');
    print(sex);
    await FirebaseFirestore.instance
        .collection("mypage")
        .doc(sex)
        .update({
      'name': currentname,
      'profileurl': profileImageURL,
    });
  }
}
