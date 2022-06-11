import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:favorite_button/favorite_button.dart';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import 'package:music_player_app/db_functions/db_functions.dart';

import 'package:music_player_app/model/song_model.dart';
import 'package:music_player_app/screens/pages/screen_home.dart';
import 'package:music_player_app/screens/pages/screen_playlist.dart';

import 'package:music_player_app/static/createplaylistbutton_nowplaying.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:rxdart/rxdart.dart';

ValueNotifier<bool> favdata = ValueNotifier(false);

final AudioPlayer player = AudioPlayer();
bool playing = false;
IconData iconbtn = Icons.play_arrow;

// ignore: must_be_immutable
class ScreenPlayMusic extends StatefulWidget {
  List<dynamic> song;
  dynamic index;
  ScreenPlayMusic({required this.song, required this.index, Key? key})
      : super(key: key);

  @override
  State<ScreenPlayMusic> createState() => _ScreenPlayMusicState();
}

class _ScreenPlayMusicState extends State<ScreenPlayMusic> {
  List<SongModel> songs = [];

  bool isFavorite = false;

  bool playing = false;
  IconData love = Icons.favorite;

  int flag = 0;

  //duration state stream
  Stream<DurationState> get _durationStateStream =>
      Rx.combineLatest2<Duration, Duration?, DurationState>(
          player.positionStream,
          player.durationStream,
          (position, duration) => DurationState(
              position: position, total: duration ?? Duration.zero));

