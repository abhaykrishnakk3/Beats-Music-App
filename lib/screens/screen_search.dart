// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player_app/model/all_song_model.dart';
import 'package:music_player_app/screens/now_playing_screen.dart';
import 'package:music_player_app/screens/pages/screen_home.dart';
import 'package:on_audio_query/on_audio_query.dart';

ValueNotifier<List<AllSongModel>> temp = ValueNotifier([]);

class ScreenSearch extends StatelessWidget {
  ScreenSearch({Key? key}) : super(key: key);
  final searchController = TextEditingController();

 int? indexvariable;

  @override
  Widget build(BuildContext context) {
    temp.value.clear();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white70,
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon: Icon(Icons.arrow_back,color: Colors.black,)),
      ),
      body: SafeArea(
        child: Column(
          children: [
             Padding(
               padding: const EdgeInsets.all(30.0),
               child: Container(
            decoration: BoxDecoration(
                  //  color: Color.fromARGB(255, 137, 202, 239),
                  borderRadius: BorderRadius.circular(10)),
            child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter a search song',
                ),
                onChanged: (String? value) {
                  if (value == null || value.isEmpty) {
                   temp.value.clear();
                  // temp.value.addAll(songs);
                    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
                    temp.notifyListeners();
                  } else {
                    temp.value.clear();
                    for (AllSongModel i in songs) {
                      if (i.title.toLowerCase().contains(value.toLowerCase())) {
                        temp.value.add(i);
                      }
                      // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
                      temp.notifyListeners();
                    }
                  }
                },
                controller: searchController,
            ),
          ),
             ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: temp,
                builder: (BuildContext ctx, List<AllSongModel> searchdata,
                    Widget? child) {
                  return ListView.separated(
                      itemBuilder: (ctx, index) {
                        final data = searchdata[index];
                        return ListTile(
                          leading: QueryArtworkWidget(
                            id: searchdata[index].id,
                            type: ArtworkType.AUDIO,
                          ),
                          title: Text(data.title),
                          onTap: () async {
                            // int i, j;
                            // for (i = 0; i < songs.length; i++) {
                            //   for (j = 0; j < searchdata.length; j++) {
                            //     if (songs[index].id == searchdata[index].id) {
                            //       indexvariable = i;
                            //     }
                            //   }
                            // }
                            // String? uri = searchdata[index].uri;
                            // await player
                            //     .setAudioSource(AudioSource.uri(Uri.parse(uri!)));
                            // player.play();
            
                            // FocusScope.of(context).unfocus();
                            // Navigator.of(context)
                            //     .push(MaterialPageRoute(builder: (ctx) {
                            //   return ScreenPlayMusic(
                            //       song: searchdata, index: index);
                            // }));
                          },
                        );
                      },
                      separatorBuilder: (ctx, index) {
                        return Divider();
                      },
                      itemCount: searchdata.length);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
