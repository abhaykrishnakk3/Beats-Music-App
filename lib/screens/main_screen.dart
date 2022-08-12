
import 'package:flutter/material.dart';
import 'package:music_player_app/screens/pages/screen_faviorite.dart';
import 'package:music_player_app/screens/pages/screen_home.dart';
import 'package:music_player_app/screens/pages/screen_playlist.dart';
import 'package:music_player_app/screens/pages/screen_settings.dart';

class ScreenMain extends StatefulWidget {
   ScreenMain({Key? key}) : super(key: key);

  @override
  State<ScreenMain> createState() => _ScreenMainState();
}

class _ScreenMainState extends State<ScreenMain> {
  List pages = const[

      ScreenHome(),
          ScreenFavourite(),
          ScreenPlaylist(),
          ScreenSetting()

  ];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar:BottomNavigationBar(
           type: BottomNavigationBarType.fixed,
        unselectedItemColor: Color.fromARGB(255, 125, 115, 115),
        selectedItemColor: Colors.black,
        currentIndex: index,
        onTap: (value){
             setState(() {
               index = value;
             });
        },
        items:const [
        BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
         BottomNavigationBarItem(icon: Icon(Icons.favorite),label: "Favourite"),
          BottomNavigationBarItem(icon: Icon(Icons.playlist_add),label: "PlayList"),
           BottomNavigationBarItem(icon: Icon(Icons.settings),label: "Setting")
      ]),
    );
  }
}
