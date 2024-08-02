import 'package:flutter/material.dart';
import 'package:numeral/numeral.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:ytclone/screens/player.dart';
import 'package:ytclone/services/yt_services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  YtServices obj = YtServices();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List data;
    return Scaffold(
      body: Container(
        child: FutureBuilder(
            future: obj.getHttp(),
            builder: (context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                data = snapshot.data["items"];
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      ...data.map((element) {
                        return Card(
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (c) =>
                                          Player(element["id"],element)));
                                },
                                child: Image.network(element["snippet"]
                                    ["thumbnails"]["high"]["url"]),
                              ),
                              Row(
                                children: [
                                  const CircleAvatar(),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      element["snippet"]["title"],
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 50,
                                  ),
                                  Text(element["snippet"]["channelTitle"]),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(timeago
                                      .format(DateTime.parse(
                                          element["snippet"]["publishedAt"]))
                                      .toString()),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                      "${Numeral(int.parse(element["statistics"]["viewCount"])).beautiful} views"),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        );
                      })
                    ],
                  ),
                );
              }
              return const CircularProgressIndicator();
            }),
      ),
    );
  }
}
