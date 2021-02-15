import 'package:final_project_go/array.dart';
import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_controller.dart';

import 'package:timer_count_down/timer_count_down.dart';


///
/// Test app
///
class exertimer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Countdown Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'Flutter Demo Countdown',
      ),
    );
  }
}


class MyHomePage extends StatefulWidget {

  final String title;

  MyHomePage({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  final CountdownController controller = CountdownController();
  var manorwoman = new List();
  bool _isPause = true;
  bool _isRestart = false;
  int exercount = 0;
  int setcount = 1;
  @override
  Widget build(BuildContext context) {
    if(sex =="Man"){
      manorwoman = Manfarurl;
    }else{
      manorwoman = Womanfarurl;
    }
    final IconData buttonIcon = _isRestart
        ? Icons.refresh
        : (_isPause ? Icons.pause : Icons.play_arrow);
    return Scaffold(

      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                (setcount == 4 && exercount == manorwoman.length-1)
                    ? ""
                    : "${setcount} set: "

              ),
              Text(
                (sex == "Man")
                    ? (setcount == 4 && exercount == Manexercise.length-1)
                      ? "Exercise Finished!!!"
                      : "${exercount+1}: "+Manexercise[exercount]
                    : (setcount == 4 && exercount == Womanexercise.length-1)
                      ? "Exercise Finished!!!"
                      : "${exercount+1}: "+Womanexercise[exercount],

                style: TextStyle(fontSize: 30),
              ),
            ],
          ),

          Image.network(
              (sex == "Man")
                  ? Manfarurl[exercount]
                  : Womanfarurl[exercount], height: 200, width: 200,
          ),
          Center(
            child: Countdown(
              controller: controller,
              seconds: 60,
              build: (_, double time) => Text(
                time.toString(),
                style: TextStyle(
                  fontSize: 100,
                ),
              ),
              interval: Duration(milliseconds: 1000),
              onFinished: () {
                print('Timer is done!');
                setState(() {
                  _isRestart = true;
                });
              },
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                child: Icon(buttonIcon),
                onPressed: () {

                  final isCompleted = controller.isCompleted;
                  isCompleted ? controller.restart() : controller.pause();

                  if (!isCompleted && !_isPause) {
                    controller.resume();

                  }
                  if (isCompleted) {
                    setState(() {
                      _isRestart = false;
                      if(exercount != (manorwoman.length-1) ) {
                        exercount++;
                        print(manorwoman.length);
                      }else{
                        if(setcount == 4){
                          setcount =0;
                        }
                        setcount++;
                        exercount=0;
                        print(exercount);

                      }
                    });
                  } else {
                    setState(() {
                      _isPause = !_isPause;
                    });
                  }

                },
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                  (_isRestart)
                      ? (setcount == 4 && exercount == manorwoman.length-1)
                        ?"<< 다시 운동하기."
                        :"<< 10초간 휴식하세요"
                      : "Doing exercise",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),

        ],
      )


    );
  }
}