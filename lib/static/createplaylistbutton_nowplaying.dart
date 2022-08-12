

import 'package:flutter/material.dart';
import 'package:music_player_app/db_functions/db_functions.dart';
import 'package:music_player_app/model/song_model.dart';

final form = GlobalKey<FormState>();

dynamic cont;
String? errorMess;
class Buttonplaylist extends StatelessWidget {
   Buttonplaylist({Key? key}) : super(key: key);

  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    cont =context;
    return TextButton(
        onPressed: () {
          showDialog<String>(
              context: context,
              builder: (BuildContext context) {
                final playlistcontroller = TextEditingController();
                return Form(
                  key: form,
                  child: AlertDialog(
                    backgroundColor: Colors.white,
                    title: const Text('PlayList Name'),
                    content: TextFormField(
                      controller: playlistcontroller,
                
                      validator: (value){
                        if(value!.isEmpty){
                
                          return "Value Is Empty";
                
                        }
                      },
                      
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
                          if(form.currentState!.validate()){
                             clickhere1(playlistcontroller);
                          }
                         
                        },
                        child: const Text('Create'),
                      ),
                    ],
                  ),
                );
              });
        },
        child: const Text('Create New PlayList'));
  }
}
 void clickhere1(TextEditingController playlistcontroller) {
    final name = playlistcontroller.text.trim();
   
          final _name = playlistname(name: name);
      Navigator.of(cont).pop();
      AddPlaylistName(_name);
    
  }