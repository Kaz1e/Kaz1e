import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';

import 'testvideo/LandscapePlayerPage.dart';

Map mapResponse;
List dataResponse;
List videoResponse;

const baseUrl = "http://66.181.175.235:6969/assets/images/xGallery/";

String getVideoUrl(String path) => "$baseUrl$path";

class BumbleBeeRemoteVideo extends StatefulWidget {
  final token;
  BumbleBeeRemoteVideo(this.token);
  @override
  BumbleBeeRemoteVideoState createState() => BumbleBeeRemoteVideoState();
}

class BumbleBeeRemoteVideoState extends State<BumbleBeeRemoteVideo> {
  List<VideoData> videos;

  VideoData selectedVideo;

  VideoPlayerController _controller;

  bool get videoPlayerInitialized => _controller?.value?.isInitialized ?? false;

  @override
  void initState() {
    videos = [];
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => apicall());
  }

  Future<void> playVideo(VideoData video) async {
    if (_controller != null) {
      _controller.dispose();
      _controller = null;
    }

    selectedVideo = video;

    _controller = VideoPlayerController.network(
      getVideoUrl(video.video),
      videoPlayerOptions: VideoPlayerOptions(
          allowBackgroundPlayback: false, mixWithOthers: true),
    )..initialize().then((_) {
        setState(() {
          videoPlayerInitialized == !videoPlayerInitialized;
          _controller..setLooping(true);
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back),
          ),
          centerTitle: true,
          title: Text(
            "X Video",
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
          child: Column(
            children: [
              if (videoPlayerInitialized)
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(padding: EdgeInsets.only(top: 5)),
                      Container(
                        child: AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: VideoPlayer(
                                  _controller,
                                ),
                              ),
                              ClosedCaption(
                                  text: _controller.value.caption.text),
                              _ControlsOverlay(
                                isPlaying: _controller.value.isPlaying,
                                onPressed: () {
                                  setState(() {
                                    _controller.value.isPlaying
                                        ? _controller.pause()
                                        : _controller.play();
                                  });
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: VideoProgressIndicator(_controller,
                                    colors: VideoProgressColors(
                                        playedColor: Colors.red),
                                    allowScrubbing: true),
                              ),
                              Positioned(
                                right: 10,bottom: 5,
                                child: Container(
                                      child: IconButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) =>
                                                LandscapePlayerPage(
                                                    controller: _controller),
                                          ));
                                        },
                                        icon: const Icon(
                                          Icons.fullscreen,
                                          color: Colors.white,
                                          size: 40,
                                        ),
                                      ),
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              SizedBox(
                height: 20,
              ),
              Divider(height: 1.5, color: Colors.grey),
              Expanded(
                child: ListView.builder(
                    itemCount: videos.length,
                    // scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      final video = videos[index];
                      return SizedBox(
                        height: size.height * 0.12,
                        child: Column(
                          children: [
                            ListTile(
                              tileColor: Colors.red.withOpacity(0.7),
                              onTap: selectedVideo?.id == video.id
                                  ? null
                                  : () => playVideo(video),
                              leading: selectedVideo?.id == video.id
                                  ? Icon(
                                      Icons.play_arrow,
                                      color: Colors.white,
                                      size: 30,
                                    )
                                  : SizedBox.shrink(),
                              title: Padding(
                                padding: const EdgeInsets.all(7.0),
                                child: Text(
                                  "${video.video.substring(11, video.video.length - 4)}",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 117, 114, 115),
                                      fontSize: 15),
                                ),
                              ),
                              // subtitle: Padding(
                              //   padding: const EdgeInsets.all(5.0),
                              //   child: Text(
                              //     "1",
                              //     style: TextStyle(color: Colors.white70),
                              //   ),
                              // ),
                            ),
                            Divider(height: 1.5, color: Colors.grey),
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future apicall() async {
    http.Response response;
    response = await http.get(
        Uri.parse(
          "http://66.181.175.235:6969/api/v1/xVideo",
        ),
        headers: {
          "X-Requested-With": "XMLHttpRequest",
          'Content-Type': 'application/json',
          "Authorization": "Bearer ${widget.token}"
        });
    if (response.statusCode == 200) {
      print(response.statusCode);
      final mapResponse = jsonDecode(response.body);
      final dataResponse = mapResponse['xVideo'];

      if (dataResponse != null && dataResponse is List) {
        setState(() {
          videos = dataResponse.map((e) => VideoData.fromMap(e)).toList();
        });
        if (videos.length > 0) {
          playVideo(videos.first);
        }
      }
    }
  }
}

class _ControlsOverlay extends StatelessWidget {
  final bool isPlaying;
  final VoidCallback onPressed;

  const _ControlsOverlay(
      {Key key, @required this.isPlaying, @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: isPlaying
              ? SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                      semanticLabel: 'Play',
                    ),
                  ),
                ),
        ),
        GestureDetector(onTap: onPressed),
      ],
    );
  }
}

class VideoData {
  final String id;
  final String video;
  VideoData({
    @required this.id,
    @required this.video,
  });

  VideoData copyWith({
    String id,
    String video,
  }) {
    return VideoData(
      id: id ?? this.id,
      video: video ?? this.video,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'video': video,
    };
  }

  factory VideoData.fromMap(Map<String, dynamic> map) {
    return VideoData(
      id: "${map['xGallId']}" ?? '',
      video: "${map['xGallName']}" ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory VideoData.fromJson(String source) =>
      VideoData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'VideoData(id: $id, video: $video,)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VideoData && other.id == id && other.video == video;
  }

  @override
  int get hashCode {
    return id.hashCode ^ video.hashCode;
  }
}
