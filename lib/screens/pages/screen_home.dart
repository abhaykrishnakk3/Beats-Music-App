import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player_app/db_functions/db_functions.dart';
import 'package:music_player_app/model/all_song_model.dart';
import 'package:music_player_app/model/song_model.dart';
import 'package:music_player_app/screens/miniplayer/miniplayer.dart';
import 'package:music_player_app/screens/now_playing_screen.dart';
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
          backgroundColor: Color.fromARGB(255, 219, 219, 219),
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
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 219, 219, 219),
          ),
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
                      if (item.data == null) {
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
                          child: ListView.builder(
                              itemCount: item.data!.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  // height: MediaQuery.of(context).size.height*0.1,
                                  margin: const EdgeInsets.only(
                                      top: 25.0, left: 12.0, right: 16.0),
                                  padding: const EdgeInsets.only(
                                      top: 10.0, bottom: 10),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 219, 219, 219),
                                    borderRadius: BorderRadius.circular(20.0),
                                    boxShadow: const [
                                      BoxShadow(
                                        blurRadius: 4.0,
                                        offset: Offset(-4, -4),
                                        color: Colors.white,
                                      ),
                                      BoxShadow(
                                        blurRadius: 4.0,
                                        offset: Offset(-4, 4),
                                        color:
                                            Color.fromARGB(255, 130, 123, 123),
                                      ),
                                    ],
                                  ),
                                  child: ListTile(
                                    textColor: Colors.white,
                                  leading:  QueryArtworkWidget(
                                              id: item.data![index].id,
                                              type: ArtworkType.AUDIO,
                                              artworkFit: BoxFit.cover,
                                              artworkBorder:
                                                  BorderRadius.circular(13),
                                            ),
                                    title: Text(
                                      item.data![index].title,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          overflow: TextOverflow.ellipsis),
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
                                                      },),
                                            
                                    onTap: () {
                                      selectedindex = true;
                                      songindex = index;
                                     playfunction(item.data, index);
                                      setState(() {});
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (ctx) {
                                        return Nowplay(
                                            song: item.data!, index: index);
                                      }));
                                    },
                                  ),
                                );
                              }),
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

  void playfunction(dynamic song, int num) async {
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
