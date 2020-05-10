import 'package:flutter/material.dart';

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
  AnimationController controller;
  AnimationController buttoncontroller;
  final images = <Image>[
    Image.asset(
      'images/otamajakushi1.png',
      width: 250,
      height: 250,
      fit: BoxFit.contain,
    ),
    Image.asset(
      'images/otamajakushi2.png',
      width: 250,
      height: 250,
      fit: BoxFit.contain,
    ),
    Image.asset(
      'images/kaeru1.png',
      width: 250,
      height: 250,
      fit: BoxFit.contain,
    ),
    Image.asset(
      'images/kaeru2.png',
      width: 250,
      height: 250,
      fit: BoxFit.contain,
    )
  ];

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  Image get characterImage {
    Duration duration = controller.duration * controller.value;
    Image image;
    if(duration.inMinutes == 2 || duration.inMinutes == 3) {
      image = images[0];
    } else if(duration.inMinutes == 1) {
      image = images[1];
    } else if(duration.inMinutes == 0) {
      if(duration.inSeconds > 0) {
        image = images[2];
      } else {
        image = images[3];
      }
    }
    return image;
  }

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 180)
    );
    buttoncontroller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300)
    );
    super.initState();
    controller.value = 1.0;
  }

  @override
  Widget build(BuildContext context) {
    var isPlaying = false;
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
                  style: Theme.of(context).textTheme.display4,
                );
              },
            ),
            InkWell(
              child: Container(
                width: 250,
                height: 250,
                child: AnimatedBuilder(
                  animation: controller,
                  builder: (BuildContext context, Widget child) {
                    return characterImage;
                  },
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    child: Container(
                      padding: const EdgeInsets.all(25.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                      child: AnimatedIcon(
                        icon: AnimatedIcons.play_pause,
                        color: Colors.white,
                        size: 50.0,
                        progress: buttoncontroller,
                      ),
                    ),
                    onTap: () async {
                      if(!isPlaying) {
                        await buttoncontroller.forward();
                        isPlaying = true;
                      } else {
                        await buttoncontroller.reverse();
                        isPlaying = false;
                      }
                      
                      if (controller.isAnimating) {
                        controller.stop(canceled: true);
                      } else {
                        controller.reverse(
                            from: controller.value == 0.0
                                ? 1.0
                                : controller.value);
                      }
                    },
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(left: 20.0),
                    child: InkWell(
                      child: Icon(
                        Icons.cached,
                        color: Colors.white,
                        size: 50.0,
                      ),
                      onTap: (){
                        controller.reset();
                      },
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
