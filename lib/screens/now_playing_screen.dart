import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:favorite_button/favorite_button.dart';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import 'package:music_player_app/db_functions/db_functions.dart';

import 'package:music_player_app/model/song_model.dart';
import 'package:music_player_app/screens/pages/screen_home.dart';
import 'package:music_player_app/screens/pages/screen_playlist.dart';

import 'package:music_player_app/static/createplaylistbutton_nowplaying.dart';
import 'package:music_player_app/widget/newbox.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:rxdart/rxdart.dart';

ValueNotifier<bool> favdata = ValueNotifier(false);

final AudioPlayer player = AudioPlayer();
bool playing = false;
IconData iconbtn = Icons.pause;

// ignore: must_be_immutable
class Nowplay extends StatefulWidget {
  List<dynamic> song;
  dynamic index;
  Nowplay({required this.song, required this.index, Key? key})
      : super(key: key);

  @override
  State<Nowplay> createState() => _ScreenPlayMusicState();
}

class _ScreenPlayMusicState extends State<Nowplay> {
  List<SongModel> songs = [];

  bool isFavorite = false;

  //IconData love = Icons.favorite;

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
   (playing)?iconbtn = Icons.pause:iconbtn = Icons.pause;
    favcheckfun(widget.song[widget.index].title);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
    // backgroundColor:Color.fromARGB(255, 221, 221, 221),
      body: SafeArea(
          child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 50,
                width: 50,
                child: InkWell(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: NewBox(
                    child: Icon(Icons.arrow_back),
                  ),
                ),
              ),
              Text("NOWPLAYING",style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(
                height: 50,
                width: 50,
                child: NewBox(
                  child: Icon(Icons.menu),
                ),
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.02,
          ),
          NewBox(
              child: Column(
            children: [
              Container(
                color: Colors.transparent,
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 0.8,
                child: QueryArtworkWidget(
              id: widget.song[widget.index].id,
              type: ArtworkType.AUDIO,
              artworkFit: BoxFit.cover,
                ),
              ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.010,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                     Text(
                  widget.song[widget.index].title,
                  style: const TextStyle(
                      color: Colors.black,fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
                ),
                    ],
                  ),
                 ValueListenableBuilder(
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
                ],
              )
            ],
          )),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.020,
          ),
          StreamBuilder<DurationState>(
                      stream: _durationStateStream,
                      builder: (context, snapshot) {
                        final durationState = snapshot.data;
                        final progress =
                            durationState?.position ?? Duration.zero;
                        final total = durationState?.total ?? Duration.zero;

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Flexible(
                              child: Text(
                                progress.toString().split(".")[0],
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            Icon(Icons.shuffle),
                            IconButton(onPressed:(){
                              showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (context) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(builder: (ctx) {
                                            return const ScreenPlaylist();
                                          }));
                                        },
                                        child: const Text(
                                          'Add to New playlist',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
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
                                                color: Color.fromARGB(255, 221, 221, 221),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  40),
                                                          topRight:
                                                              Radius.circular(
                                                                  40))),
                                              child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  child: (playListnameNotifier
                                                          .value.isNotEmpty)
                                                      ? ListView.separated(
                                                          separatorBuilder:
                                                              (context, index) {
                                                            return const Divider(
                                                              color:
                                                                  Colors.black,
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
                                                                      .value[
                                                                          index]
                                                                      .name!,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                trailing:
                                                                    IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    playllstnowplayingcheck(
                                                                        index);
                                                                  },
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .add),
                                                                ));
                                                          },
                                                        )
                                                      : Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children:  [
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
                            }, icon:Icon( Icons.playlist_add)),

                            Flexible(
                              child: Text(
                                total.toString().split(".")[0],
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
         SizedBox(
            height: MediaQuery.of(context).size.height*0.020,
          ),
            Container(
                      padding: EdgeInsets.zero,
                      margin: const EdgeInsets.only(bottom: 4.0),

                      //slider bar duration state stream
                      child: NewBox(
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
                              barHeight: 12.0,
                              baseBarColor: Colors.white,
                              progressBarColor:
                               const  Color.fromARGB(255, 237, 227, 142),
                              thumbColor: Colors.white,
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
                    ),
          
         SizedBox(
            height: MediaQuery.of(context).size.height*0.040,
          ),
          SizedBox(
            height: 80,
            child: Row(children: [
              Expanded(
                  child: NewBox(child:  IconButton(
                      onPressed: () {
                        songindex = widget.index;
                        skippprevies();
                      },
                      icon: const Icon(Icons.skip_previous)),)
                  ),
              Expanded(
                flex: 2,
                  child:  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: NewBox(child: IconButton(
                        onPressed: () {
                          songindex = widget.index;
                          playpausecontroller();
                        },
                        icon: Icon(iconbtn,size: 30,)),),
                  )),
              Expanded(
                  child: NewBox(child:  IconButton(
                      onPressed: () {
                        if (widget.index < widget.song.length - 1) {
                          widget.index = widget.index + 1;

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
                      icon: const Icon(Icons.skip_next)),))
            ]),
          )
        ],
      ),
      ),
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
        : {playing = true, iconbtn = Icons.pause, setState(() {})};
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
