import 'package:flutter/material.dart';

class ScreenAbout extends StatelessWidget {
  const ScreenAbout({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(child: Column(
      
        children: [
          const SizedBox(height: 100,),
        Center(child: Image.asset('assets/splash.png'))
      ],)),
    );
  }
}