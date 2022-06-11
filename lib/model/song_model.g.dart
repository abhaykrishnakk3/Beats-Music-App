// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavouriteModelAdapter extends TypeAdapter<FavouriteModel> {
  @override
  final int typeId = 1;

  @override
  FavouriteModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavouriteModel(
      title: fields[0] as dynamic,
      image: fields[1] as int?,
      uri: fields[2] as dynamic,
      id: fields[3] as int?,
      favorit: fields[4] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, FavouriteModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.uri)
      ..writeByte(3)
      ..write(obj.id)
      ..writeByte(4)
      ..write(obj.favorit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavouriteModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// ignore: camel_case_types
class playlistnameAdapter extends TypeAdapter<playlistname> {
  @override
  final int typeId = 2;

  @override
  playlistname read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return playlistname(
      name: fields[0] as String?,
      id: fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, playlistname obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is playlistnameAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PlayListAddAdapter extends TypeAdapter<PlayListAdd> {
  @override
  final int typeId = 3;

  @override
  PlayListAdd read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlayListAdd(
      playlistid: fields[4] as int?,
      title: fields[0] as dynamic,
      image: fields[1] as dynamic,
      id: fields[2] as dynamic,
      uri: fields[3] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, PlayListAdd obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.uri)
      ..writeByte(4)
      ..write(obj.playlistid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayListAddAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
