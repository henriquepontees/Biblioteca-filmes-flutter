import '../models/movie_model.dart';
import '../database/database_helper.dart';

class MovieController {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  Future<int> addMovie(Movie movie) async {
    return await _databaseHelper.createMovie(movie);
  }

  Future<List<Movie>> getAllMovies() async {
    return await _databaseHelper.readAllMovies();
  }

  Future<Movie?> getMovie(int id) async {
    return await _databaseHelper.readMovie(id);
  }

  Future<int> updateMovie(Movie movie) async {
    return await _databaseHelper.updateMovie(movie);
  }

  Future<int> deleteMovie(int id) async {
    return await _databaseHelper.deleteMovie(id);
  }
}