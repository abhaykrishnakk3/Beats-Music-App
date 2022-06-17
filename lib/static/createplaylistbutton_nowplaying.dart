

import 'package:flutter/material.dart';
import 'package:music_player_app/db_functions/db_functions.dart';
import 'package:music_player_app/model/song_model.dart';



dynamic cont;
String? errorMess;
class Buttonplaylist extends StatelessWidget {
  const Buttonplaylist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    cont =context;
    return TextButton(
        onPressed: () {
          showDialog<String>(
              context: context,
              builder: (BuildContext context) {
                final playlistcontroller = TextEditingController();
                return AlertDialog(
                  backgroundColor: Colors.white,
                  title: const Text('PlayList Name'),
                  content: TextFormField(
                    controller: playlistcontroller,
                    
                    decoration: InputDecoration(
                      errorText:errorMess ,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  actions: <Widget>[
                    TextButton(onPressed: () {
                      Navigator.of(context).pop();
                    }, child: Text('Cancel')),
                    TextButton(
                      onPressed: () {
                        
                        clickhere1(playlistcontroller);
                      },
                      child: const Text('Create'),
                    ),
                  ],
                );
              });
        },
        child: const Text('Create New PlayList'));
  }
}
 void clickhere1(TextEditingController playlistcontroller) {
    final name = playlistcontroller.text.trim();
    if (name.isEmpty) {
     return;
    } else {
      final _name = playlistname(name: name);
      Navigator.of(cont).pop();
      AddPlaylistName(_name);
    }
  }