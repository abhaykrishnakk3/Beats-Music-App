import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player_app/db_functions/db_functions.dart';
import 'package:music_player_app/model/song_model.dart';

import 'package:music_player_app/screens/now_playing_screen.dart';

import 'package:music_player_app/screens/playlist_selected_songs.dart';
import 'package:on_audio_query/on_audio_query.dart';

// ignore: must_be_immutable
class ScreenPlaylistAdd extends StatelessWidget {
  final String name;
  int? id;
  ScreenPlaylistAdd({required this.name, this.id, Key? key}) : super(key: key);

  int halo = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,),onPressed: (){
          Navigator.of(context).pop();
        },),
      backgroundColor: Colors.white,
        title: Text(name.toUpperCase(),style: TextStyle(color: Colors.black),),
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
              icon: const Icon(Icons.add,color: Colors.black,))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
            child: ValueListenableBuilder(
          valueListenable: playListAddNotifier,
          builder:
              (BuildContext ctx, List<PlayListAdd> addplay, Widget? child) {
            return ListView.separated(
                separatorBuilder: (ctx, index) {
                  return const SizedBox(
                    height: 0,
                  );
                },
                itemCount: addplay.length,
                itemBuilder: (context, index) {
                  return (addplay[index].playlistid == id)
                      ? ListTile(
                          title: Text(
                            addplay[index].title,
                            style: const TextStyle(
                                overflow: TextOverflow.ellipsis),
                          ),
                          leading: QueryArtworkWidget(
                              id: addplay[index].image!,
                              type: ArtworkType.AUDIO),
                          trailing: IconButton(
                            onPressed: () {
                              deleteplaylist(addplay[index].id);
                            },
                            icon: const Icon(
                              Icons.remove,
                              color: Colors.red,
                            ),
                          ),
                          onTap: () async {
                            String? uri = addplay[index].uri;
                            await player.setAudioSource(
                                AudioSource.uri(Uri.parse(uri!)));
                            player.play();
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (ctx) {
                              return Nowplay(
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
    );
  }
}
