import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;

class BumbleBeeRemoteVideo extends StatefulWidget {
  @override
  BumbleBeeRemoteVideoState createState() => BumbleBeeRemoteVideoState();
}

class BumbleBeeRemoteVideoState extends State<BumbleBeeRemoteVideo> {
  VideoPlayerController _controller;

  Future<http.Response> getData() async {
    var url = Uri.parse('http://66.181.175.235:6969/api/v1/xVideo');

    var response = await http.get(
      url,
      headers: {
        "X-Requested-With": "XMLHttpRequest",
        'Content-Type': 'application/json',
        "Authorization": "Bearer 64|Fkg0sZMZdo2U4FdZrdQriWn0lDyZdFYRHs88Hopn"
      },
    );
    if (response.statusCode == 200) {
      // var jsonResponse = convert.jsonDecode(response.body);
      var res = response.body;

      print('Number of books about http: ${response.body}.');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return response;
  }

  // Future<ClosedCaptionFile> _loadCaptions() async {
  //   final String fileContents = await DefaultAssetBundle.of(context)
  //       .loadString('assets/images/bumble_bee_captions.vtt');
  //   return WebVTTCaptionFile(
  //       fileContents); // For vtt files, use WebVTTCaptionFile
  // }

  @override
  void initState() {
    super.initState();
    getData();
    // _controller = VideoPlayerController.network("http://66.181.175.235:6969/api/v1"
    //   '$UrlBase:8001/media/${widget.file}',
    // closedCaptionFile: _loadCaptions(),
    // videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    // );

    // _controller.addListener(() {
    //   setState(() {});
    // });
    // _controller.setLooping(true);
    // _controller.initialize();
  }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text("${widget.title}"),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 14, 67, 82),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(padding: const EdgeInsets.only(top: 20.0)),
            Container(
              padding: EdgeInsets.only(left: 40, right: 25, top: 40),
              child: Text(
                "",
                style: TextStyle(fontSize: 16),
              ),
            ),
            // Container(
            //   padding: const EdgeInsets.all(20),
            //   child: AspectRatio(
            //     // aspectRatio: _controller.value.aspectRatio,
            //     child: Stack(
            //       alignment: Alignment.bottomCenter,
            //       children: <Widget>[
            //         // VideoPlayer(_controller),
            //         // ClosedCaption(text: _controller.value.caption.text),
            //         // _ControlsOverlay(controller: _controller),
            //         // VideoProgressIndicator(_controller, allowScrubbing: true),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay({Key key, this.controller}) : super(key: key);

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? const SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: const Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                      semanticLabel: 'Play',
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),

        // Using less vertical padding as the text is also longer
        // horizontally, so it feels like it would need more spacing
        // horizontally (matching the aspect ratio of the video).
      ],
    );
  }
}
