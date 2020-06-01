import 'package:flutter/material.dart';
import 'package:tiktok_clone/pages/following_page.dart';
import 'package:tiktok_clone/widgets/home/controls/onscreen_controls.dart';
import 'package:tiktok_clone/widgets/home/home_video_renderer.dart';
import 'package:tiktok_clone/utils/apis.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List videos = List();
  List users = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future<List> future = getVideos();
    future
        .then((value) => setState(() {
              videos = value[0];
              users = value[1];
            }))
        .catchError((onError) => print(onError));
  }

  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return FollowingScreen();
        } else {
          return (videos.length != 0 && users.length != 0)
              ? PageView.builder(
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, position) {
                    return Container(
                      color: Colors.black,
                      child: Stack(
                        children: <Widget>[
                          AppVideoPlayer(videos[position]),
                          onScreenControls(
                              MediaQuery.of(context).size.width,
                              users[position]['login']['username'],
                              videos[position]['subtitle'],
                              videos[position]['description'],
                              users[position]['picture']['thumbnail']),
                        ],
                      ),
                    );
                  },
                  itemCount: videos.length)
              : Container();
        }
      },
      itemCount: 2,
      loop: false,
    );
  }
}
