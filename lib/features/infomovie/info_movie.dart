import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tecnoflix/model/favorite.dart';

const String urlImage = "https://image.tmdb.org/t/p/w500/";

List<Favorite> dbFavoriteMovie = [];

class InfoMovieScreen extends StatefulWidget {
  final int id;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final String title;
  final String voteAverage;
  final int voteCount;

  InfoMovieScreen(
    this.id,
    this.overview,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.voteAverage,
    this.voteCount,
  );

  @override
  State<StatefulWidget> createState() => _InfoMovieScreen(
      id, overview, posterPath, releaseDate, title, voteAverage, voteCount);
}

class _InfoMovieScreen extends State<InfoMovieScreen> {
  final int id;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final String title;
  final String voteAverage;
  final int voteCount;

  _InfoMovieScreen(
    this.id,
    this.overview,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.voteAverage,
    this.voteCount,
  );

  var stateFavorite = Icons.favorite_border;

  @override
  void initState() {
    super.initState();
    for (var element in dbFavoriteMovie) {
      if (element.title == title) {
        setState(() {
          stateFavorite = Icons.favorite;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Descrição",
        ),
        actions: [
          IconButton(
            icon: Icon(stateFavorite),
            tooltip: 'Favorito',
            onPressed: () {
              setState(() {
                if (stateFavorite == Icons.favorite_border) {
                  stateFavorite = Icons.favorite;
                  dbFavoriteMovie.add(Favorite(id, overview, posterPath,
                      releaseDate, title, voteAverage, voteCount));
                } else {
                  stateFavorite = Icons.favorite_border;
                  dbFavoriteMovie
                      .removeWhere((element) => element.title == title);
                }
              });
            },
          ),
        ],
        centerTitle: false,
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.maybePop(context);
          },
        ),
      ),
      body: InfoMovieBody(
          id, overview, posterPath, releaseDate, title, voteAverage, voteCount),
      backgroundColor: const Color.fromARGB(100, 51, 51, 51),
    );
  }
}

class InfoMovieBody extends StatelessWidget {
  final int id;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final String title;
  final String voteAverage;
  final int voteCount;

  InfoMovieBody(
    this.id,
    this.overview,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.voteAverage,
    this.voteCount,
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              padding:
                  const EdgeInsets.only(top: 20.0, left: 16.0, bottom: 8.0),
              child: Text(
                title,
                style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  margin: const EdgeInsets.only(top: 24.0, left: 24.0),
                  child: Image.network("$urlImage$posterPath"),
                ),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 20.0, left: 16.0, bottom: 8.0),
                        child: const Text(
                          "Data de lançamento:",
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 4.0, left: 16.0, bottom: 8.0),
                        child: Text(
                          releaseDate,
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 16.0, left: 16.0, bottom: 8.0),
                        child: const Text(
                          "Avaliação:",
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 4.0, left: 16.0, bottom: 8.0),
                        child: Text(
                          voteAverage,
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 16.0, left: 16.0, bottom: 8.0),
                        child: const Text(
                          "N° de votos:",
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 4.0, left: 16.0, bottom: 8.0),
                        child: Text(
                          voteCount.toString(),
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              padding:
                  const EdgeInsets.only(top: 24.0, left: 16.0, bottom: 8.0),
              child: const Text(
                "Sinopse:",
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              padding: const EdgeInsets.only(
                  top: 4.0, left: 16.0, right: 24, bottom: 8.0),
              child: Text(
                overview,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
