import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';



import 'array.dart';


class add extends StatefulWidget {
  @override
  _addState createState() => _addState();
}

class _addState extends State<add> {
  File _image;

  String _profileImageURL = "";

  final picker = ImagePicker();
  final todayword = TextEditingController();
  String savename;
  String saveurl;


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
  Future uploadPic(BuildContext context) async{
    if(_image != null) {
      firebase_storage.UploadTask task = firebase_storage.FirebaseStorage
          .instance
          .ref('profile/')
          .child(todayword.text)
          .putFile(_image);
      firebase_storage.TaskSnapshot snapshot = await task;
      String storagePath = await snapshot.ref.getDownloadURL();
      _profileImageURL = storagePath;
      saveurl = _profileImageURL;

    }else{
      saveurl = (sex == "Man")
          ?"https://firebasestorage.googleapis.com/v0/b/final-project-72902.appspot.com/o/%EB%93%B1.png?alt=media&token=da5331fb-f507-48f6-b06e-524c235a6720"
          :"https://firebasestorage.googleapis.com/v0/b/final-project-72902.appspot.com/o/Woman%2F%EC%97%AC%EC%9E%90%EB%93%B1-removebg-preview.png?alt=media&token=195432c1-7d50-484e-ba59-41bba8dbdb92";
    }

    setState(() {
      savename = todayword.text;
      print(_profileImageURL);

      createRecord(context);
      Navigator.pop(context);

    });
  }
  Future createRecord(BuildContext context) async {
    final now = FieldValue.serverTimestamp();

    print('Here is createRecord');
    var defaultlist = new List();
    defaultlist.add("Defaulte Value");

    await FirebaseFirestore.instance
        .collection(collec)
        .doc('${savename}')
        .set({
      'url': saveurl,
      'todayword': savename,
      'date': now,

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context)=> Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                  SizedBox(height: 20,),
                  Container(
                      width: 300, height: 300,
                      child:(_image !=null)
                          ?Image.file(_image,fit: BoxFit.fill,)
                          :Image.network(
                        (sex == "Man")
                            ?"https://firebasestorage.googleapis.com/v0/b/final-project-72902.appspot.com/o/%EB%93%B1.png?alt=media&token=da5331fb-f507-48f6-b06e-524c235a6720"
                            :"https://firebasestorage.googleapis.com/v0/b/final-project-72902.appspot.com/o/Woman%2F%EC%97%AC%EC%9E%90%EB%93%B1-removebg-preview.png?alt=media&token=195432c1-7d50-484e-ba59-41bba8dbdb92",
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.all(
                          Radius.circular(40),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[500],
                            offset: Offset(4.0, 4.0),
                            blurRadius: 15.0,
                            spreadRadius: 1.0, ),
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(-4.0, -4.0
                            ), blurRadius: 15.0,
                            spreadRadius: 1.0,
                          ),
                        ],
                      ),
                    ),
              Padding(
                padding: EdgeInsets.only(left: 340),
                child: IconButton(
                  icon: Icon(
                    FontAwesomeIcons.camera,
                    size: 25,
                  ),
                  onPressed:(){
                    getImage();
                  },
                ),
              ),

              Container(
                padding: EdgeInsets.all(35),
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: todayword,
                      style:
                      new TextStyle(fontSize: 15.0,
                          color: (sex == "Man")
                              ?Colors.indigo
                              :Colors.pinkAccent
                      ),
                      decoration: InputDecoration(
                        hintText: "Today's word",
                        hintStyle: TextStyle(fontSize: 20.0,
                            color: (sex == "Man")
                                ?Colors.indigo
                                :Colors.pinkAccent
                        ),
                        fillColor: (sex == "Man")
                            ?Colors.indigo
                            :Colors.pinkAccent
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RaisedButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("취소", )
                        ),
                        SizedBox(width: 10,),
                        RaisedButton(
                            onPressed: () {
                              um = true;
                              if(todayword.text != ""){
                                uploadPic(context);
                              }else{
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text("Please enter Today's word"),
                                ));
                              }

                              // Scaffold.of(context).showSnackBar(SnackBar(content: Text('Upload!!!')));
                            },
                            child: Text("저장"))
                      ],
                    )
                  ],
                ),

              ),
            ],

          ),
        ),
      ),
    );
  }



}
