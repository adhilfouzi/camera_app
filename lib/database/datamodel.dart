class AlbumModel {
  int? id;
  final String imagex;

  AlbumModel({this.id, required this.imagex});

  static AlbumModel fromMap(Map<String, Object?> map) {
    final id = map['id'] as int;
    final imagex = map['imagex'] as String;

    return AlbumModel(
      id: id,
      imagex: imagex,
    );
  }
}
