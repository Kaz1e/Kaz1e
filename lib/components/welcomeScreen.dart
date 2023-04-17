import 'package:flutter/material.dart';
import 'package:x6/auth/loginScreen.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:x6/auth/singup.dart';

class UpperwelcomeScreen extends StatefulWidget {
  const UpperwelcomeScreen({Key key}) : super(key: key);

  @override
  State<UpperwelcomeScreen> createState() => UpperwelcomeScreenState();
}

class UpperwelcomeScreenState extends State<UpperwelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/new/background.png"),
                fit: BoxFit.fitHeight)),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 90,
                width: 100,
                child: Image.asset(
                  "assets/logo.png",
                  fit: BoxFit.fitHeight,
                ),
              ),
              Lottie.asset(
                'assets/json/walkinglady.json',
                height: 210,
                width: 300,
              ),
              // Text(
              //   'Welcome',
              //   style: TextStyle(
              //     fontWeight: FontWeight.bold,
              //     fontSize: 30,
              //     color: Colors.white.withOpacity(0.8),
              //   ),
              // ),
              Expanded(
                flex: 0,
                child: Container(
                  margin: const EdgeInsets.only(left: 40, right: 40, top: 20),
                  child: Text(
                    'Энэхүү аппликейшныг +21 нас хүрсэн бол ашиглана. ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontWeight: FontWeight.w900,
                      // height: 1.5,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              // SizedBox(
              //   height: 135,
              // ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      backgroundColor: Colors.purple,
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width / 3.3,
                          vertical: 20)
                      // padding: EdgeInsets.only(
                      //     left: 120, right: 120, top: 20, bottom: 20),
                      ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeftPop,
                            child: UpperloginScreen(),
                            childCurrent: UpperwelcomeScreen()));
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => Home(),
                    //   ),
                    // );
                  },
                  child: Text(
                    'Нэвтрэх',
                    style: TextStyle(fontSize: 17),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Бүртгэлтэй юу ?',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => SignUp()));
                    },
                    child: Text(
                      'Бүртгүүлэх',
                      style: TextStyle(
                          color: Colors.purple, fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
