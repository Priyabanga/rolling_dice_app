import 'package:flutter/material.dart';
import 'dart:math';

class MyHomeScreen extends StatefulWidget {
  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen>
    with SingleTickerProviderStateMixin {
  int leftDiceNumber = 1;
  int rightDiceNumber = 1;

  AnimationController _controller;
  CurvedAnimation animation;

  @override
  void initState() {
    super.initState();
    animate();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  animate() {
    _controller =
        AnimationController(duration: Duration(milliseconds: 100), vsync: this);
    animation = CurvedAnimation(parent: _controller, curve: Curves.bounceOut);
    animation.addListener(() {
      setState(() {});
      //print(_controller.value);
    });
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          leftDiceNumber = Random().nextInt(6) + 1;
          rightDiceNumber = Random().nextInt(6) + 1;
        });
        print("completed");
        _controller.reverse();
      }
    });
  }

  roll() {
    _controller.forward();
    //print("clicked!!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dice Game",
          style: TextStyle(
            fontFamily: 'cursive',
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black87,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          color: Colors.deepOrangeAccent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Flexible(
                    child: GestureDetector(
                      child: Image.asset(
                        'images/dice$leftDiceNumber.png',
                        height: 200 - (animation.value ?? 1) * 200,
                      ),
                      onDoubleTap: roll,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    child: GestureDetector(
                      child: Image.asset(
                        'images/dice$rightDiceNumber.png',
                        height: 200 - (animation.value ?? 1) * 200,
                      ),
                      onDoubleTap: roll,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              RaisedButton(
                child: Text(
                  "Roll",
                  style: TextStyle(
                    fontFamily: 'cursive',
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () => roll(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
