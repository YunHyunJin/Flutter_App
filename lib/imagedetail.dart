
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_go/array.dart';
import 'package:flutter/material.dart';


class detail extends StatefulWidget {
  @override
  _detailState createState() => _detailState();
}

class _detailState extends State<detail> {
  String title;
  int currentgood;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.grey[300],
      body: detailpage(context),
      floatingActionButton: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20),
              child: FloatingActionButton(
                backgroundColor: Colors.green,
                child: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(0),
            //   child: FloatingActionButton(
            //     backgroundColor: Colors.green,
            //     child: Icon(Icons.delete),
            //     onPressed: () {
            //       deleteData();
            //       Navigator.pop(context);
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );

  }
  Widget detailpage(BuildContext context){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('오늘도 열심히 운동한 당신의 모습', style: TextStyle(
            color: (sex == "Man") ? Colors.indigo : Colors.pinkAccent,
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
          ),
          SizedBox(height: 20,),
          Center(
            child: Container(
              width: 300, height: 300,
              child: Image.network(
                detailurl,
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
          ),
          Container(
            padding: EdgeInsets.all(35),
            child:Center(
              child:Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  detailtodayword, style: TextStyle(fontSize:20,
                    color: (sex == "Man") ? Colors.indigo : Colors.pinkAccent,
                    fontWeight: FontWeight.bold
                ),
                ),
                SizedBox(height: 10.0),
                time(detailtodayword)

              ],
              ),
            ),


          ),
        ],

      ),
    );
  }

  void deleteData() {
    try {
      FirebaseFirestore.instance
          .collection(collec)
          .doc(detailtodayword)
          .delete();
    } catch (e) {
      print(e.toString());
    }
  }

}
class time extends StatelessWidget {
  final String documentId;

  time(this.documentId);

  @override
  Widget build(BuildContext context) {
    print("dsadadda");
    CollectionReference users = FirebaseFirestore.instance.collection(collec);

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          return Text("운동한 날:  ${data['date'].toDate().toString()} ",
            style: TextStyle(fontSize: 12,
              color: (sex == "Man") ? Colors.indigo : Colors.pinkAccent,            ),
          );
        }
        return Text("loading");
      },
    );
  }
}