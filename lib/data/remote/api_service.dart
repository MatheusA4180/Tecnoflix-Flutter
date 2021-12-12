import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tecnoflix/model/movie.dart';

const String url = "https://api.themoviedb.org/3/";
const String apiKey = "c87a59110d1715855dac83ccfc5c2640";
const String language = "pt-BR";

Future<List<Movie>?> requestMoviesPopular() async{

  var movies = <Movie>[];

  String urlWithQuery = "${url}movie/popular/?api_key=$apiKey&language=$language";

  http.Response response = await http.get(Uri.parse(urlWithQuery));

  final moviesJson = jsonDecode(response.body);

  for(var element=0; element<20;element++){
    movies.add(
          Movie(
            moviesJson["results"][element]["adult"],
            moviesJson["results"][element]["backdrop_path"],
            moviesJson["results"][element]["genre_ids"],
            moviesJson["results"][element]["id"],
            moviesJson["results"][element]["original_language"],
            moviesJson["results"][element]["original_title"],
            moviesJson["results"][element]["overview"],
            moviesJson["results"][element]["popularity"],
            moviesJson["results"][element]["poster_path"],
            moviesJson["results"][element]["release_date"],
            moviesJson["results"][element]["title"],
            moviesJson["results"][element]["video"],
            moviesJson["results"][element]["vote_average"].toString(),
            moviesJson["results"][element]["vote_count"],
          )
        );
  }

  return movies;

}