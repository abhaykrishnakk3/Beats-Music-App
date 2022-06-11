import 'package:flutter/material.dart';
import 'package:music_player_app/db_functions/db_functions.dart';

import 'package:music_player_app/model/song_model.dart';
import 'package:music_player_app/screens/pages/screen_home.dart';
import 'package:on_audio_query/on_audio_query.dart';

dynamic ctxx;

// ignore: must_be_immutable
class ScreenSongSelectedPlaylist extends StatelessWidget {
  final String? name;
  final int? playlistid;
  ScreenSongSelectedPlaylist({this.name, this.playlistid, Key? key})
      : super(key: key);

  int flag = 0;

  @override
  Widget build(BuildContext context) {
    ctxx = context;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 111, 214, 252),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 88, 216, 255),
        title: Text(
          '$name',
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.done,
                size: 30,
                color: Colors.black,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
            itemBuilder: (ctx, index) {
              return  ListTile(
                leading: QueryArtworkWidget(
                  id: songs[index].id,
                  type: ArtworkType.AUDIO,
                  artworkFit: BoxFit.cover,
                  artworkBorder: BorderRadius.circular(0),
                ),
                title: Text(
                  songs[index].title,
                  style: const TextStyle(overflow: TextOverflow.ellipsis),
                ),
                trailing: IconButton(
                  onPressed: () {
                    playlistselected(
                        songs[index].title, songs[index].id, songs[index].uri);
                  },
                  icon: const Icon(Icons.add),
                ),
              );
            },
            separatorBuilder: (ctx, index) {
              return const Divider();
            },
            itemCount: songs.length),
      ),
    );
  }

  void playlistselected(String title, int id, String? uri) {
    final playname =
        PlayListAdd(title: title, image: id, uri: uri, playlistid: playlistid!);

    for (int i = 0; i < playListAddNotifier.value.length; i++) {
      if (title == playListAddNotifier.value[i].title &&
          playListAddNotifier.value[i].playlistid == playlistid) {
        flag = 1;
        break;
      } else {}
    }
    if (flag == 1) {
      tostplaylistOllreadyAdded();
    } else {
      tastplaylist();
      playListAddList(playname);
    }
  }

  void tastplaylist() {
    const snackBar = SnackBar(
      content: SizedBox(
        height: 30.0,
        child: Center(
            child: Text(
          "PlayList Added",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        )),
      ),
      duration: Duration(seconds: 1),
      backgroundColor: Color.fromARGB(255, 80, 61, 60),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(ctxx).showSnackBar(snackBar);
  }

  void tostplaylistOllreadyAdded() {
    const snackBar = SnackBar(
      content: SizedBox(
        height: 30.0,
        child: Center(
            child: Text(
          "Allready added",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        )),
      ),
      duration: Duration(seconds: 1),
      backgroundColor: Color.fromARGB(255, 80, 61, 60),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(ctxx).showSnackBar(snackBar);
  }
}
