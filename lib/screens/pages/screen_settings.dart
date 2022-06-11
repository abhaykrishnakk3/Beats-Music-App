import 'package:flutter/material.dart';
import 'package:music_player_app/db_functions/db_functions.dart';

import 'package:restart_app/restart_app.dart';

class ScreenSetting extends StatelessWidget {
  const ScreenSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 54, 48, 48),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 88, 216, 255),
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color.fromARGB(255, 37, 211, 255),
              Color.fromARGB(255, 223, 205, 221)
            ])),
        child: SafeArea(
            child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          ListTile(
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.android,
                size: 30,
              ),
            ),
            title: const Text(
              'Version',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            trailing: const Text(
              'v 1.0.0',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            onTap: () {
              // Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
              //   return const ScreenAbout();
              // }));

              showDialog(
                  context: context,
                  builder: (ctx) {
                    return Center(
                      child: AlertDialog(
                        title: Image.asset(
                          'assets/about.png',
                          height: 50,
                          width: 50,
                        ),
                        content: const Text(
                            'Beats is a Offline Music Player Created by AbhayKrishna kk'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                            child: const Text("Ok"),
                          ),
                        ],
                      ),
                    );
                  });
            },
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.mobile_friendly,
                size: 30,
              ),
            ),
            title: const Text(
              'About',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            onTap: () {
              resetFucntion();
              Restart.restartApp();
            },
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.restart_alt_outlined,
                size: 30,
              ),
            ),
            title: const Text(
              'Reset App',
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
            ),
          )
        ])),
      ),
    );
  }
}
