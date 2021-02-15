import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_go/array.dart';
import 'package:final_project_go/detailexer.dart';
import 'package:final_project_go/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';



class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() {
    WidgetsFlutterBinding.ensureInitialized();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
    });
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {


    Query query = FirebaseFirestore.instance.collection(sex);
    return Scaffold(

      body:Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text("원하는 운동 부위를 선택해주세요.",
                style: TextStyle(fontFamily: 'NotoSans',fontSize: 20, fontWeight: FontWeight.bold),),
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
                        crossAxisSpacing: 1.0,
                      ),
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

  Future logout() async {
    await FirebaseAuth.instance.signOut();
    print("logout complete");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => login()),
    );
  }
}

// flutter site에 위젯 카탈로그 활용
// 로그인할때 여자 남자 선택하여 전체적인 테마나 분위기 상이하게 조
// Listview로 해서 각각 데이터베이스에서 정보 받아오고 출력.
//material.io
// gallery.flutter.dev
// provider, block pattern

class _buildGridCards extends StatelessWidget {
  final DocumentSnapshot snapshot;

  _buildGridCards(this.snapshot);

  Map<String, dynamic> get record{
    return snapshot.data();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child:Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                child: AspectRatio(
                  aspectRatio: 25 / 20,
                  child: Image.network(record['image'] ,fit: BoxFit.fill, ),
                ),
                onTap: (){
                  exername = record['name'];
                  exersort = sex+exername;
                  exersort = exersort.toLowerCase();
                  print(exersort);

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => detail()),
                  );
                },
              ),

              SizedBox(
                height: 15,
              ),
              Text(record['name'],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black54
                  )
              )

            ],
          ),
        ),
      ),
    );

  }

}