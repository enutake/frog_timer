import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String title = "げこげこ3分タイマー";
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: countDownTimer(title: title),
    );
  }
}

class countDownTimer extends StatefulWidget {
  countDownTimer({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _countDownTimerState createState() => _countDownTimerState();
}

class _countDownTimerState extends State<countDownTimer> {
  int _counter = 180;

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  void startTimer() {
    Timer.periodic(Duration(seconds: 1),
        (Timer timer) => setState(
            () {
              if(_counter < 1) {
                timer.cancel();
              } else {
                _counter = _counter - 1;
              }
            },
        ),
    );
  }

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
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display3,
            ),
            Container(
              width: 250,
              height: 250,
              child: Image.asset(
                'images/otamajakushi1.png',
                fit: BoxFit.contain,
              ),
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
