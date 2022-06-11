import 'package:flutter/material.dart';

import 'package:music_player_app/db_functions/db_functions.dart';
import 'package:music_player_app/model/song_model.dart';

import 'package:music_player_app/screens/music_play_screen.dart';
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
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 88, 216, 255),
          title: const Text(
            'Favourite',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          )),
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
          child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ValueListenableBuilder(
            valueListenable: favouritmodelnotifer,
            builder: (BuildContext ctx, List<FavouriteModel> favsongs,
                  Widget? child) {
                   
                return ListView.separated(
                  separatorBuilder: (ctx,index){
                  return const Divider();
                  },
                    itemCount: favsongs.length,
                    itemBuilder: (ctx, index) {
                      return ListTile(
                      
                        trailing: IconButton(
                          onPressed: (){
                            deletefavSong(favsongs[index].id!);
                          
                          },
                          icon: const Icon(Icons.favorite,color: Colors.red,),
                        ),
                        leading: QueryArtworkWidget(
                          id: favsongs[index].image!,
                          type: ArtworkType.AUDIO,
                        ),
                        title: Text(favsongs[index].title,style: const TextStyle(overflow: TextOverflow.ellipsis),),
                        onTap: () async {
                         
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (ctx) {
                          
                            return ScreenPlayMusic(song: favsongs, index: index);
                          }));
                        },
                      );
                    });
            },
          ),
              ))),
    );
  }
}
