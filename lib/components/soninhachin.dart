//let's start by our home screen
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:x6/components/breaking_news_card.dart';
import 'package:x6/components/news_list_tile.dart';
import 'package:x6/models/news_model.dart';

class Xsonin extends StatefulWidget {
  const Xsonin({Key key}) : super(key: key);

  @override
  State<Xsonin> createState() => XsoninState();
}

class XsoninState extends State<Xsonin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //let's start with the Appbar
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "X Сонин Хачин",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromARGB(255, 128, 8, 92),
            Color.fromARGB(255, 29, 72, 153),
          ])),
        ),
      ),

      //Let's now work on the body
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/new/background.png"),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Шинэ мэдээ",
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                //let's build our caroussel
                CarouselSlider.builder(
                    itemCount: NewsData.breakingNewsData.length,
                    itemBuilder: (context, index, id) =>
                        BreakingNewsCard(NewsData.breakingNewsData[index]),
                    options: CarouselOptions(
                      aspectRatio: 16 / 9,
                      enableInfiniteScroll: false,
                      enlargeCenterPage: true,
                    )),
                SizedBox(
                  height: 40.0,
                ),
                Text(
                  "Сүүлийн үеийн мэдээ",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                //now let's create the cards for the recent news
                Column(
                  children: NewsData.recentNewsData
                      .map((e) => NewsListTile(e))
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    //Now let's create the button navigation bar
    //   bottomNavigationBar: Container(
    //     // let's make our button nav bar float
    //     margin: EdgeInsets.all(12),
    //     decoration: BoxDecoration(
    //       color: Colors.black,
    //       borderRadius: BorderRadius.circular(16),
    //     ),
    //     child: BottomNavigationBar(
    //       elevation: 0.0,
    //       selectedItemColor: Colors.orange.shade900,
    //       items: [
    //         BottomNavigationBarItem(
    //           backgroundColor: Colors.transparent,
    //           icon: Icon(Icons.home),
    //           label: "Home",
    //         ),
    //         BottomNavigationBarItem(
    //           icon: Icon(Icons.bookmark),
    //           label: "Bookmark",
    //         ),
    //         BottomNavigationBarItem(
    //           icon: Icon(Icons.rss_feed_rounded),
    //           label: "Feed",
    //         ),
    //         BottomNavigationBarItem(
    //           icon: Icon(Icons.person),
    //           label: "Profile",
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
