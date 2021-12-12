import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tecnoflix/features/infomovie/info_movie.dart';
import 'package:tecnoflix/model/favorite.dart';
import 'package:tecnoflix/model/movie.dart';
import 'package:intl/intl.dart';
import 'package:tecnoflix/utils/helper_functions.dart';

const String url = "https://api.themoviedb.org/3/";
const String apiKey = "c87a59110d1715855dac83ccfc5c2640";
const String language = "pt-BR";
const String urlImage = "https://image.tmdb.org/t/p/w500/";
const String urlImageBanner = "https://image.tmdb.org/t/p/w500/";

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  List<Movie> popularMovies = [];
  List<Movie> playingMovies = [];

  @override
  void initState() {
    super.initState();
    _requestPopularMovies();
    _requestPlayingMovies();
  }

  _requestPopularMovies() async {
    String urlWithQuery =
        "${url}movie/popular/?api_key=$apiKey&language=$language";

    http.Response response = await http.get(Uri.parse(urlWithQuery));

    setState(() {
      var moviesJson = jsonDecode(response.body);

      for (var element = 0; element < 20; element++) {
        popularMovies.add(
            Movie(
              moviesJson["results"][element]["adult"],
              moviesJson["results"][element]["backdrop_path"],
              moviesJson["results"][element]["genre_ids"],
              moviesJson["results"][element]["id"],
              moviesJson["results"][element]["original_language"],
              moviesJson["results"][element]["original_title"],
              moviesJson["results"][element]["overview"],
              moviesJson["results"][element]["popularity"].toString(),
              moviesJson["results"][element]["poster_path"],
              formatDate(moviesJson["results"][element]["release_date"]),
              moviesJson["results"][element]["title"],
              moviesJson["results"][element]["video"],
              moviesJson["results"][element]["vote_average"].toString(),
              moviesJson["results"][element]["vote_count"],
            ));
      }
    });
  }

  _requestPlayingMovies() async {
    var currentDate = DateTime.now();
    var currentDateFormat = DateFormat('yyyy-MM-dd').format(currentDate);

    String urlWithQuery =
        "${url}discover/movie/?api_key=$apiKey&primary_release_date.gte=$currentDateFormat&primary_release_date.lte=$currentDateFormat&language=$language";

    http.Response response = await http.get(Uri.parse(urlWithQuery));

    setState(() {

      var moviesJson = jsonDecode(response.body);

      for (var element = 0; element < 10; element++) {
        if (moviesJson["results"][element]["backdrop_path"] != null) {
          playingMovies.add(
              Movie(
                moviesJson["results"][element]["adult"],
                moviesJson["results"][element]["backdrop_path"],
                moviesJson["results"][element]["genre_ids"],
                moviesJson["results"][element]["id"],
                moviesJson["results"][element]["original_language"],
                moviesJson["results"][element]["original_title"],
                moviesJson["results"][element]["overview"],
                moviesJson["results"][element]["popularity"].toString(),
                moviesJson["results"][element]["poster_path"],
                formatDate(moviesJson["results"][element]["release_date"]),
                moviesJson["results"][element]["title"],
                moviesJson["results"][element]["video"],
                moviesJson["results"][element]["vote_average"].toString(),
                moviesJson["results"][element]["vote_count"],
              ));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding:
              const EdgeInsets.only(top: 16.0, left: 16.0, bottom: 8.0),
              child: const Text(
                "Em cartaz",
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 200.0,
            child: PageView.builder(
              itemCount: playingMovies.length,
              itemBuilder: (BuildContext context, int position) {
                return _buildItemPage(position);
              },
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding:
              const EdgeInsets.only(top: 16.0, left: 16.0, bottom: 8.0),
              child: const Text(
                "Series",
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 200.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: (BuildContext context, int position) {
                return _buildItemList(position);
              },
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding:
              const EdgeInsets.only(top: 16.0, left: 16.0, bottom: 8.0),
              child: const Text(
                "Em alta",
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 200.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: (BuildContext context, int position) {
                return _buildItemList(position + 6);
              },
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding:
              const EdgeInsets.only(top: 16.0, left: 16.0, bottom: 8.0),
              child: const Text(
                "Partiu um filme de ação?",
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 200.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: (BuildContext context, int position) {
                return _buildItemList(position + 12);
              },
            ),
          ),
          const SizedBox(
            height: 50.0,
          ),
        ],
      ),
    );
  }

  Widget _buildItemList(int position) {
    if (popularMovies.isEmpty) {
      return Container(width: 120);
    } else {
      return InkWell(
        child: Container(
          color: Colors.white,
          child: Image.network("$urlImage${popularMovies[position].posterPath}"),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      InfoMovieScreen(
                          Favorite(
                              popularMovies[position].id,
                              popularMovies[position].overview,
                              popularMovies[position].posterPath!,
                              popularMovies[position].releaseDate,
                              popularMovies[position].title,
                              popularMovies[position].voteAverage,
                              popularMovies[position].voteCount
                          )
                      )
              )
          );
        },
      );
    }
  }

  Widget _buildItemPage(int position) {
    if (playingMovies.isEmpty) {
      return Container();
    } else {
      return InkWell(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image:
              NetworkImage("$urlImageBanner${playingMovies[position].backdropPath}"),
              fit: BoxFit.fill,
            ),
          ),
          child: Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: const EdgeInsets.only(right: 16.0, bottom: 8.0),
              child: Text(
                playingMovies[position].title,
                style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    backgroundColor: Color.fromARGB(100, 51, 51, 51)),
                textAlign: TextAlign.end,
              ),
            ),
          ),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      InfoMovieScreen(
                          Favorite(
                              playingMovies[position].id,
                              playingMovies[position].overview,
                              playingMovies[position].posterPath!,
                              playingMovies[position].releaseDate,
                              playingMovies[position].title,
                              playingMovies[position].voteAverage,
                              playingMovies[position].voteCount
                          )
                      )
              )
          );
        },
      );
    }
  }
}
