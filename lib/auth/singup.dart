import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:x6/auth/loginScreen.dart';
import 'package:x6/auth/userinfo.dart';
import 'package:x6/widget/widget.dart';
import 'package:http/http.dart' as http;

import '../widget/btn_widget.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final usernameController = TextEditingController();

  final genderController = TextEditingController();

  final passController = TextEditingController();

  final passwordConfirmationController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  _Gender gender;
  // List<_Gender> listItem = ["Эмэгтэй", "Эрэгтэй", "Бусад"]
  //     .asMap()
  //     .map((index, value) => MapEntry(index, _Gender(index, value)))
  //     .values
  //     .toList();

  List<_Gender> listItem = [
    _Gender(label: "Эмэгтэй", value: 1),
    _Gender(label: "Эрэгтэй", value: 2),
    _Gender(label: "Бусад", value: 0),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/background.png",
                ),
                fit: BoxFit.cover)),
        child: Form(
          key: formKey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: Text(
                      "Шинэ хэрэглэгч",
                      style: TextStyle(color: Colors.white, fontSize: 26),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  username(usernameController),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1),
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DropdownButton(
                              dropdownColor: Color.fromARGB(255, 40, 4, 46),
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 36,
                              hint: Text(
                                "Хүйс: ",
                                style: TextStyle(color: Colors.white),
                              ),
                              isExpanded: true,
                              underline: SizedBox(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                              value: gender,
                              onChanged: (newValue) {
                                setState(() {
                                  gender = newValue;
                                });
                              },
                              items: listItem.map(
                                (valueItem) {
                                  return DropdownMenuItem(
                                    value: valueItem,
                                    child: Text(
                                      valueItem.label,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  password(passController),
                  SizedBox(
                    height: 5,
                  ),
                  passwordConfirmation(passwordConfirmationController),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 40, right: 40),
                    child: BWidget(
                      // splashColor: Color.fromARGB(255, 241, 74, 74),
                      // color: Color.fromARGB(255, 247, 152, 36),
                      btnText: "Бүртгүүлэх",
                      onClick: () async {
                        if (formKey.currentState?.validate() ?? false) {
                          formKey.currentState?.save();
                          String username = usernameController.text.trim();
                          String password = passController.text.trim();
                          String passwordConfirmation =
                              passwordConfirmationController.text.trim();
                          await SignUp(username, gender.value, password,
                              passwordConfirmation);
                        }

                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 40, right: 40),
                    child: BWidget(
                      // padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                      // color: Color.fromARGB(255, 247, 152, 36),
                      onClick: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UpperloginScreen()));
                      },

                      btnText: "Бүртгэлээрээ нэвтрэх",
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

  Future<Registration> SignUp(
    String username,
    int selectedValue,
    String password,
    String passwordConfirmation,
  ) async {
    var url = Uri.parse("http://66.181.175.235:6969/api/register");
    Map<String, dynamic> resultdata;
    final http.Response response = await http.post(
      url,
      headers: {
        "X-Requested-With": "XMLHttpRequest",
        'Content-Type': 'application/json'
      },
      body: json.encode({
        'name': username,
        'gender': selectedValue,
        'password': password,
        'password_confirmation': passwordConfirmation,
      }),
    );
    // print(username);
    // print(selectedValue);
    // print(password);
    // print(passwordConfirmation);

    print('${response.statusCode}');
    resultdata = json.decode(response.body);
    print(resultdata);

    if (resultdata['status'] == 200) {
      Registration.fromJson(json.decode(response.body));
      Fluttertoast.showToast(
          msg: "Амжилттай",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      return Navigator.push(
          context, MaterialPageRoute(builder: (context) => UpperloginScreen()));
    } else {
      Fluttertoast.showToast(
          msg: resultdata['Нууц үг 8 оронтой байна'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}

class _Gender {
  final int value;
  final String label;

  _Gender({this.value, this.label});
}
