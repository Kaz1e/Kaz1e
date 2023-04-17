// ignore_for_file: missing_return

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:x6/auth/appstate.dart';
import 'package:provider/provider.dart';

import 'package:x6/components/menu.dart';

class UpperloginScreen extends StatefulWidget {
  const UpperloginScreen({Key key}) : super(key: key);

  @override
  State<UpperloginScreen> createState() => UpperloginScreenState();
}

class UpperloginScreenState extends State<UpperloginScreen> {
  TextEditingController nameController = TextEditingController(text: "test");

  TextEditingController passController =
      TextEditingController(text: "test12345");

  @override
  void dispose() {
    nameController.clear();
    passController.clear();
    super.dispose();
  }

  bool isNameCorrect = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          // color: Colors.red.withOpacity(0.1),
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(
              "assets/new/background.png",
            ),
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/json/71023-lock-animation.json',
                    animate: true,
                    height: 150,
                    width: 500,
                  ),
                  Text(
                    'Нэвтрэх',
                    style: GoogleFonts.indieFlower(
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.white),
                    ),
                  ),
                  Text(
                    '+21',
                    style: GoogleFonts.indieFlower(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    height: isNameCorrect ? 280 : 200,
                    width: MediaQuery.of(context).size.width / 1.09,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 20, top: 20),
                          child: TextFormField(
                            controller: nameController,
                            onChanged: (val) {
                              setState(() {
                                if (nameController.text.isEmpty) {
                                  isNameCorrect = false;
                                } else {
                                  isNameCorrect = true;
                                }
                              });
                            },
                            decoration: const InputDecoration(
                              fillColor: Colors.white,
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.purple,
                              ),
                              filled: true,
                              hintText: 'Нэвтрэх нэр',
                              labelStyle: TextStyle(
                                color: Colors.purple,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                              controller: passController,
                              obscuringCharacter: '*',
                              obscureText: true,
                              decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.purple,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                labelText: "Нууц үг",
                                hintText: '*********',
                                labelStyle: TextStyle(color: Colors.purple),
                              ),
                              validator: (value) {
                                if (value.isEmpty && value.length < 8) {
                                  return 'Enter a valid password';
                                }
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        isNameCorrect
                            ? ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    backgroundColor: isNameCorrect == false
                                        ? Colors.red
                                        : Colors.purple,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 131, vertical: 20)),
                                onPressed: () {
                                  login(appState);
                                },
                                child: Text(
                                  'Нэвтрэх',
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.white),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<http.Response> login(AppState appState) async {
    var url = Uri.parse("http://66.181.175.235:6969/api/login");
    final http.Response response = await http.post(
      url,
      headers: {
        "X-Requested-With": "XMLHttpRequest",
        'Content-Type': 'application/json'
      },
      body: json.encode({
        'name': nameController.text,
        'password': passController.text,
      }),
    );

    // print(name);
    // print(selectedValue);
    // print(password);
    // print(passwordConfirmation);

    print('${response.statusCode}');

    print("pzdadad ${response.body}");

    if (response.statusCode == 200) {
      var resuldata = jsonDecode(response.body);
      appState.setToken(resuldata['token']);
      print("resultdata--> $resuldata");
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
      Fluttertoast.showToast(
          msg: "Амжилттай нэвтэрлээ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Нууц үг эсвэл нэвтрэх нэр буруу байна.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 14.0);
    }
  }
}
