import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:x6/components/welcomeScreen.dart';

class Splash extends StatefulWidget {
  const Splash({Key key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 3000), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => UpperwelcomeScreen()));
    });
    controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    )..repeat();
    animation = Tween<double>(begin: 0, end: 2 * pi).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/new/background.png"),
                fit: BoxFit.fitHeight)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
                child: Image.asset(
                  "assets/logo.png",
                  height: 200,
                  width: 200,
                ),
                animation: animation,
                builder: (context, child) => Transform.rotate(
                      angle: animation.value,
                      child: child,
                    )),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Text(
                "Зөвхөн насанд хүрэгчдэд зориулсан үйлчилгээ",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
