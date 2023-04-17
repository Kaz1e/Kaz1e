// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:x6/auth/appstate.dart';
import 'package:x6/components/sanamj.dart';
import 'package:x6/components/soninhachin.dart';
import 'package:x6/components/welcomeScreen.dart';
import 'package:x6/testvideo/testv1.dart';

import 'Xgallery.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double value = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final appState = Provider.of<AppState>(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 128, 8, 92),
                    Color.fromARGB(255, 29, 72, 153),
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
              ),
            ),
            SafeArea(
                child: Container(
              width: 270,
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: Image.asset(
                      "assets/logo.png",
                      height: 70,
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Sanamj(),
                        ),
                      );
                    },
                    leading: const Icon(
                      Icons.dangerous_outlined,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Санамж",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: const Icon(
                      Icons.security_sharp,
                      color: Colors.white,
                    ),
                    title: const Text(
                      "Үйлчилгээний нөхцөл",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      print(appState.token);
                    },
                    leading: const Icon(
                      Icons.verified_user_outlined,
                      color: Colors.white,
                    ),
                    title: const Text(
                      "VIP Гишүүнчлэл",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  // ListTile(
                  //   onTap: () {},
                  //   leading: const Icon(
                  //     Icons.self_improvement,
                  //     color: Colors.white,
                  //   ),
                  //   title: const Text(
                  //     "Page4",
                  //     style: TextStyle(fontSize: 16, color: Colors.white),
                  //   ),
                  // ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => UpperwelcomeScreen(),
                        ),
                      );
                    },
                    leading: const Icon(
                      Icons.exit_to_app,
                      color: Colors.white,
                    ),
                    title: const Text(
                      "Гарах",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            )),
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: value),
              duration: const Duration(milliseconds: 500),
              builder: (_, double val, __) {
                return (Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..setEntry(0, 3, 300 * val)
                    ..rotateY((3.14 / 6) * val),
                  child: Scaffold(
                    body: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(
                              "assets/new/background.png",
                            ),
                          ),
                        ),
                        child: ListView(
                          children: [
                            ListTile(
                              leading: InkWell(
                                onTap: () {
                                  setState(() {
                                    value == 0 ? value = 1 : value = 0;
                                  });
                                },
                                child: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      // color: Colors.pink[900]
                                    ),
                                    child: const Icon(
                                      Icons.menu,
                                      size: 35,
                                      color: Color.fromARGB(255, 218, 248, 107),
                                    )),
                              ),
                              title: SizedBox(
                                height: 90,
                                width: 30,
                                child: Image.asset(
                                  "assets/logo.png",
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              trailing: Container(
                                margin: const EdgeInsets.only(top: 8),
                                child: const Icon(
                                  Icons.notification_add_sharp,
                                  size: 35,
                                  color: Color.fromARGB(255, 218, 248, 107),
                                ),
                              ),
                            ),
                            Container(
                              height: size.height * 0.04,
                            ),
                            Container(
                              // color: Colors.black,
                              height: size.height * 0.8,
                              child: GridView.count(
                                scrollDirection: Axis.vertical,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 20,
                                crossAxisCount: 3,
                                semanticChildCount: 2,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 15, top: 5),
                                    child: Stack(children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: InkWell(
                                          child: Image.asset(
                                            "assets/new/gallery.png",
                                            fit: BoxFit.cover,
                                            height: 150,
                                            width: 150,
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Xgallery(
                                                            appState.token)));
                                          },
                                        ),
                                        margin: EdgeInsets.only(
                                            left: 15, right: 15, bottom: 25),
                                        height: size.height * 0.20,
                                        width: size.width * 0.22,
                                      ),
                                      Positioned(
                                          bottom: 0,
                                          left: size.width * 0.07,
                                          child: const Text(
                                            "X Gallery",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white),
                                          ))
                                    ]),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 15, top: 5),
                                    child: Stack(children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: InkWell(
                                          child: Image.asset(
                                            "assets/new/video.png",
                                            fit: BoxFit.fitHeight,
                                            height: 90,
                                            width: 130,
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    Testv1(appState.token),
                                                // Lolo(appState.token),
                                                // BumbleBeeRemoteVideo(
                                                //     appState.token),
                                              ),
                                            );
                                          },
                                        ),
                                        margin: EdgeInsets.only(
                                            left: 15, right: 15, bottom: 15),
                                        height: size.height * 0.10,
                                      ),
                                      Positioned(
                                          bottom: 0,
                                          left: size.width * 0.08,
                                          child: const Text(
                                            "X Video",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white),
                                          ))
                                    ]),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 15, top: 5),
                                    child: Stack(children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: InkWell(
                                          child: Image.asset(
                                            "assets/new/headset.png",
                                            fit: BoxFit.cover,
                                            height: 150,
                                            width: 150,
                                          ),
                                          onTap: () {},
                                        ),
                                        margin: EdgeInsets.only(
                                            left: 15, right: 15, bottom: 15),
                                        height: size.height * 0.10,
                                      ),
                                      Positioned(
                                          bottom: 0,
                                          left: size.width * 0.03,
                                          child: const Text(
                                            "X Sound /ASMR/",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white),
                                          ))
                                    ]),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 15, top: 5),
                                    child: Stack(children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: InkWell(
                                          child: Image.asset(
                                            "assets/new/lips1.png",
                                            fit: BoxFit.cover,
                                            height: 150,
                                            width: 150,
                                          ),
                                          onTap: () {
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (context) =>
                                            //             Lolo(appState.token)));
                                          },
                                        ),
                                        margin: EdgeInsets.only(
                                            left: 15, right: 15, bottom: 15),
                                        height: size.height * 0.10,
                                      ),
                                      Positioned(
                                          bottom: 0,
                                          left: size.width * 0.07,
                                          child: const Text(
                                            "X Өгүүллэг",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white),
                                          ))
                                    ]),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 15, top: 5),
                                    child: Stack(children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: InkWell(
                                          child: Image.asset(
                                            "assets/new/podcast1.png",
                                            fit: BoxFit.fitHeight,
                                            height: 150,
                                            width: 150,
                                          ),
                                          onTap: () {},
                                        ),
                                        margin: EdgeInsets.only(
                                            left: 15, right: 15, bottom: 15),
                                        height: size.height * 0.10,
                                      ),
                                      Positioned(
                                          bottom: 0,
                                          left: size.width * 0.07,
                                          child: const Text(
                                            "X Подкаст",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white),
                                          ))
                                    ]),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 15, top: 5),
                                    child: Stack(children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: InkWell(
                                          child: Image.asset(
                                            "assets/new/mail1.png",
                                            fit: BoxFit.fitWidth,
                                            height: 150,
                                            width: 150,
                                          ),
                                          onTap: () {},
                                        ),
                                        margin: EdgeInsets.only(
                                            left: 15, right: 15, bottom: 15),
                                        height: size.height * 0.10,
                                      ),
                                      Positioned(
                                          bottom: 0,
                                          left: size.width * 0.07,
                                          child: const Text(
                                            "X Захидал",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white),
                                          ))
                                    ]),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 15, top: 5),
                                    child: Stack(children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: InkWell(
                                          child: Image.asset(
                                            "assets/new/heart.png",
                                            fit: BoxFit.fitWidth,
                                            height: 150,
                                            width: 150,
                                          ),
                                          onTap: () {},
                                        ),
                                        margin: EdgeInsets.only(
                                            left: 15, right: 15, bottom: 15),
                                        height: size.height * 0.10,
                                      ),
                                      Positioned(
                                          bottom: 0,
                                          left: size.width * 0.06,
                                          child: const Text(
                                            "X Танилцах",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white),
                                          ))
                                    ]),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 15, top: 5),
                                    child: Stack(children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: InkWell(
                                          child: Image.asset(
                                            "assets/new/sonin.png",
                                            fit: BoxFit.fitHeight,
                                            height: 150,
                                            width: 150,
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Xsonin(),
                                              ),
                                            );
                                          },
                                        ),
                                        margin: EdgeInsets.only(
                                            left: 15, right: 15, bottom: 15),
                                        height: size.height * 0.10,
                                      ),
                                      Positioned(
                                          bottom: 0,
                                          left: size.width * 0.06,
                                          child: const Text(
                                            "X Сонин хачин",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white),
                                          ))
                                    ]),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 15, top: 5),
                                    child: Stack(children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: InkWell(
                                          child: Image.asset(
                                            "assets/new/room.png",
                                            fit: BoxFit.fitHeight,
                                            height: 150,
                                            width: 150,
                                          ),
                                          onTap: () {},
                                        ),
                                        margin: EdgeInsets.only(
                                            left: 15, right: 15, bottom: 15),
                                        height: size.height * 0.10,
                                      ),
                                      Positioned(
                                          bottom: 0,
                                          left: size.width * 0.1,
                                          child: const Text(
                                            "X Room",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white),
                                          ))
                                    ]),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 15, top: 5),
                                    child: Stack(children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: InkWell(
                                          child: Image.asset(
                                            "assets/new/diamond1.png",
                                            fit: BoxFit.fitHeight,
                                            height: 90,
                                            width: 130,
                                          ),
                                          onTap: () {},
                                        ),
                                        margin: EdgeInsets.only(
                                            left: 15, right: 15, bottom: 15),
                                        height: size.height * 0.10,
                                      ),
                                      Positioned(
                                          bottom: 0,
                                          left: size.width * 0.13,
                                          child: const Text(
                                            "VIP",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white),
                                          ))
                                    ]),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 15, top: 5),
                                    child: Stack(children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: InkWell(
                                          child: Image.asset(
                                            "assets/new/cart.png",
                                            fit: BoxFit.fitHeight,
                                            height: 90,
                                            width: 130,
                                          ),
                                          onTap: () {},
                                        ),
                                        margin: EdgeInsets.only(
                                            left: 15, right: 15, bottom: 15),
                                        height: size.height * 0.12,
                                      ),
                                      Positioned(
                                          bottom: 0,
                                          left: size.width * 0.09,
                                          child: const Text(
                                            "Sex Shop",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white),
                                          ))
                                    ]),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 15, top: 5),
                                    child: Stack(children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: InkWell(
                                          child: Image.asset(
                                            "assets/new/live.png",
                                            fit: BoxFit.fitHeight,
                                            height: 90,
                                            width: 130,
                                          ),
                                          onTap: () {},
                                        ),
                                        margin: EdgeInsets.only(
                                            left: 15, right: 15, bottom: 15),
                                        height: size.height * 0.10,
                                      ),
                                      Positioned(
                                          bottom: 0,
                                          left: size.width * 0.11,
                                          child: const Text(
                                            "X Live",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white),
                                          ))
                                    ]),
                                  )
                                ],
                              ),
                            )
                          ],
                        )),
                  ),
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
