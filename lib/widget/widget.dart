// ignore_for_file: missing_return

import 'package:flutter/material.dart';

Widget username(usernameController) {
  return Container(
    margin: EdgeInsets.only(left: 20, right: 20),
    decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.white))),
    child: TextFormField(
      style: TextStyle(color: Colors.white),
      controller: usernameController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Хэрэглэгчийн нэрээ оруулна уу';
        }
      },
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.person,
            color: Colors.white,
          ),
          border: InputBorder.none,

          hintStyle: TextStyle(color: Colors.white),
          hintText: '  Нэр '),
    ),
  );
}

Widget lastName(lastnameController) {
  return Container(
    margin: EdgeInsets.only(left: 20, right: 20),
    decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.brown[300]))),
    child: TextFormField(
      style: TextStyle(color: Colors.white),
      controller: lastnameController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Хэрэглэгчийн овог оруулна уу';
        }
      },
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.person,
            color: Colors.white,
          ),
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.white),
          hintText: '  Овог'),
    ),
  );
}

Widget password(passController) {
  return Container(
    margin: EdgeInsets.only(left: 20, right: 20),
    decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.brown[300]))),
    child: TextFormField(
        style: TextStyle(color: Colors.white),
        controller: passController,
        obscureText: true,
        validator: (value) {
          if (value.isEmpty) {
            return 'нууц үгээ оруулна уу';
          }
        },
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.vpn_key,
              color: Colors.white,
            ),
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white),
            hintText: "  Нууц үг")),
  );
}

Widget passwordConfirmation(passController) {
  return Container(
    margin: EdgeInsets.only(left: 20, right: 20),
    decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.brown[300]))),
    child: TextFormField(
        style: TextStyle(color: Colors.white),
        controller: passController,
        obscureText: true,
        validator: (value) {
          if (value.isEmpty) {
            return ' нууц үгээ давтан оруулна уу';
          }
        },
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.vpn_key,
              color: Colors.white,
            ),
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white),
            hintText: "  Нууц үгээ бататгана уу")),
  );
}

Widget gender(genderController) {
  return Container(
    margin: EdgeInsets.only(left: 20, right: 20),
    decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.brown[300]))),
    child: TextFormField(
        style: TextStyle(color: Colors.white),
        controller: genderController,
        validator: (value) {
          if (value.isEmpty) {
            return 'Хүйсээ оруулна уу';
          }
        },
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white),
            hintText: "  Хүйс")),
  );
}

Widget register(registerController) {
  return Container(
    margin: EdgeInsets.only(left: 20, right: 20),
    decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.brown[300]))),
    child: TextFormField(
        style: TextStyle(color: Colors.white),
        controller: registerController,
        validator: (value) {
          if (value.isEmpty) {
            return 'Регистрийн дугаар оруулна уу';
          }
        },
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.numbers,
              color: Colors.white,
            ),
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white),
            hintText: "  Регистрийн дугаар")),
  );
}

Widget register1(registerController1) {
  return Container(
    margin: EdgeInsets.only(left: 20, right: 20),
    decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.brown[300]))),
    child: TextFormField(
      style: TextStyle(color: Colors.white),
      controller: registerController1,
      validator: (value) {
        if (value.isEmpty) {
          return 'Мэдээлэлээ оруулна уу';
        }
      },
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.newspaper,
            color: Colors.white,
          ),
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.white),
          hintText: "  Шинэ мэдээлэл оруулах"),
    ),
  );
}
// Widget phone(phoneController) {
//   return Container(
//     margin: EdgeInsets.only(left: 20, right: 20),
//     decoration: BoxDecoration(
//         border: Border(bottom: BorderSide(color: Colors.brown[300]))),
//     child: TextFormField(

//       style: TextStyle(color: Colors.white),
//       controller: phoneController,
//       validator: (value) {
//         if (value.isEmpty) {
//           return 'Утасны дугаараа оруулна уу';
//         }
//       },
//       decoration: InputDecoration(
//         prefixIcon: Icon(Icons.phone,color: Colors.white,),
//           border: InputBorder.none,
//           hintStyle: TextStyle(color: Colors.white),
//           hintText: '  Утасны дугаар'),
//     ),
//   );
// }

Widget email(emailController) {
  return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.brown[300]))),
      child: Column(children: [
        TextFormField(
          textInputAction: TextInputAction.next,
          style: TextStyle(color: Colors.white),
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value.isEmpty) {
              return 'И-мэйлээ оруулна уу';
            }
          },
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.white),
              hintText: "  И-мэйл"),
        ),
      ]));
}
