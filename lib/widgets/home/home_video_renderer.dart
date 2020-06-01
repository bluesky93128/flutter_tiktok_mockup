import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AppVideoPlayer extends StatefulWidget {
  var videoData;

  AppVideoPlayer(data) {
    videoData = data;
  }
  @override
  _AppVideoPlayerState createState() => _AppVideoPlayerState();
}

class _AppVideoPlayerState extends State<AppVideoPlayer> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.network(
        widget.videoData['sources'][0]);
    _controller.play();
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    super.initState();
  }

  void playVideo() {
    setState(() {
      // If the video is playing, pause it.
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        // If the video is paused, play it.
        _controller.play();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: playVideo,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(children: <Widget>[
          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Center(
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: Center(child: VideoPlayer(_controller)),
                  ),
                );
              } else {
                return Center(child: Image.network(widget.videoData['thumb']));
              }
            },
          ),
          Center(
            child: !_controller.value.isPlaying
                ? Icon(
                    Icons.play_arrow,
                    size: 100,
                    color: Colors.white70,
                  )
                : Container(),
          ),
        ]),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
