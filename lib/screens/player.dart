import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:numeral/numeral.dart';
import 'package:timeago/timeago.dart' as timeago;

class Player extends StatefulWidget {
  String id;
  var data;
  Player(this.id, this.data);

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  late YoutubePlayerController _controller;
  String subs="Subscribe";
  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.id,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  bool _isPlayerReady = false;
  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.cast),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Card(
              child: Column(
                children: [
                  YoutubePlayer(
                    controller: _controller,
                    showVideoProgressIndicator: true,
                    onReady: () {
                      _controller.addListener(listener);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.data["snippet"]["title"],
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                          "${Numeral(int.parse(widget.data["statistics"]["viewCount"])).beautiful} views"),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(timeago
                          .format(DateTime.parse(
                              widget.data["snippet"]["publishedAt"]))
                          .toString()),
                    ],
                  ),
                   Row(
                    children: [
                     const CircleAvatar(),
                     const SizedBox(
                        width: 10,
                      ),
                      Text(widget.data["snippet"]["channelTitle"],style: TextStyle(fontWeight: FontWeight.bold),),
                      const SizedBox(
                        width: 90,
                      ),
                    ElevatedButton.icon(onPressed: (){
                      setState(() {
                        subs="Subscribed 🔔";
                      });
                    }, label: Text("$subs"),)
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
