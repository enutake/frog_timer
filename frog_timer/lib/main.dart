import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String title = "げこげこ3分タイマー";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CountDownTimer(title: title),
    );
  }
}

class CountDownTimer extends StatefulWidget {
  CountDownTimer({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _CountDownTimerState createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer> with TickerProviderStateMixin{
  int _counter = 180;
  AnimationController controller;
//  var _remainingTime = "3:00";

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 100)
    );
    super.initState();
  }

//  void startTimer() {
//    Timer.periodic(Duration(seconds: 1),
//      (Timer timer) => setState(
//        () {
//          if(_counter < 1) {
//            timer.cancel();
//          } else {
//            _counter = _counter - 1;
//          }
//        },
//      ),
//    );
//  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedBuilder(
              animation: controller,
              builder: (BuildContext context, Widget child) {
                return Text(
                  '$timerString',
                  style: Theme.of(context).textTheme.display3,
                );
              },
//              child: Text(
//                '$timerString',
//                style: Theme.of(context).textTheme.display3,
//              ),
            ),
            InkWell(
              child: Container(
                width: 250,
                height: 250,
                child: Image.asset(
                  'images/otamajakushi1.png',
                  fit: BoxFit.contain,
                )
              ),
              onTap: () {
                if (controller.isAnimating) {
                  controller.stop(canceled: true);
                } else {
                  controller.reverse(
                      from: controller.value == 0.0
                          ? 1.0
                          : controller.value);
                }
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_right),
            title: Text('スタート'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cached),
            title: Text('リセット'),
          ),
        ],
      ),
    );
  }

}
