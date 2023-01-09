import 'dart:math';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> allSongs = [
    {
      'name': 'Sooryavanshi Song',
      'images': 'images/sooryavanshi.jpeg',
      'path': 'assets/audio/Sooryavanshi.mp3',
      'player': AssetsAudioPlayer(),
      'totalDuration': Duration.zero,
    },
    {
      'name': 'Sidhu Moose Wala Song',
      'images': "images/sidhu moose wala.jpg",
      'path': 'assets/audio/Sidhu Moose wala.mp3',
      'player': AssetsAudioPlayer(),
      'totalDuration': Duration.zero,
    },
    {
      'name': 'Kidsos Song',
      'images': "images/Kidsos.jpeg",
      'path': 'assets/audio/Kidsos.mp3',
      'player': AssetsAudioPlayer(),
      'totalDuration': Duration.zero,
    },
    {
      'name': 'Club mix Song',
      'images': "images/Club mix.jpeg",
      'path': 'assets/audio/Clud Mix.mp3',
      'player': AssetsAudioPlayer(),
      'totalDuration': Duration.zero,
    },
    {
      'name': 'Breakup Song',
      'images': "images/breakup song.jpeg",
      'path': 'assets/audio/Breakup Song.mp3',
      'player': AssetsAudioPlayer(),
      'totalDuration': Duration.zero,
    },
    {
      'name': 'Ae Dil Hai Mushkil',
      'images': "images/Ae Dil Hai Mushkil.jpeg",
      'path': 'assets/audio/Ae Dil Hai Mushkil.mp3',
      'player': AssetsAudioPlayer(),
      'totalDuration': Duration.zero,
    },
  ];

  initAudio() async {
    for (Map<String, dynamic> data in allSongs) {
      await data['player'].open(
        Audio(data['path']),
        autoStart: false,
      );
    }

    for (Map<String, dynamic> data in allSongs) {
      setState(() {
        data['totalDuration'] = data['player'].current.value!.audio.duration;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    initAudio();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Audio Player"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: ListView.builder(
            itemCount: allSongs.length,
            itemBuilder: (context, i) => Card(
              elevation: 3,
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: Container(
                  alignment: Alignment.center,
                  height: 110,
                  width: 90,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage(
                      "${allSongs[i]['images']}",
                    ),
                  ),
                ),
                title: Text(
                  "${allSongs[i]['name']}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.play_arrow,
                            color: Colors.black,
                          ),
                          onPressed: () async {
                            await allSongs[i]['player'].play();
                            setState(() {});
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.pause,
                            color: Colors.black,
                          ),
                          onPressed: () async {
                            await allSongs[i]['player'].pause();
                            setState(() {});
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.stop,
                            color: Colors.black,
                          ),
                          onPressed: () async {
                            await allSongs[i]['player'].stop();
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                    StreamBuilder(
                      stream: allSongs[i]['player'].currentPosition,
                      builder: (context, AsyncSnapshot<Duration> snapshot) {
                        Duration? currentPosition = snapshot.data;

                        return Column(
                          children: [
                            Text(
                              "${"$currentPosition".split(".")[0]}/${"${allSongs[i]['totalDuration']}".split(".")[0]}",
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            Slider(
                              inactiveColor: Colors.black,
                              thumbColor: Colors.black,
                              min: 0,
                              max: allSongs[i]['totalDuration']
                                  .inSeconds
                                  .toDouble(),
                              value: (currentPosition != null)
                                  ? currentPosition.inSeconds.toDouble()
                                  : 0,
                              onChanged: (val) async {
                                await allSongs[i]['player'].seek(
                                  Duration(
                                    seconds: val.toInt(),
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
