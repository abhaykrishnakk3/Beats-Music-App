import 'package:flutter/material.dart';
import 'package:music_player_app/db_functions/db_functions.dart';
import 'package:music_player_app/model/song_model.dart';

import 'package:music_player_app/screens/music_play_screen.dart';

import 'package:music_player_app/screens/playlist_selected_songs.dart';
import 'package:on_audio_query/on_audio_query.dart';

// ignore: must_be_immutable
class ScreenPlaylistAdd extends StatelessWidget {
  final String name;
  int? id;
  ScreenPlaylistAdd({required this.name, this.id, Key? key})
      : super(key: key);

  int halo = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 88, 216, 255),
        title: Text(name.toUpperCase()),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return ScreenSongSelectedPlaylist(
                    name: name,
                    playlistid: id,
                  );
                }));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color.fromARGB(255, 37, 211, 255),
             
               Color.fromARGB(255, 223, 205, 221)
            ])),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SafeArea(
              child: ValueListenableBuilder(
            valueListenable: playListAddNotifier,
            builder:
                (BuildContext ctx, List<PlayListAdd> addplay, Widget? child) {
              return ListView.separated(
                separatorBuilder: (ctx,index){
                  return const SizedBox(height: 0,);
                },
                  itemCount: addplay.length,
                  itemBuilder: (context, index) {
                    return (addplay[index].playlistid == id)
                        ? ListTile(
                            title: Text(addplay[index].title,style: const TextStyle(overflow: TextOverflow.ellipsis),),
                            leading: QueryArtworkWidget(
                                id: addplay[index].image!,
                                type: ArtworkType.AUDIO),
                            trailing: IconButton(
                              onPressed: () {
                                deleteplaylist(addplay[index].id);
                              },
                              icon: const Icon(Icons.remove,color: Colors.red,),
                            ),
                            onTap: () async {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (ctx) {
                                return ScreenPlayMusic(
                                    song: addplay, index: index);
                              }));
                            },
                          )
                        : const SizedBox(
                            height: 0,
                          );
                  });
            },
          )),
        ),
      ),
    );
  }
}

