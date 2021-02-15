import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_go/array.dart';
import 'package:final_project_go/explain.dart';
import 'package:final_project_go/product.dart';
import 'package:flutter/material.dart';

class detail extends StatefulWidget {
  @override
  _detailState createState() => _detailState();
}

class _detailState extends State<detail> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    Query query = FirebaseFirestore.instance.collection(sex);
    return Scaffold(
      appBar: AppBar(title: Text(exername),
        backgroundColor: (sex == "Man") ? Colors.indigo : Colors.pinkAccent,
      ),
      resizeToAvoidBottomPadding: false,
      body: _buildBody(context),
    );
  }
  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection(exersort).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.docs);
      },
    );
  }
  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    _index = 0;
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    _index += 1;
    final record = Record.fromSnapshot(data);
    return
      Padding(
          key: ValueKey(record.name),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: GestureDetector(
            child: Row(
              children: [
                Container(
                  height: 70,
                  width: 100,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    child: Image.network(record.imageurl, fit: BoxFit.fill,),
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(record.name),
                        subtitle: Text(record.name),
                        trailing: Text('0${_index}'),
                      ),
                      const Divider(thickness: 2),
                    ],
                  ),
                ),
              ],
            ),
            onTap: (){
              exertag = record.name;
              explainurl = record.imageurl;
              currentlike = record.like;
              information = record.info;
              print(sex+"exercise");
              print(exertag);
              print(exersort);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => explain()),
              );
            },
          )



      );
  }

}
