import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player_app/db_functions/db_functions.dart';
import 'package:music_player_app/model/all_song_model.dart';
import 'package:music_player_app/model/song_model.dart';
import 'package:music_player_app/screens/miniplayer/miniplayer.dart';
import 'package:music_player_app/screens/music_play_screen.dart';
import 'package:music_player_app/screens/screen_search.dart';
import 'package:on_audio_query/on_audio_query.dart';

List<AllSongModel> songs = [];

int songindex = 0;
bool isfirstLoad = true;

bool selectedindex = false;

ValueNotifier<bool> homefavdata = ValueNotifier(false);

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  final AudioPlayer play = AudioPlayer();

  IconData fav = Icons.favorite;

  @override
  // ignore: must_call_super
  void initState() {
    requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 88, 216, 255),
          title: const Text(
            'Beats',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                    return ScreenSearch();
                  }));
                },
                icon: const Icon(
                  Icons.search,
                  size: 30,
                ))
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
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder<List<AllSongModel>>(
                    future: fetchSongs(),
                    builder: (context, item) {
                      // Loading content
                      // if (item.data == null) {
                      //   return const CircularProgressIndicator();
                      // }
                      if(item.data == null){
                        return const Center(child: CircularProgressIndicator());
                      }

                      // When you try "query" without asking for [READ] or [Library] permission
                      // the plugin will return a [Empty] list.
                      if (item.data!.isEmpty)
                        // ignore: curly_braces_in_flow_control_structures
                        return const Text("Nothing found!");
                      // ScreenSongSelectedPlaylist(songss: item.data!,);
                      songs = item.data!;

                      return Column(children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, top: 16, bottom: 2),
                            child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 260,
                                        mainAxisExtent: 200,
                                        crossAxisSpacing: 20,
                                        mainAxisSpacing: 10),
                                itemCount: item.data!.length,
                                shrinkWrap: true,
                                primary: false,
                                itemBuilder: (BuildContext ctx, int index) {
                                  return InkWell(
                                    
                                    onTap: () {
                                      selectedindex = true;
                                      songindex = index;
                                     playfunction(item.data, index);
                                      setState(() {});
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (ctx) {
                                        return ScreenPlayMusic(
                                            song: item.data!, index: index);
                                      }));
                                    },
                                    child: Card(
                                      color: Colors.transparent,
                                      child: ListView(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        children: [
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.16,
                                            child: QueryArtworkWidget(
                                              id: item.data![index].id,
                                              type: ArtworkType.AUDIO,
                                              artworkFit: BoxFit.cover,
                                              artworkBorder:
                                                  BorderRadius.circular(0),
                                            ),
                                          ),
                                          Container(
                                              color: Colors.transparent,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.9,
                                              child: Column(
                                                children: [
                                                  ListTile(
                                                    title: Text(
                                                      item.data![index].title,
                                                      style: const TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis),
                                                    ),
                                                    trailing:
                                                        ValueListenableBuilder(
                                                      valueListenable:
                                                          homefavdata,  
                                                      builder: (context,
                                                          bool data, child) {
                                                        return FavoriteButton(
                                                            iconSize: 40,
                                                            isFavorite: isfav(
                                                                item
                                                                    .data![
                                                                        index]
                                                                    .title),
                                                            valueChanged:
                                                                (_is) {
                                                              final favi =
                                                                  FavouriteModel(
                                                                title: item
                                                                    .data![
                                                                        index]
                                                                    .title,
                                                                uri: item
                                                                    .data![
                                                                        index]
                                                                    .uri,
                                                                image: item
                                                                    .data![
                                                                        index]
                                                                    .id,
                                                                favorit: true,
                                                              );
                                                              int halo = 0;
                                                              for (int i = 0;
                                                                  i <
                                                                      favouritmodelnotifer
                                                                          .value
                                                                          .length;
                                                                  i++) {
                                                                if (item
                                                                        .data![
                                                                            index]
                                                                        .title ==
                                                                    favouritmodelnotifer
                                                                        .value[
                                                                            i]
                                                                        .title) {
                                                                  halo = 1;
                                                                  break;
                                                                } else {}
                                                              }
                                                              if (halo == 0) {
                                                                addfavourit(
                                                                    favi);
                                                              }
                                                            });
                                                      },
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 50,
                                                  )
                                                ],
                                              )),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ),
                        (selectedindex == true)
                            ? Screenminiplayer(Listofsongs: item.data!)
                            : const SizedBox(
                                height: 0,
                              )
                      ]);
                    }),
              ),
            ],
          ),
        ));
  }

  void playfunction(dynamic song,int  num)async{
     String? uri = song[num].uri;
    await player.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
     player.play();
  }

  requestPermission() async {
    if (!kIsWeb) {
      bool permissionStatus = await _audioQuery.permissionsStatus();
      if (!permissionStatus) {
        await _audioQuery.permissionsRequest();
      }

      setState(() {});
    }
  }

  void homefavouritecheckfunction(AllSongModel allsongs) {}

  bool isfav(String titile) {
    for (var item in favouritmodelnotifer.value) {
      if (item.title == titile) {
        return true;
      }
    }
    return false;
  }
}
