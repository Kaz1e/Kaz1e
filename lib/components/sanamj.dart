import 'package:flutter/material.dart';

// void main() {
//   runApp( HellePo());
// }

void main() {
  runApp(
    const Sanamj(),
  );
}

class Sanamj extends StatelessWidget {
  const Sanamj({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Санамж",
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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/new/background.png"),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(
                left: 15,
                top: 35,
                right: 10,
              ),
              child: Text(
                "1. Тус аппликейшн нь зөвхөн насанд хүрэгчдэд зориулсан аппликейшн учир 21-ээс дээш насны хэрэглэгч хэрэглэхийг онцгой анхаарна уу. Иймд насанд хүрээгүй хүүхэд болон уг насны хязгаарлалтаас доош насны хүнийг тус аппликейшныг хэрэглүүлэхгүй байх тал дээр эцэг, эх, асран хамгаалагч нар онцгой анхаарна уу.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: 15,
                top: 35,
                right: 10,
              ),
              child: Text(
                "2.	Хэрэглэгч тус аппликейшныг ашиглахтай холбоотой өөрөөс шалтгаалах хувь хүний нууцлал, аюулгүй байдлыг хамгаалах, хангах үүрэг хүлээнэ.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: 15,
                top: 35,
                right: 10,
              ),
              child: Text(
                "3.	Дээрх санамжийг даган биелүүлээгүйн улмаас өөрт болон бусдад учирсан аливаа эрсдэл, хохирол, хариуцлагыг хэрэглэгч дангаараа хариуцах бөгөөд тус аппликейшныг эзэмшигч МБЗ Софт ХХК хариуцахгүй болно .",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: 15,
                top: 35,
                right: 10,
                bottom: 20,
              ),
              child: Text(
                "4. Хэрэглэгч нууц үгээ мартсан тохиолдолд сэргээх боломжгүй ба шинээр бүртгэл үүсгэх шаардлагатай.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
