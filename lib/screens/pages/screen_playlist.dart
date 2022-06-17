import 'package:flutter/material.dart';
import 'package:music_player_app/db_functions/db_functions.dart';
import 'package:music_player_app/model/song_model.dart';


import 'package:music_player_app/screens/play_list_display_screen.dart';


dynamic currentplaylistid;
dynamic con;

class ScreenPlaylist extends StatefulWidget {
  const ScreenPlaylist({Key? key}) : super(key: key);

  @override
  State<ScreenPlaylist> createState() => _ScreenPlaylistState();
}

class _ScreenPlaylistState extends State<ScreenPlaylist> {
 

  @override
  Widget build(BuildContext context) {

     con = context;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 88, 216, 255),
        title: const Text(
          'Playlist',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: playListnameNotifier,
        builder:
            (BuildContext ctx, List<playlistname> playname, Widget? child) {
          return Container(
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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      mainAxisExtent: 80,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 10),
                  itemCount: playname.length,
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (BuildContext ctx, int index) {
                    return InkWell(
                      onTap: () {
                        currentplaylistid = playname[index].id;
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (ctx) {
                          return ScreenPlaylistAdd(
                            name: playname[index].name!,
                            id: playname[index].id,
                          );
                        }));
                      },
                      child: Card(
                        color: Colors.transparent,
                        child: ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            Container(
                              color: const Color.fromARGB(0, 53, 233, 250),
                              height:
                                  MediaQuery.of(context).size.height * 0.088,
                              child: Center(
                                child: ListTile(
                                  title: Text(
                                    playname[index].name!,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  trailing: IconButton(
                                    onPressed: () => showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        backgroundColor: Colors.white,
                                        title: const Text('Delete Folder'),
                                      
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                context, 'Cancel'),
                                            child: const Text('NO'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context, 'OK');
                                              deletePlayListname(
                                                  playname[index].id);
                                            },
                                            child: const Text('Yes'),
                                          ),
                                        ],
                                      ),
                                    ),
                                    icon: const Icon(
                                      Icons.delete,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
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
                      hintText: 'PlayList Name',
                        border: OutlineInputBorder(
                          
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  actions: <Widget>[
                    TextButton(onPressed: () {
                      Navigator.of(context).pop();
                    }, child: const Text('Cancel')),
                    TextButton(
                      onPressed: () {
                    //  Navigator.pop(context, 'OK');
                        clickhere(playlistcontroller);
                      },
                      child: const Text('Create'),
                    ),
                  ],
                );
              });
        
     //   Buttonplaylist();
        },
        child: const Icon(Icons.playlist_add),
        backgroundColor: Colors.grey,
      ),
    );
  }

  
}
 void clickhere(TextEditingController playlistcontroller) {
    final name = playlistcontroller.text.trim();

   
    if (name.isEmpty) {
    
  dynamic SnackBa =    SnackBar(
    duration: Duration(seconds: 1),
    backgroundColor: Colors.red,
     content: Text('Name is required')

    );
    ScaffoldMessenger.of(con).showSnackBar(SnackBa);
    } else {
      final _name = playlistname(name: name);

      AddPlaylistName(_name);
    }
  }
