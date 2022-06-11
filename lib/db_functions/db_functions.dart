import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player_app/model/all_song_model.dart';
import 'package:music_player_app/model/song_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

ValueNotifier<List<FavouriteModel>> favouritmodelnotifer = ValueNotifier([]);

void addfavourit(FavouriteModel value) async {
  //  favouritmodelnotifer.value.add(value);

  final favouritedb = await Hive.openBox<FavouriteModel>('favorite_db');
  final _id = await favouritedb.add(value);

  value.id = _id;

  
  favouritedb.put(value.id, value);

  favouritmodelnotifer.value.add(value);
  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
  favouritmodelnotifer.notifyListeners();
}

Future<void> getSongsfavourit() async {
  final favouritedb = await Hive.openBox<FavouriteModel>('favorite_db');
  favouritmodelnotifer.value.clear();
  favouritmodelnotifer.value.addAll(favouritedb.values);
  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
  favouritmodelnotifer.notifyListeners();
}

Future<void> deletefavSong(int id) async {
  final favouritedb = await Hive.openBox<FavouriteModel>('favorite_db');
  favouritedb.delete(id);
  getSongsfavourit();
}

ValueNotifier<List<playlistname>> playListnameNotifier = ValueNotifier([]);

// ignore: non_constant_identifier_names
void AddPlaylistName(playlistname value) async {
  final playName = await Hive.openBox<playlistname>('play_name');
  final _id = await playName.add(value);
  value.id = _id;
  await playName.put(value.id, value);

  playListnameNotifier.value.add(value);

  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
  playListnameNotifier.notifyListeners();
}

void getplayName() async {
  final playName = await Hive.openBox<playlistname>('play_name');
  playListnameNotifier.value.clear();
  playListnameNotifier.value.addAll(playName.values);
  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
  playListnameNotifier.notifyListeners();
}

void deletePlayListname(id) async {
  final playName = await Hive.openBox<playlistname>('play_name');
  playName.delete(id);
  getplayName();
}

ValueNotifier<List<PlayListAdd>> playListAddNotifier = ValueNotifier([]);

void playListAddList(PlayListAdd value) async {
  final playListAdding = await Hive.openBox<PlayListAdd>('playlistnameAdd');
  final _id = await playListAdding.add(value);
  value.id = _id;
  playListAdding.put(value.id, value);

  playListAddNotifier.value.add(value);
  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
  playListAddNotifier.notifyListeners();
}

void getPlaylistAdd() async {
  final playListAdding = await Hive.openBox<PlayListAdd>('playlistnameAdd');
  playListAddNotifier.value.clear();
  playListAddNotifier.value.addAll(playListAdding.values);
  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
  playListAddNotifier.notifyListeners();
}

 void deleteplaylist(id)async{
   final playListAdding = await Hive.openBox<PlayListAdd>('playlistnameAdd');
   playListAdding.delete(id);
   getPlaylistAdd();
 }


Future<List<AllSongModel>>fetchSongs()async{
  List<AllSongModel>allsongs=[];
  final OnAudioQuery _audioQuery = OnAudioQuery();
   final songs=await _audioQuery.querySongs(
                    sortType: null,
                    orderType: OrderType.ASC_OR_SMALLER,
                    uriType: UriType.EXTERNAL,
                    ignoreCase: true,
                  );
                  for (var item in songs) {
                    allsongs.add(AllSongModel(duration: item.duration, id: item.id, title: item.title, uri: item.uri));
                  }
return allsongs;
                  
}


     resetFucntion()async{
       final playListAdding = await Hive.openBox<PlayListAdd>('playlistnameAdd');
        final playName = await Hive.openBox<playlistname>('play_name');
         final favouritedb = await Hive.openBox<FavouriteModel>('favorite_db');

         playListAdding.clear();
         playName.clear();
         favouritedb.clear();
   }