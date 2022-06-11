

import 'package:hive_flutter/adapters.dart';
part 'song_model.g.dart';

@HiveType(typeId: 1)
class FavouriteModel {
  @HiveField(0)
  final dynamic title;

  @HiveField(1)
  final int? image;

  @HiveField(2)
  final dynamic uri;

  @HiveField(3)
   int? id;

   @HiveField(4)
   bool? favorit;

  FavouriteModel({
    required this.title,
    this.image,
    this.uri,
    this.id,
    this.favorit,
  });
}

@HiveType(typeId: 2)
// ignore: camel_case_types
class playlistname{

  @HiveField(0)
   String? name;
 
 @HiveField(1)
  int? id;

  playlistname({this.name,this.id});
}

@HiveType(typeId: 3)
class PlayListAdd{

  @HiveField(0)
  dynamic title;

  @HiveField(1)
  dynamic image;

  @HiveField(2)
  dynamic id;

  @HiveField(3)
  dynamic uri;
 
  @HiveField(4)
  int? playlistid;

  PlayListAdd({ this.playlistid,this.title,this.image,this.id,this.uri,});

}
