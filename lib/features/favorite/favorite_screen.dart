import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tecnoflix/data/remote/firebase_firestore.dart';
import 'package:tecnoflix/features/infomovie/info_movie.dart';
import 'package:tecnoflix/model/favorite.dart';

const String url = "https://api.themoviedb.org/3/";
const String apiKey = "c87a59110d1715855dac83ccfc5c2640";
const String language = "pt-BR";
const String urlImage = "https://image.tmdb.org/t/p/w500/";

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  State<StatefulWidget> createState() => _FavoriteScreen();
}

class _FavoriteScreen extends State<FavoriteScreen> {
  List<Favorite> favoriteMovies = [];

  @override
  void initState() {
    super.initState();
    _requestFavoriteMovies();
  }

  Future<void> _requestFavoriteMovies() async {
    setState(() {
      returnFavorites().then((value) => _setStateFavoritesList(value));
    });
  }

  _setStateFavoritesList(List<Favorite> value) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          favoriteMovies = value;
        });
      } else {
        favoriteMovies = [];
      }
    } on SocketException catch(_) {
      favoriteMovies = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: const Color.fromARGB(255, 255, 22, 22),
      backgroundColor: Colors.black,
      onRefresh: _requestFavoriteMovies,
      child: treatmentOfEmptyList(),
    );
  }

  Widget treatmentOfEmptyList() {
    if (favoriteMovies.isEmpty) {
      return Container(
        margin: const EdgeInsets.only(top: 220),
        child: Column(children: [
          const Icon(
            Icons.favorite_border,
            size: 70,
            color: Color.fromARGB(255, 255, 22, 22),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.only(top: 4.0, left: 16.0, right: 20),
              child: const Text(
                "Não há nenhum favorito",
                style: TextStyle(
                  fontSize: 28.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ]),
      );
    } else {
      return ListView.builder(
        itemCount: favoriteMovies.length,
        itemBuilder: (BuildContext context, int position) {
          return _buildItemList(position);
        },
      );
    }
  }

  Widget _buildItemList(int position) {
    if (favoriteMovies.isEmpty) {
      return Container(width: 120);
    } else {
      return InkWell(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                height: 120,
                margin:
                    const EdgeInsets.only(top: 12.0, left: 8.0, bottom: 12.0),
                child: Image.network(
                    "$urlImage${favoriteMovies[position].posterPath}"
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.only(left: 16.0, right: 40),
                      child: Text(
                        favoriteMovies[position].title,
                        style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.only(
                          top: 12.0, left: 16.0, right: 20
                      ),
                      child: const Text(
                        "Data de lançamento:",
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.only(
                          top: 4.0, left: 16.0, right: 20
                      ),
                      child: Text(
                        favoriteMovies[position].releaseDate,
                        style: const TextStyle(
                          fontSize: 14.0,
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
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => InfoMovieScreen(Favorite(
                      favoriteMovies[position].id,
                      favoriteMovies[position].overview,
                      favoriteMovies[position].posterPath!,
                      favoriteMovies[position].releaseDate,
                      favoriteMovies[position].title,
                      favoriteMovies[position].voteAverage,
                      favoriteMovies[position].voteCount)
                  )
              )
          );
        },
      );
    }
  }
}
