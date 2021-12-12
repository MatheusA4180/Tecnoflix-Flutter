class Favorite {
  int id = 0;
  String overview = "";
  String? posterPath = "";
  String releaseDate = "";
  String title = "";
  String voteAverage = "";
  int voteCount = 0;

  Favorite(
    this.id,
    this.overview,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.voteAverage,
    this.voteCount,
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'overview': overview,
      'posterPath': posterPath,
      'releaseDate': releaseDate,
      'title': title,
      'voteAverage': voteAverage,
      'voteCount': voteCount,
    };
  }
}