  @override
  void initState() {
    favcheckfun(widget.song[widget.index].title);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 88, 216, 255),
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color.fromARGB(255, 37, 211, 255),
              Color.fromARGB(255, 255, 21, 228)
            ])),
        child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                
          children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.05,),
              Center(
                  child: Container(
                color: Colors.transparent,
                height: 300,
                width: 300,
                child: QueryArtworkWidget(
                  id: widget.song[widget.index].id,
                  type: ArtworkType.AUDIO,
                  artworkFit: BoxFit.cover,
                ),
              )),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  widget.song[widget.index].title,
                  style: const TextStyle(
                      color: Colors.white, overflow: TextOverflow.ellipsis),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    //slider bar container
                    Container(
                      padding: EdgeInsets.zero,
                      margin: const EdgeInsets.only(bottom: 4.0),

                      //slider bar duration state stream
                      child: StreamBuilder<DurationState>(
                        stream: _durationStateStream,
                        builder: (context, snapshot) {
                          final durationState = snapshot.data;
                          final progress =
                              durationState?.position ?? Duration.zero;
                          final total = durationState?.total ?? Duration.zero;

                          return ProgressBar(
                            progress: progress,
                            total: total,
                            barHeight: 2.0,
                            baseBarColor: Colors.grey,
                            progressBarColor:
                                const Color.fromARGB(237, 190, 52, 52),
                            thumbColor: Colors.black.withBlue(49),
                            timeLabelTextStyle: const TextStyle(
                              fontSize: 0,
                            ),
                            onSeek: (duration) {
                              player.seek(duration);
                            },
                          );
                        },
                      ),
                    ),

                    //position /progress and total text
                    StreamBuilder<DurationState>(
                      stream: _durationStateStream,
                      builder: (context, snapshot) {
                        final durationState = snapshot.data;
                        final progress = durationState?.position ?? Duration.zero;
                        final total = durationState?.total ?? Duration.zero;

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Flexible(
                              child: Text(
                                progress.toString().split(".")[0],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                total.toString().split(".")[0],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 14),
                      child: IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (context) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(onPressed: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                                          return const ScreenPlaylist();
                                        }));
                                      }, child: const Text(
                                        'Add to New playlist',
                                        style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 255, 255, 255),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 0, right: 0),
                                        child: InkWell(
                                          child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.50,
                                              width: double.infinity,
                                              decoration: const BoxDecoration(
                                                  color: Color.fromARGB(
                                                      255, 88, 216, 255),
                                                  borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(40),
                                                      topRight:
                                                          Radius.circular(40))),
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(16.0),
                                                  child: (playListnameNotifier
                                                          .value.isNotEmpty)
                                                      ? ListView.separated(
                                                          separatorBuilder:
                                                              (context, index) {
                                                            return const Divider(
                                                              color: Colors.black,
                                                            );
                                                          },
                                                          itemCount:
                                                              playListnameNotifier
                                                                  .value.length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return ListTile(
                                                                title: Text(
                                                                  playListnameNotifier
                                                                      .value[index]
                                                                      .name!,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                trailing:
                                                                    IconButton(
                                                                  onPressed: () {
                                                                    playllstnowplayingcheck(
                                                                        index);
                                                                    // final playname = PlayListAdd(
                                                                    //     title: widget
                                                                    //         .song[widget.index].title,
                                                                    //     image: widget
                                                                    //         .song[widget.index].id,
                                                                    //     uri: widget
                                                                    //         .song[widget.index].uri,
                                                                    //     playlistid: playListnameNotifier
                                                                    //         .value[index].id);

                                                                    // for (int i = 0;
                                                                    //     i <
                                                                    //         playListAddNotifier
                                                                    //             .value.length;
                                                                    //     i++) {
                                                                    //   if (widget.song[widget.index]
                                                                    //               .title ==
                                                                    //           playListAddNotifier
                                                                    //               .value[i].title &&
                                                                    //       playListAddNotifier.value[i]
                                                                    //               .playlistid ==
                                                                    //           playListnameNotifier
                                                                    //               .value[index].id) {
                                                                    //     flag = 1;
                                                                    //     break;
                                                                    //   } else {}
                                                                    // }
                                                                    // if (flag == 1) {
                                                                    //   Navigator.of(context).pop();
                                                                    // } else {
                                                                    //   playListAddList(playname);
                                                                    //   Navigator.of(context).pop();
                                                                    // }
                                                                  },
                                                                  icon: const Icon(
                                                                      Icons.add),
                                                                ));
                                                          },
                                                        )
                                                      : Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: const [
                                                            Text(
                                                              'No PlayList',
                                                              style: TextStyle(
                                                                  fontSize: 30),
                                                            ),
                                                            SizedBox(
                                                              height: 40,
                                                            ),
                                                            Buttonplaylist(),
                                                          ],
                                                        ))),
                                        ),
                                      )
                                    ],
                                  );
                                });
                          },
                          icon: const Icon(
                            Icons.playlist_add,
                            color: Colors.white70,
                            size: 30,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 25),
                      child: ValueListenableBuilder(
                          valueListenable: favdata,
                          builder: (context, bool data, _) {
                            return FavoriteButton(
                              iconSize: 40,
                              isFavorite: data,
                              valueChanged: (_is) {
                                final favi = FavouriteModel(
                                  title: widget.song[widget.index].title,
                                  uri: widget.song[widget.index].uri,
                                  image: widget.song[widget.index].id,
                                  favorit: true,
                                );
                                for (int i = 0;
                                    i < favouritmodelnotifer.value.length;
                                    i++) {
                                  if (widget.song[widget.index].title ==
                                      favouritmodelnotifer.value[i].title) {
                                    flag = 1;
                                    break;
                                  } else {}
                                }

                                if (flag == 0) {
                                  tast();
                                  addfavourit(favi);
                                } else {}
                              },
                            );
                          }),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        songindex = widget.index;
                        skippprevies();
                        // if (widget.index > 0) {
                        //   widget.index = widget.index - 1;

                        //   clickplay();
                        //   setState(() {});
                        // } else {
                        //   widget.index = widget.song.length - 1;
                        //   clickplay();
                        //   setState(() {});
                        // }

                        // favcheckfun(widget.song[widget.index].title);
                      },
                      icon: const Icon(Icons.skip_previous)),
                  const SizedBox(
                    width: 30,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: IconButton(
                        onPressed: () {
                          songindex = widget.index;
                          playpausecontroller();
                          // playing
                          //     ? player.playing
                          //         ? {player.pause(), iconbtn = Icons.play_arrow}
                          //         : {
                          //             player.play(),
                          //             iconbtn = Icons.pause,
                          //           }
                          //     : {
                          //         clickplay1(),
                          //         playing = true,
                          //         iconbtn = Icons.pause,
                          //         setState(() {})
                          //       };
                          // setState(() {});
                        },
                        icon: Icon(iconbtn)),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  IconButton(
                      onPressed: () {
                        if (widget.index < widget.song.length - 1) {
                          widget.index = widget.index + 1;
                          //  favcheckfun(widget.song[widget.index].title);
                          songindex = widget.index;
                          clickplay();

                          setState(() {});
                        } else {
                          widget.index = 0;
                          clickplay();
                          setState(() {});
                        }

                        favcheckfun(widget.song[widget.index].title);
                      },
                      icon: const Icon(Icons.skip_next)),
                ],
              ),
           // SizedBox(height: 20,),
          ],
        ),
            )),
      ),
    );
  }

  void clickplay() async {
    songindex = widget.index;
    String? uri = widget.song[widget.index].uri;
    await player.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
    // player.play();
    player.playing;
  }

  void clickplay1() async {
    songindex = widget.index;
    String? uri = widget.song[widget.index].uri;
    await player.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
    player.play();
    player.playing;
  }

  void tast() {
    const snackBar = SnackBar(
      content: SizedBox(
        height: 30.0,
        child: Center(
            child: Text(
          "Favorite Added",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        )),
      ),
      duration: Duration(seconds: 1),
      backgroundColor: Color.fromARGB(255, 80, 61, 60),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // void tast2() {
  //   const snackBar = SnackBar(
  //     content: SizedBox(
  //       height: 30.0,
  //       child: Center(
  //           child: Text(
  //         "Favorite Ollready addedd",
  //         style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  //         textAlign: TextAlign.center,
  //       )),
  //     ),
  //     duration: Duration(seconds: 1),
  //     backgroundColor: Color.fromARGB(255, 80, 61, 60),
  //   );

  //   // Find the ScaffoldMessenger in the widget tree
  //   // and use it to show a SnackBar.
  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // }

  void skippprevies() {
    if (widget.index > 0) {
      widget.index = widget.index - 1;

      clickplay();
      setState(() {});
    } else {
      widget.index = widget.song.length - 1;
      clickplay();
      setState(() {});
    }

    favcheckfun(widget.song[widget.index].title);
  }

  void playpausecontroller() {
    playing
        ? player.playing
            ? {player.pause(), iconbtn = Icons.play_arrow}
            : {
                player.play(),
                iconbtn = Icons.pause,
              }
        : {
            clickplay1(),
            playing = true,
            iconbtn = Icons.pause,
            setState(() {})
          };
    setState(() {});
  }


  void playllstnowplayingcheck(int index) {
    final playname = PlayListAdd(
        title: widget.song[widget.index].title,
        image: widget.song[widget.index].id,
        uri: widget.song[widget.index].uri,
        playlistid: playListnameNotifier.value[index].id);

    for (int i = 0; i < playListAddNotifier.value.length; i++) {
      if (widget.song[widget.index].title ==
              playListAddNotifier.value[i].title &&
          playListAddNotifier.value[i].playlistid ==
              playListnameNotifier.value[index].id) {
        flag = 1;
        break;
      } else {}
    }
    if (flag == 1) {
      Navigator.of(context).pop();
    } else {
      playListAddList(playname);
      Navigator.of(context).pop();
    }
  }
}

//duration class
class DurationState {
  DurationState({this.position = Duration.zero, this.total = Duration.zero});
  Duration position, total;
}

int halo = 0;
void favcheckfun(String titile) {
  for (var item in favouritmodelnotifer.value) {
    if (item.title == titile) {
      favdata.value = true;

      break;
    } else {
      favdata.value = false;
    }
  }
}
