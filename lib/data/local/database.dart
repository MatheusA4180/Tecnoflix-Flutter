import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tecnoflix/model/favorite.dart';

void database() async {
  // Avoid errors caused by flutter upgrade.
  // Importing 'package:flutter/widgets.dart' is required.
  WidgetsFlutterBinding.ensureInitialized();
  // Open the database and store the reference.
  final database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'favorite.db'),
    // When the database is first created, create a table to store dogs.
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        'CREATE TABLE favorite(id INTEGER PRIMARY KEY, overview TEXT, posterPath TEXT, releaseDate TEXT, title TEXT, voteAverage TEXT, voteCount INTEGER)',
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );

  // Define a function that inserts dogs into the database
  Future<void> insertFavorite(Favorite favorite) async {
    // Get a reference to the database.
    final db = await database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'dogs',
      favorite.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the dogs from the dogs table.
  Future<List<Favorite>> returnListFavorite() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('favorite');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Favorite(
          maps[i]['id'],
          maps[i]['overview'],
          maps[i]['posterPath'],
          maps[i]['releaseDate'],
          maps[i]['title'],
          maps[i]['voteAverage'],
          maps[i]['voteCount']);
    });
  }

  Future<void> deleteDog(int id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Dog from the database.
    await db.delete(
      'favorite',
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  // Create a Dog and add it to the dogs table
  var testFavorite = Favorite(
    10,
    "overview",
    "posterPath",
    "releaseDate",
    "title",
    "voteAverage",
    0,
  );

  await insertFavorite(testFavorite);

  // Now, use the method above to retrieve all the dogs.
  print(await returnListFavorite()); // Prints a list that include Fido.

  // Delete Fido from the database.
  await deleteDog(testFavorite.id);

  // Print the list of dogs (empty).
  print(await returnListFavorite());
}
