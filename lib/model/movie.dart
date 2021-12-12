class Movie {
  bool adult = true;
  String? backdropPath = "";
  List<dynamic> genreIds = [];
  int id = 0;
  String originalLanguage = "";
  String originalTitle = "";
  String overview = "";
  String popularity = "";
  String? posterPath = "";
  String releaseDate = "";
  String title = "";
  bool video = false;
  String voteAverage = "";
  int voteCount = 0;

  Movie(
      this.adult,
      this.backdropPath,
      this.genreIds,
      this.id,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.releaseDate,
      this.title,
      this.video,
      this.voteAverage,
      this.voteCount
  );
}
