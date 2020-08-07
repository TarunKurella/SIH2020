import 'package:flutter/material.dart';
import './loginpage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroAnimation(),
    );
  }
}

class IntroAnimation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return IntroAnimationState();
  }
}

class IntroAnimationState extends State<IntroAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  double _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 3,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {
          // Add code here leater
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 75.0,
                backgroundColor: Color(0xFFffe5b4),
                child: Icon(
                  Icons.airplanemode_active,
                  color: Colors.black,
                  size: 100.0,
                ),
              ),
              Container(
                child: Text(
                  "You record, \nWe simplify",
                  style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
                ),
                padding: EdgeInsets.only(top: 20),
              ),
              Container(
                height: 80.0,
              ),
              Center(
                child: GestureDetector(
                  onTapDown: _onTapDown,
                  onTapUp: _onTapUp,
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return LoginPage();
                    }));
                  },
                  child: Transform.scale(
                    scale: _scale,
                    child: _animatedButtonUI,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget get _animatedButtonUI => Container(
        height: 70,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF00003f),
              offset: Offset(0.0, 5.0),
            ),
          ],
        ),
        child: Text(
          "Lets Get Started",
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
        padding: EdgeInsets.only(top: 25.0,left: 25.0),
      );
  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }
}
