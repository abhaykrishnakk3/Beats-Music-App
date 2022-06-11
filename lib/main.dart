import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player_app/model/song_model.dart';
import 'package:music_player_app/screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(FavouriteModelAdapter().typeId)) {
    Hive.registerAdapter(FavouriteModelAdapter());
  }

  if(!Hive.isAdapterRegistered(playlistnameAdapter().typeId)){
    Hive.registerAdapter(playlistnameAdapter());
  }

  if(!Hive.isAdapterRegistered(PlayListAddAdapter().typeId)){
    Hive.registerAdapter(PlayListAddAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    return const MaterialApp(
      title: '',
      debugShowCheckedModeBanner: false,
      // home: ScreenMain(),

      home: ScreenSplash(),
    );
  }
}
