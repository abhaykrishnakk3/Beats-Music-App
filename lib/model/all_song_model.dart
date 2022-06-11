
class AllSongModel {
  final String title;
  final int? img;
  final String? uri;
  final int? duration;
  final int id;
  AllSongModel({
    required this.duration,
    required this.id,
    required this.title,
    required this.uri,
    this.img,
  });
}
