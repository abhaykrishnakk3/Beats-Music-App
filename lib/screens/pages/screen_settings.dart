import 'package:flutter/material.dart';
import 'package:music_player_app/db_functions/db_functions.dart';
import 'package:music_player_app/widget/newbox.dart';

import 'package:restart_app/restart_app.dart';

class ScreenSetting extends StatelessWidget {
  const ScreenSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 54, 48, 48),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'Settings',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: 300,
          width: double.infinity,
          child: NewBox(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    trailing: const Text(
                      'v 1.0.0',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    onTap: () {
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (ctx) {
                            return Center(
                              child: AlertDialog(
                                content: const Text(
                                    'Do you really want to reset your app'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                    child: const Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      resetFucntion();
                                      Restart.restartApp();
                                    },
                                    child: const Text("Reset"),
                                  ),
                                ],
                              ),
                            );
                          });
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
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  )
                ]),
          ),
        ),
      )),
    );
  }
}
