// // ignore_for_file: must_be_immutable

// import 'package:flutter/material.dart';

// class DetailsPage extends StatelessWidget {
//   String xGallName;
//   int index;
//   DetailsPage({
//     this.xGallName,
//     this.index,
//   });
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Container(
//         child: Column(
//           children: <Widget>[
//             Expanded(
//               child: Hero(
//                 tag: 'logo$index',
//                 child: Container(
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: NetworkImage(
//                           'http://66.181.175.235:6969/assets/images/xGallery/$xGallName'),
//                       fit: BoxFit.fitWidth,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:x6/components/image.dart';

class ImagePageBuilder extends StatefulWidget {
  final List items;
  final int initialIndex;

  const ImagePageBuilder(
      {Key key, @required this.items, @required this.initialIndex})
      : super(key: key);

  @override
  State<ImagePageBuilder> createState() => _ImagePageBuilderState();
}

class _ImagePageBuilderState extends State<ImagePageBuilder> {
  PageController _pageController;
  bool _showAppBar = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _showAppBar
          ? AppBar(
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
            )
          : null,
      body: GestureDetector(
        onTap: () {
          setState(() {
            _showAppBar = !_showAppBar;
          });
        },
        child: Container(
          color: Colors.black,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.items.length,
            itemBuilder: (context, index) {
              return Container(
                  alignment: Alignment.center,
                  child: ImageViwer(
                    image:
                        'http://66.181.175.235:6969/assets/images/xGallery/${widget.items[index]['xGallName']}',
                  ));
            },
          ),
        ),
      ),
    );
  }
}
