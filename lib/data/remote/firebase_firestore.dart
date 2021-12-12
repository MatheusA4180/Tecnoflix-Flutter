import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tecnoflix/model/favorite.dart';
import 'package:tecnoflix/model/resource.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

// SharedPreferences preferences = await SharedPreferences.getInstance();
// CollectionReference favoritesDB =
//     FirebaseFirestore.instance.collection(preferences.getString('email')!);

Future<Resource> addFavorite(Favorite favorite) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  CollectionReference favoritesDB =
      FirebaseFirestore.instance.collection(preferences.getString('email')!);
  var favoriteMap = {
    'id': favorite.id,
    'overview': favorite.overview,
    'posterPath': favorite.posterPath,
    'releaseDate': favorite.releaseDate,
    'title': favorite.title,
    'voteAverage': favorite.voteAverage,
    'voteCount': favorite.voteCount,
  };
  return favoritesDB
      .doc('${favorite.id}')
      .set(favoriteMap)
      .then((value) => Resource(true, "Adicionado com sucesso"))
      .catchError((error) => Resource(false, "Falha ao adicionar o favorito"));
}

Future<Resource> removeFavorite(Favorite favorite) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  CollectionReference favoritesDB =
      FirebaseFirestore.instance.collection(preferences.getString('email')!);
  return favoritesDB
      .doc('${favorite.id}')
      .delete()
      .then((value) => Resource(true, "Removido com sucesso"))
      .catchError((error) => Resource(false, "Falha ao remover o favorito"));
}

Future<Resource> searchFavoriteById(int id) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  CollectionReference favoritesDB =
      FirebaseFirestore.instance.collection(preferences.getString('email')!);
  return favoritesDB.doc('$id').get().then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      return Resource(true, "");
    } else {
      return Resource(false, "");
    }
  });
}

Future<List<Favorite>> returnFavorites() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  CollectionReference favoritesDB =
      FirebaseFirestore.instance.collection(preferences.getString('email')!);
  List<Favorite> listFavorite = [];
  return favoritesDB.get().then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      listFavorite.add(Favorite(
          doc["id"],
          doc["overview"],
          doc["posterPath"],
          doc["releaseDate"],
          doc["title"],
          doc["voteAverage"],
          doc["voteCount"]));
    });
  }).then((value) => listFavorite);
}
