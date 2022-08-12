
import 'package:flutter/material.dart';
import 'package:music_player_app/db_functions/db_functions.dart';
import 'package:music_player_app/model/song_model.dart';
import 'package:music_player_app/screens/playlist_selected_songs.dart';

IconData? playicon;

class PlayButton extends StatefulWidget {
  final String titile;
  final int id;
  final dynamic uri;
  const PlayButton(
      {Key? key, required this.titile, required this.id, required this.uri})
      : super(key: key);

  @override
  State<PlayButton> createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> {
  @override
  Widget build(BuildContext context) {
    check();
    return playicon  == Icons.remove?IconButton(onPressed: (){
     
    }, icon: Icon(playicon)):IconButton(onPressed: (){
   
      playlistselected(widget.titile, widget.id, widget.uri);
      
     
      print("Adddedd");
    }, icon: Icon(playicon));
  }

   void playlistselected(String title, int id, String? uri) {
    int flag = 0;
    final playname =
        PlayListAdd(title: title, image: id, uri: uri, playlistid: playlistId!);

    for (int i = 0; i < playListAddNotifier.value.length; i++) {
      if (title == playListAddNotifier.value[i].title &&
          playListAddNotifier.value[i].playlistid == playlistId) {
       flag = 1;
        break;
      } else {}
    }
    if (flag == 1) {

      tostplaylistOllreadyAdded();
     
    } else {
      tastplaylist();
      playListAddList(playname);
    }
  }

  dynamic check() {
    int flaf = 0;
    for (int i = 0; i < playListAddNotifier.value.length; i++) {
      if (widget.titile == playListAddNotifier.value[i].title &&
          playListAddNotifier.value[i].playlistid == playlistId) {
        flaf = 1;
        break;
      } else {}
    }
    if (flaf == 1) {
      playicon = Icons.remove;
    // setState(() {});
    } else {
      playicon = Icons.add;
     // setState(() {});
    }
  }
    void tastplaylist() {
    const snackBar = SnackBar(
      content: SizedBox(
        height: 30.0,
        child: Center(
            child: Text(
          "PlayList Added",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        )),
      ),
      duration: Duration(seconds: 1),
      backgroundColor: Color.fromARGB(255, 80, 61, 60),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(ctxx).showSnackBar(snackBar);
  }

  
  void tostplaylistOllreadyAdded() {
    const snackBar = SnackBar(
      content: SizedBox(
        height: 30.0,
        child: Center(
            child: Text(
          "Allready added",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        )),
      ),
      duration: Duration(seconds: 1),
      backgroundColor: Color.fromARGB(255, 80, 61, 60),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(ctxx).showSnackBar(snackBar);
  }
 
}
