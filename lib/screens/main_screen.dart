import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:music_player_app/screens/pages/screen_faviorite.dart';
import 'package:music_player_app/screens/pages/screen_home.dart';
import 'package:music_player_app/screens/pages/screen_playlist.dart';
import 'package:music_player_app/screens/pages/screen_settings.dart';

class ScreenMain extends StatefulWidget {
  const ScreenMain({Key? key}) : super(key: key);

  @override
  State<ScreenMain> createState() => _ScreenMainState();
}

class _ScreenMainState extends State<ScreenMain> {
  int currentindex = 0;
  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView(
        onPageChanged: (value) {
          setState(() {
            currentindex = value;
          });
        },
        controller: controller,
        children: const [
          ScreenHome(),
          ScreenFavourite(),
          ScreenPlaylist(),
          ScreenSetting()
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        height: 80,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            
            children: [
             
           
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GNav(
                    padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height*0.031,vertical: MediaQuery.of(context).size.height*0.02),
                    selectedIndex: currentindex,
                    backgroundColor: Colors.black,
                    // activeColor: const Color.fromRGBO(255, 255, 255, 1),
                     activeColor: const Color.fromARGB(255, 88, 216, 255),
 tabBackgroundColor: const Color.fromARGB(255, 55, 55, 55),
                    
                    onTabChange: (index) {
                      setState(() {
                        currentindex = index;
                      });
                      controller.jumpToPage(index);
                    },
                    color: Colors.white,
                    gap: 8,
                    tabs: const [
                      GButton(
                       
                        icon: Icons.home,
                        iconColor: Colors.white,
                        text: 'Home',
                        textColor: Colors.white,
                      ),
                      GButton(
                        
                       
                        icon: Icons.favorite,
                        iconColor: Colors.white,
                        text: 'Favourite',
                        textColor: Colors.white,
                      ),
                      GButton(
                       
                        icon: Icons.playlist_add,
                        iconColor: Colors.white,
                        text: 'PlayList',
                        textColor: Colors.white,
                      ),
                      GButton(
                       
                        icon: Icons.settings,
                        iconColor: Colors.white,
                        text: 'Settings',
                        textColor: Colors.white,
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
