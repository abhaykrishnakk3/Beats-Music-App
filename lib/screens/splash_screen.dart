import 'package:flutter/material.dart';
import 'package:music_player_app/db_functions/db_functions.dart';
import 'package:music_player_app/screens/main_screen.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({Key? key}) : super(key: key);

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    loadHome(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getSongsfavourit();
    getplayName();
    getPlaylistAdd();
    return Scaffold(
      backgroundColor: Colors.black,
      body:Container(height: double.infinity,width: double.infinity,child:Image.asset(
          'assets/splash1.jpg',fit: BoxFit.cover,
      
          
        ) ,)
    
    );
  }

  Future loadHome(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) =>  ScreenMain()));
  }
}
