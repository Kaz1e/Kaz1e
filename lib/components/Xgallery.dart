// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:x6/details/detials_page.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class Xgallery extends StatefulWidget {
  var token;
  Xgallery(this.token);
  @override
  State<Xgallery> createState() => _XgalleryState();
}

class _XgalleryState extends State<Xgallery> {
  Map resultData;
  List item;
  bool isItem = false;
  Future<http.Response> getData() async {
    var url = Uri.parse('http://66.181.175.235:6969/api/v1/xGallery');

    var response = await http.get(
      url,
      headers: {
        "X-Requested-With": "XMLHttpRequest",
        'Content-Type': 'application/json',
        "Authorization": "Bearer ${widget.token}",
      },
    );
    print(widget.token);
    if (response.statusCode == 200) {
      var resultData = jsonDecode(response.body);
      item = resultData['xPhoto'];
      setState(() {
        isItem = true;
      });

      print(item);
      print(item.length);
    }
    return response;
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController controller = ScrollController();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          size: 28,
          color: Colors.white,
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 177, 45, 230),
        title: Text(
          'X Gallery',
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                      "assets/new/background.png",
                    ),
                  ),
                  // borderRadius: BorderRadius.only(
                  //   topLeft: Radius.circular(10),
                  //   topRight: Radius.circular(10),
                  // ),
                ),
                child: isItem
                    ? RawScrollbar(
                        thumbColor: Colors.white.withOpacity(0.5),
                        radius: Radius.circular(0.8),
                        interactive: true,
                        controller: controller,
                        child: GridView.builder(
                          controller: controller,
                          itemCount: item?.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (_, index) {
                            var item1 = item[index];
                            return Container(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ImagePageBuilder(
                                                items: item,
                                                initialIndex: index,
                                              )));
                                },
                                child: Image.network(
                                    'http://66.181.175.235:6969/assets/images/xGallery/${item1['xGallName']}'),
                              ),
                            );
                          },
                        ),
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// class ImageDetails {
//   String xGallName;

//   ImageDetails({
//     this.xGallName,
//   });
// }
// InkWell(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => DetailsPage(
//                               xGallName: item1['xGallName'],
//                               index: item1['xGallId'],
//                             ),
//                           ),
//                         );
//                       },
//                       child: Hero(
//                         tag: 'logo${item1['xGallId']}',
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(15),
//                             image: DecorationImage(
//                               image: NetworkImage("http://66.181.175.235:6969/api/v1/xGallery/"+item1['xGallName']),
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                       ),
//                     );