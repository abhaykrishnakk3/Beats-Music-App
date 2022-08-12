import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import 'package:music_player_app/db_functions/db_functions.dart';
import 'package:music_player_app/model/song_model.dart';

import 'package:music_player_app/screens/now_playing_screen.dart';
import 'package:music_player_app/widget/newbox.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ScreenFavourite extends StatefulWidget {
  const ScreenFavourite({Key? key}) : super(key: key);

  @override
  State<ScreenFavourite> createState() => _ScreenFavouriteState();
}

class _ScreenFavouriteState extends State<ScreenFavourite> {
  @override
  Widget build(BuildContext context) {
    // final  AudioPlayer play = AudioPlayer();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Favourite',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30,color: Colors.black),
          )),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ValueListenableBuilder(
          valueListenable: favouritmodelnotifer,
          builder: (BuildContext ctx, List<FavouriteModel> favsongs,
              Widget? child) {
            return ListView.separated(
                separatorBuilder: (ctx, index) {
                  return const Divider();
                },
                itemCount: favsongs.length,
                itemBuilder: (ctx, index) {
                  return Container(
                    color: Color.fromARGB(255, 236, 236, 236),
                    child: NewBox(
                      child: ListTile(
                        trailing: IconButton(
                          onPressed: () {
                            deletefavSong(favsongs[index].id!);
                          },
                          icon: const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                        ),
                        leading: QueryArtworkWidget(
                          id: favsongs[index].image!,
                          type: ArtworkType.AUDIO,
                        ),
                        title: Text(
                          favsongs[index].title,
                          style:
                              const TextStyle(overflow: TextOverflow.ellipsis),
                        ),
                        onTap: () async {
                          String? uri = favsongs[index].uri;
                          await player
                              .setAudioSource(AudioSource.uri(Uri.parse(uri!)));
                          player.play();
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (ctx) {
                            return Nowplay(
                                song: favsongs, index: index);
                          }));
                        },
                      ),
                    ),
                  );
                });
          },
        ),
      )),
    );
  }
}
