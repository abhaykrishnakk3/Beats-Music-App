import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:music_player_app/screens/music_play_screen.dart';
import 'package:music_player_app/screens/pages/screen_home.dart';
import 'package:on_audio_query/on_audio_query.dart';

// ignore: must_be_immutable
class Screenminiplayer extends StatefulWidget {
  // ignore: non_constant_identifier_names
  dynamic Listofsongs;
  
   // ignore: non_constant_identifier_names
   Screenminiplayer({this.Listofsongs, Key? key }) : super(key: key);

  @override
  State<Screenminiplayer> createState() => _ScreenminiplayerState();
}

class _ScreenminiplayerState extends State<Screenminiplayer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
                              padding: const EdgeInsets.all(8),
                              child: Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                  color: const Color.fromARGB(255, 255, 255, 255),),
                               height: 70,
                                
                                  child: Center(
                                    child: ListTile(
                                    
                                      onTap: () => Navigator.of(context)
                                          .push(MaterialPageRoute(builder: (ctx) {
                                        return ScreenPlayMusic(
                                            song: widget.Listofsongs, index: songindex);
                                      })),
                                      leading: QueryArtworkWidget(
                                        id: widget.Listofsongs[songindex].id,
                                        type: ArtworkType.AUDIO,
                                        artworkFit: BoxFit.cover,
                                        artworkBorder: BorderRadius.circular(0),
                                      ),
                                      title: Marquee(
                                        text
                                          :widget.Listofsongs[songindex].title,
                                          style: const TextStyle(
                                              overflow: TextOverflow.ellipsis),
                                              pauseAfterRound: const Duration(seconds: 5),
                                              velocity: 30,
                                        
                                  
                                      ),
                                      trailing: Column(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                playing
                                                    ? player.playing
                                                        ? {
                                                            player.pause(),
                                                            iconbtn =
                                                                Icons.play_arrow
                                                          }
                                                        : {
                                                            player.play(),
                                                            iconbtn = Icons.pause,
                                                          }
                                                    : {
                                                        playing = true,
                                                        iconbtn = Icons.pause,
                                                        setState(() {})
                                                      };
                                                setState(() {});
                                              },
                                              icon: Icon(iconbtn)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                            );
  }
}