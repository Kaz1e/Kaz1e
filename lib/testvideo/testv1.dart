import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:x6/testvideo/LandscapePlayerPage.dart';
import 'package:http/http.dart' as http;

Map mapResponse;
List dataResponse;
List videoResponse;

const baseUrl = "http://66.181.175.235:6969/assets/images/xGallery/";

String getVideoUrl(String path) => "$baseUrl$path";

class Testv1 extends StatefulWidget {
  final token;
  Testv1(this.token);

  @override
  State<Testv1> createState() => _Testv1State();
}

class _Testv1State extends State<Testv1> {
  List<VideoData> videos;

  VideoData selectedVideo;
  bool play = false;
  VideoPlayerController _controller;

  bool get videoPlayerInitialized => _controller?.value?.isInitialized ?? false;
  void initState() {
    super.initState();
    videos = [];
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
          _controller..setLooping(false);
        });
      });
  }

  String _videoDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(":");
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios),
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
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 128, 8, 92),
                  Color.fromARGB(255, 29, 72, 153),
                ],
              ),
            ),
          ),
        ),
        body: _controller == null
            ? Container()
            : Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 128, 8, 92),
                          Color.fromARGB(255, 29, 72, 153),
                        ],
                      ),
                    ),
                    height: 288,
                    child: _controller.value.isInitialized
                        ? Column(
                            children: <Widget>[
                              SizedBox(
                                height: 200,
                                child: VideoPlayer(_controller),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ValueListenableBuilder(
                                    valueListenable: _controller,
                                    builder: (context, VideoPlayerValue value,
                                        child) {
                                      return Text(
                                        _videoDuration(value.position),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      );
                                    },
                                  ),
                                  Container(
                                    child: Expanded(
                                      child: SizedBox(
                                        height: 20,
                                        child: VideoProgressIndicator(
                                          _controller,
                                          allowScrubbing: true,
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 0,
                                            horizontal: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    _videoDuration(_controller.value.duration),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          play = !play;
                                        });
                                        _controller.value.isPlaying
                                            ? _controller.pause()
                                            : _controller.play();
                                      },
                                      icon: Icon(
                                        play ? Icons.pause : Icons.play_arrow,
                                        color: Colors.white,
                                        size: 40,
                                      )),
                                  Container(
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
                                ],
                              ),
                            ],
                          )
                        : const Center(
                            child:
                                CircularProgressIndicator(color: Colors.white),
                          ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 128, 8, 92),
                            Color.fromARGB(255, 29, 72, 153),
                          ],
                        ),
                      ),
                      child: ListView.builder(
                        itemCount: videos?.length,
                        itemBuilder: (context, index) {
                          final video = videos[index];
                          return Container(
                            margin: EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.black,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 128, 8, 92),
                                    Color.fromARGB(255, 29, 72, 153),
                                  ],
                                ),
                              ),
                              margin: EdgeInsets.only(
                                  right: 2, left: 2, top: 2, bottom: 2),
                              child: ListTile(
                                tileColor: Colors.red.withOpacity(0.7),
                                onTap: selectedVideo?.id == video.id
                                    ? null
                                    : () => playVideo(video),
                                leading: selectedVideo?.id == video.id
                                    ? Icon(
                                        Icons.star,
                                        color: Colors.white,
                                        size: 30,
                                      )
                                    : SizedBox.shrink(),
                                title: Padding(
                                  padding: const EdgeInsets.all(7.0),
                                  child: Text(
                                    "${video.video.substring(11, video.video.length - 4)}",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 218, 210, 212),
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
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
    }
    final mapResponse = jsonDecode(response.body);
    final dataResponse = mapResponse['xVideo'];

    if (dataResponse != null && dataResponse is List) {
      setState(() {
        videos = dataResponse.map((e) => VideoData.fromMap(e)).toList();
      });
      print(videos);
      if (videos.length > 0) {
        playVideo(videos.first);
      }
    }
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
