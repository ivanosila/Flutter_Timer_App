import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  routes: {
    '/': (context) => TimerApp(),
  },
));

class TimerApp extends StatefulWidget {
  @override
  _TimerAppState createState() => _TimerAppState();
}

class _TimerAppState extends State<TimerApp> {

  static const duration = const Duration(seconds: 1);

  int secondsPassed = 0;
  bool isActive = false;

  Timer timer;

  void handleTick() {
    if (isActive) {
      setState(() {
        secondsPassed = secondsPassed + 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    if (timer == null)
      timer = Timer.periodic(duration, (Timer t) {
        handleTick();
      });

    int seconds = secondsPassed % 60;
    int minutes = secondsPassed ~/ 60;
    int hours = secondsPassed ~/ (60 * 60);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(
            "Countdown Timer"
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomTextContainer(
                    label: 'HOURS',
                    value: hours.toString().padLeft(2, '0')
                ),
                CustomTextContainer(
                    label: 'MINUTES',
                    value: minutes.toString().padLeft(2, '0')
                ),
                CustomTextContainer(
                    label: 'SECONDS',
                    value: seconds.toString().padLeft(2, '0')
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    isActive = !isActive;
                  });
                },
                child: Text(
                    isActive ? 'STOP' : 'START'
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextContainer extends StatelessWidget {
  CustomTextContainer({this.label, this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.all(20),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(10),
        color: Colors.black87,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '$value',
            style: TextStyle(
              color: Colors.white,
              fontSize: 54,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '$label',
            style: TextStyle(
              color: Colors.white30,
            ),
          )
        ],
      ),
    );
  }
}
