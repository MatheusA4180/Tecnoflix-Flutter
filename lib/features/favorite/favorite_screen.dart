import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tecnoflix/features/infomovie/info_movie.dart';
import 'package:tecnoflix/model/movie.dart';
import 'package:http/http.dart' as http;

const String url = "https://api.themoviedb.org/3/";
const String apiKey = "c87a59110d1715855dac83ccfc5c2640";
const String language = "pt-BR";
const String urlImage = "https://image.tmdb.org/t/p/w500/";

class FavoriteScreen extends StatefulWidget{
  const FavoriteScreen({Key? key}) : super(key: key);

  State<StatefulWidget> createState() => _FavoriteScreen();
}

class _FavoriteScreen extends State<FavoriteScreen>{

  List<Movie> foundMovies = [];

  @override
  void initState() {
    super.initState();
    _requestSearchMovies();
  }

  _requestSearchMovies() async {
    String urlWithQuery =
        "${url}search/movie/?api_key=$apiKey&query=${"spider"}&language=$language";

    http.Response response = await http.get(Uri.parse(urlWithQuery));

    foundMovies.clear();

    setState(() {
      var moviesJson = jsonDecode(response.body);

      for (var element = 0; element < 20; element++) {
        foundMovies.add(Movie(
          moviesJson["results"][element]["adult"],
          moviesJson["results"][element]["backdrop_path"],
          moviesJson["results"][element]["genre_ids"],
          moviesJson["results"][element]["id"],
          moviesJson["results"][element]["original_language"],
          moviesJson["results"][element]["original_title"],
          moviesJson["results"][element]["overview"],
          moviesJson["results"][element]["popularity"].toString(),
          moviesJson["results"][element]["poster_path"],
          moviesJson["results"][element]["release_date"],
          moviesJson["results"][element]["title"],
          moviesJson["results"][element]["video"],
          moviesJson["results"][element]["vote_average"].toString(),
          moviesJson["results"][element]["vote_count"],
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: foundMovies.length,
      itemBuilder: (BuildContext context, int position) {
        return _buildItemList(position);
      },
    );
  }

  Widget _buildItemList(int position) {
    if (foundMovies.isEmpty) {
      return Container(width: 120);
    } else {
      return InkWell(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                height: 120,
                margin: const EdgeInsets.only(top: 12.0, left: 8.0,bottom: 12.0),
                child: Image.network(
                    "$urlImage${foundMovies[position].posterPath}"),
              ),
            ),
            Expanded(
              flex: 7,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 40),
                      child: Text(
                        foundMovies[position].title,
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
                          top: 12.0, left: 16.0, right: 20),
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
                          top: 4.0, left: 16.0, right: 20),
                      child: Text(
                        foundMovies[position].releaseDate,
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
                  builder: (BuildContext context) => InfoMovieScreen(
                      foundMovies[position].id,
                      foundMovies[position].overview,
                      foundMovies[position].posterPath!,
                      foundMovies[position].releaseDate,
                      foundMovies[position].title,
                      foundMovies[position].voteAverage,
                      foundMovies[position].voteCount)));
        },
      );
    }
  }

}