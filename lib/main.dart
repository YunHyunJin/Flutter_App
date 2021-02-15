
import 'package:final_project_go/array.dart';
import 'package:final_project_go/tab.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(login());
}
class login extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<bool> isSelected = [false, false];
  List<FocusNode> focusToggle;


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Center(
          child:Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Gym Pack', style: TextStyle(fontSize: 50, color: Colors.black, fontWeight: FontWeight.bold),),
                Image.network("https://firebasestorage.googleapis.com/v0/b/final-project-72902.appspot.com/o/login_image.png?alt=media&token=4094ae66-8fd9-4eb3-b592-07f5523ee224"),
                Container(
                  padding: const EdgeInsets.only(top: 16.0),
                  alignment: Alignment.center,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ToggleButtons(
                          selectedColor: Colors.amberAccent,
                          fillColor: Colors.purple,
                          splashColor: Colors.lightBlue,
                          highlightColor: Colors.lightBlue,
                          borderColor: Colors.white,
                          borderWidth: 5,
                          selectedBorderColor: Colors.greenAccent,
                          renderBorder: true,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25)),
                          disabledColor: Colors.blueGrey,
                          disabledBorderColor: Colors.blueGrey,
                          focusColor: Colors.red,
                          focusNodes: focusToggle,
                          children: [
                            Text('Man'),
                            Text('Woman'),
                          ],
                          isSelected: isSelected,
                          onPressed: (int index){
                            setState(() {
                              isSelected[index] = !isSelected[index];
                              print(index);
                              if(index == 0){
                                isSelected[1] = false;
                                sex = "Man";
                              }else if(index == 1){
                                isSelected[0] = false;
                                sex = "Woman";
                              }
                              print(sex);
                            });
                          },
                        ),

                      ],
                    ),

                  ),
                ),
                Container(
                    padding: const EdgeInsets.only(top: 2.0),
                    alignment: Alignment.center,
                    child: Builder(builder: (BuildContext context) {
                      return  SignInButton(
                        Buttons.GoogleDark,
                        onPressed: (){
                          if(isSelected[0] ==false && isSelected[1] == false){
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text("Please Select Male or Female"),
                            ));
                          }else{
                            signInWithGoogle();
                          }
                        },
                      );
                    }
                    )
                ),
                Container(
                  child: Builder(builder: (BuildContext context) {
                   return  IconButton(
                     icon: Icon(Icons.account_balance_wallet_rounded),
                     onPressed: (){
                       if(isSelected[0] ==false && isSelected[1] == false){
                         Scaffold.of(context).showSnackBar(SnackBar(
                           content: Text("Please Select Male or Female"),
                         ));
                       }else{
                         print(sex);
                         Navigator.push(
                           context,
                           MaterialPageRoute(builder: (context) => TabBarDemo()),
                         );
                       }
                     },
                   );
                  }
                  )
                )

              ],
            ),
          )

      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  Future<void> signInWithGoogle() async {
    print("i am here");
    try{
      await Firebase.initializeApp();
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      print("ㅆㅆㅆㅆㅆ");
      await FirebaseAuth.instance.signInWithCredential(credential);


      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TabBarDemo()),
      );

    }catch(e){
      print(e);
      print("ㄴㄴㄴㄴ");
    }

  }

}

