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
  var _playedValue;
  var _bufferedValue;

  @override
  void initState() {
    _controller = VideoPlayerController.network(widget.videoData['sources'][0]);
    _controller.play();
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.addListener(positionListener);
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

  void positionListener() {
    int _totalDuration = _controller.value.duration?.inMilliseconds;
    print("positionListener duration: $_totalDuration");
    if (mounted && _totalDuration != null && _totalDuration != 0) {
      setState(() {
        _playedValue =
            _controller.value.position.inMilliseconds / _totalDuration;
        _bufferedValue = _controller.value.buffered;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: playVideo,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: <Widget>[
            Expanded(
              child: Stack(children: <Widget>[
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
                      return Center(
                          child: Image.network(widget.videoData['thumb']));
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
            Padding(
              padding: EdgeInsets.only(bottom: 50),
              child: SizedBox(
                height: 1,
                child: LinearProgressIndicator(
                  value: _playedValue,
                  backgroundColor: Colors.white10,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.removeListener(positionListener);
    _controller.dispose();
  }
}
