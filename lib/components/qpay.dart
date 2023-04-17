// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
// import 'package:x6/auth/appstate.dart';
// import 'package:x6/auth/singup.dart';
// import 'package:x6/widget/btn_widget.dart';


// Map mapResponse;
// List dataResponse;

// class Qpay extends StatefulWidget {
//   static const routeName = 'login';

//   var dataResponse;
//   var mapResponse;
//   var token;

//   Qpay(this.dataResponse, this.mapResponse, this.token);

//   @override
//   _QpayState createState() => _QpayState();
// }

// class _QpayState extends State<Qpay> {
//   @override
//   Widget build(BuildContext context) {
//     bool isLogin;
//     Size size = MediaQuery.of(context).size;
//     final appState = Provider.of<AppState>(context);
//     isLogin = appState.getLogin();

//     Future tol() async {
//       http.Response response1;
//       var invoice = mapResponse["invoice_id"];
//       print(invoice);
//       print(mapResponse);

//       response1 = await http.get(
//         Uri.parse("http://udmiinbichig.mn:3001/api/qpay-check/$invoice"),
//         headers: {
//           "X-Requested-With": "XMLHttpRequest",
//           "Authorization": "Bearer ${widget.token}",
//         },
//       );

//       // ignore: unrelated_type_equality_checks

//       print(response1.body);
//     }

//     Future tol1() async {
//       http.Response response1;
//       var invoice = mapResponse["invoice_id"];
//       print(invoice);
//       print(mapResponse);

//       response1 = await http.get(
//         Uri.parse("http://udmiinbichig.mn:3001/api/qpay-check/$invoice"),
//         headers: {
//           "X-Requested-With": "XMLHttpRequest",
//           "Authorization": "Bearer ${widget.token}",
//         },
//       );
//       var tolb1 = response1.body;
//       if (tolb1 == "PAID") {
//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => SignUp()));
        
//       } else
        
//             Fluttertoast.showToast(
//             msg: "Төлбөр төлөгдөөгүй байна",
//             // msg:tolb1,
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.CENTER,
//             backgroundColor: Color.fromARGB(255, 218, 178, 127),
//             textColor: Colors.white);
//       // Fluttertoast.showToast(
//       //     msg: "Төлбөр төлөгдсөн байна ",
//       //     toastLength: Toast.LENGTH_SHORT,
//       //     gravity: ToastGravity.CENTER,
//       //     backgroundColor: Color.fromARGB(255, 218, 178, 127),
//       //     textColor: Colors.white);

//       // ignore: unrelated_type_equality_checks

//       print(response1.body);
//     }

//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//             image: DecorationImage(
//                 image: AssetImage(
//                   "assets/31.jpg",
//                 ),
//                 fit: BoxFit.fill)),
//         margin: EdgeInsets.only(top: 20),
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         child: Container(
//           width: size.width,
//           height: size.height,
//           child: Stack(
//             children: <Widget>[
//               isLogin == null
//                   ? Container(
//                       margin: EdgeInsets.symmetric(vertical: 10),
//                       width: MediaQuery.of(context).size.width * 0.8,
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(29),
//                         // ignore: deprecated_member_use
//                         child: InkWell(
//                           onTap: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => ()));
//                           },
//                           child: Text(
//                             'Нэвтрэх',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     )
//                   : Container(
//                       width: double.infinity,

//                       // color: Colors.orange[100],
//                       margin: EdgeInsets.only(top: 250),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           BWidget(
//                               btnText: "Төлбөр төлөх",
//                               onClick: () {
//                                 tol();
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => Banks()));
//                               }),
//                           SizedBox(
//                             height: 20,
//                           ),
//                           BWidget(
//                               btnText: "Төлбөр шалгах",
//                               onClick: () {
//                                 tol1();
//                               }),
//                           SizedBox(
//                             height: 20,
//                           ),
//                           BWidget(
//                               btnText: "Буцах",
//                               onClick: () {
//                                 Navigator.pop(context);
//                               }),
//                         ],
//                       ),
//                     ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class Banks extends StatefulWidget {
//   const Banks({Key key}) : super(key: key);

//   @override
//   State<Banks> createState() => _BanksState();
// }

// class _BanksState extends State<Banks> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: Color.fromARGB(255, 29, 33, 41),
//       body: SafeArea(
//         child: Container(
//           decoration: BoxDecoration(
//               image: DecorationImage(
//                   image: AssetImage(
//                     "assets/31.jpg",
//                   ),
//                   fit: BoxFit.fill)),
//           child: ListView(
//             children: [
//               Container(
//                 color: Colors.black,
//                 constraints: BoxConstraints.expand(height: 620),
//                 margin: EdgeInsets.only(top: 1, left: 15, right: 15),
//                 child: GridView.builder(
//                   gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//                     maxCrossAxisExtent: 200,
//                     childAspectRatio: 1,
//                   ),
//                   itemBuilder: (context, index) {
//                     return Card(
//                         child: InkWell(
//                       onTap: () {
//                         launch(
//                           dataResponse[index]["link"],
//                         );
//                       },
//                       child: Container(
//                         padding: EdgeInsets.only(top: 15),
//                         decoration: BoxDecoration(
//                             color: Colors.white30,
//                             borderRadius: BorderRadius.circular(30)),
//                         child: Stack(
//                           children: [
//                             Container(
//                               alignment: Alignment.topCenter,
//                               child: Image.network(
//                                 dataResponse[index]["logo"],
//                                 fit: BoxFit.fill,
//                                 height: 120,
//                                 width: 140,
//                               ),
//                             ),
//                             Container(
//                               alignment: Alignment.bottomCenter,
//                               padding: EdgeInsets.only(
//                                   bottom: 10, top: 100, left: 10, right: 2),
//                               child: Text(
//                                 dataResponse[index]["description"],
//                                 style: TextStyle(
//                                     fontSize: 14, color: Colors.black),
//                               ),
//                             ),

//                             // leading: Image.network(
//                             //   medee.imageUrl,
//                             //   fit: BoxFit.fill,
//                             //   height: 85,
//                             //   width: 85,
//                             // ),
//                             // trailing: Icon(
//                             //   Icons.arrow_forward_ios_rounded,
//                             //   color: Colors.pink[600],
//                             // ),
//                           ],
//                         ),
//                       ),
//                     ));
//                   },
//                   itemCount: dataResponse == null ? 0 : dataResponse.length,
//                 ),
//               ),
//               SizedBox(
//                 height: 5,
//               ),
//               Center(
//                   child: BWidget(
//                       btnText: "Буцах",
//                       onClick: () {
//                         Navigator.pop(context);
//                         // Navigator.push(context,
//                         //       MaterialPageRoute(builder: (context) => LoginPage1()));
//                       }))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
