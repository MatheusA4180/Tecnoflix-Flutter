import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tecnoflix/model/favorite.dart';
import 'package:tecnoflix/utils/helper_functions.dart';

const String urlImage = "https://image.tmdb.org/t/p/w500/";

List<Favorite> dbFavoriteMovie = [];

class InfoMovieScreen extends StatefulWidget {

  final Favorite favoriteMovie;

  InfoMovieScreen(
      this.favoriteMovie
  );

  @override
  State<StatefulWidget> createState() => _InfoMovieScreen(favoriteMovie);
}

class _InfoMovieScreen extends State<InfoMovieScreen> {

  final Favorite favoriteMovie;

  _InfoMovieScreen(this.favoriteMovie);

  var stateFavorite = Icons.favorite_border;

  @override
  void initState() {
    super.initState();
    for (var element in dbFavoriteMovie) {
      if (element.title == favoriteMovie.title) {
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
                  dbFavoriteMovie.add(favoriteMovie);
                } else {
                  stateFavorite = Icons.favorite_border;
                  dbFavoriteMovie
                      .removeWhere((element) => element.title == favoriteMovie.title);
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
      body: InfoMovieBody(favoriteMovie),
      backgroundColor: const Color.fromARGB(100, 51, 51, 51),
    );
  }
}

class InfoMovieBody extends StatelessWidget {

  final Favorite favoriteMovie;

  InfoMovieBody(this.favoriteMovie);


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
                favoriteMovie.title,
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
                  child: Image.network("$urlImage${favoriteMovie.posterPath}"),
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
                          favoriteMovie.releaseDate,
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
                          favoriteMovie.voteAverage,
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
                          favoriteMovie.voteCount.toString(),
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
                favoriteMovie.overview,
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
