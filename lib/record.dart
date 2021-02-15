import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_go/addimage.dart';
import 'package:final_project_go/array.dart';
import 'package:final_project_go/imagedetail.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


bool USE_FIRESTORE_EMULATOR = false;

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:'list',
      home: HomePage2(),
    );
  }
}

class HomePage2 extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage2> {
  String collect = (sex =="Man") ? 'recordMan' : 'recordWoman' ;
  _HomePageState();

  @override
  Widget build(BuildContext context) {

    Query query =
    FirebaseFirestore.instance.collection(collect);

    return Scaffold(

      body:
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.only(top: 30),
              margin: EdgeInsets.only(left: 10,right: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      colors: [
                        Colors.black.withOpacity(.4),
                        Colors.black.withOpacity(.2),
                      ]
                  )
              ),
              child: Column(
                children: [
                  Text("Record your body", style: TextStyle(color: Colors.grey, fontSize: 35, fontWeight: FontWeight.bold),),
                  SizedBox(height: 20,),
                  Container(
                    height: 50,
                    width: 400,
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      color: (sex == "Man") ? Colors.indigo : Colors.pinkAccent,
                    ),
                    child: FlatButton(
                      onPressed: (){
                        collec = collect;
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => add()),
                        );
                      },
                        child: Text(
                          "Click to save your body", style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.bold),
                        )
                    ),
                  ),
                  SizedBox(height: 20,),

                ],
              ),
            ),
            Expanded(
              child:StreamBuilder<QuerySnapshot>(
                stream: query.snapshots(),
                builder: (context, stream){
                  if (stream.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (stream.hasError) {
                    return Center(child: Text(stream.error.toString()));
                  }
                  QuerySnapshot querySnapshot = stream.data;
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 8.0 / 9.0,
                        mainAxisSpacing: 1.0,
                        crossAxisSpacing: 1.0),
                    itemCount: querySnapshot.size,
                    itemBuilder: (context, index) => _buildGridCards(querySnapshot.docs[index]),
                  );
                },
              ),
            )
          ],
        ),

    );

  }
  Widget nopage(BuildContext context){
    return Container(
      child: Text('no image'),
    );
  }



}
class _buildGridCards extends StatelessWidget {
  final DocumentSnapshot snapshot;

  _buildGridCards(this.snapshot);

  Map<String, dynamic> get record{
    return snapshot.data();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(3.0),
      child:Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
        child: Card(
          color: Colors.transparent,
          elevation: 4,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    colors: [
                      Colors.black.withOpacity(.4),
                      Colors.black.withOpacity(.2),
                    ]
                )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  child: AspectRatio(
                    aspectRatio: 18 / 14,
                    child:(record['url'] !=null)
                        ?Image.network(record['url'] ,fit: BoxFit.fill,)
                        :Image.network(
                      "http://handong.edu/site/handong/res/img/logo.png",
                      fit:BoxFit.fill,
                    ),
                  ),
                  onTap: (){
                    detailurl = record['url'];
                    detailtodayword = record['todayword'];
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => detail()),
                    );
                  },
                ),

                Expanded(
                    child: Center(
                        child: Text(
                          (record['todayword'] !=null)? record['todayword'] : "null",
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold ),
                          maxLines: 1,
                        ),
                    ),
                ),
              ],
            ),
          )

        ),
      ),
    );

  }

}
