import 'package:flutter/material.dart';
import 'package:music_player_app/db_functions/db_functions.dart';

import 'package:music_player_app/model/song_model.dart';
import 'package:music_player_app/screens/pages/screen_home.dart';
import 'package:music_player_app/widget/playbutton.dart';
import 'package:on_audio_query/on_audio_query.dart';

dynamic ctxx;

int? playlistId;

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
    playlistId = playlistid;
    return Scaffold(
     backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        },icon: Icon(Icons.arrow_back,color: Colors.black,),),
       backgroundColor: Colors.white,
        title: Text(
          '$name',
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.black),
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
                // trailing: IconButton(
                //   onPressed: () {
                //     playlistselected(
                //         songs[index].title, songs[index].id, songs[index].uri);
                //   },
                //   icon: const Icon(Icons.add),
                // ),
                trailing: PlayButton(titile: songs[index].title, id: songs[index].id, uri: songs[index].uri),
              
              );
            },
            separatorBuilder: (ctx, index) {
              return const Divider();
            },
            itemCount: songs.length),
      ),
    );
  }

  // void playlistselected(String title, int id, String? uri) {
  //   final playname =
  //       PlayListAdd(title: title, image: id, uri: uri, playlistid: playlistid!);

  //   for (int i = 0; i < playListAddNotifier.value.length; i++) {
  //     if (title == playListAddNotifier.value[i].title &&
  //         playListAddNotifier.value[i].playlistid == playlistid) {
  //       flag = 1;
  //       break;
  //     } else {}
  //   }
  //   if (flag == 1) {
  //     tostplaylistOllreadyAdded();
  //   } else {
  //     tastplaylist();
  //     playListAddList(playname);
  //   }
  // }



}
