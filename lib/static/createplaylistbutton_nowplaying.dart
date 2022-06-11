

import 'package:flutter/material.dart';
import 'package:music_player_app/screens/pages/screen_playlist.dart';

class Buttonplaylist extends StatelessWidget {
  const Buttonplaylist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  actions: <Widget>[
                    TextButton(onPressed: () {}, child: Text('Cancel')),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, 'OK');
                        clickhere(playlistcontroller);
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
