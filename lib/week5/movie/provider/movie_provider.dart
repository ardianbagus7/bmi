part of '../../week5.dart';

class MovieProvider extends ChangeNotifier {
  MovieRepository movieRepository = MovieRepository();
  AuthProvider4 authProvider4 = AuthProvider4();

  ///
  /// Data
  ///
  List<Movie> movie;
  List<Movie> favoriteMovie;

  //! METHODS

  ///
  /// NOTE: get all notes Method
  ///
  Future<MovieResult> getMovie() async {
    try {
      MovieResult result = await movieRepository.getMovie();

      if (result != null) {
        // change data
        movie = result.data;
      }
      print('${result?.msg}');
      if (result?.msg == "Sesi Token Habis") {
        await authProvider4.logOut(true);
      }
      notifyListeners();
      return result;
    } catch (e) {
      print(e);
      return MovieResult(msg: 'Internet tidak dapat terhubung');
    }
  }

  Future<MovieResult> getFavoriteMovie() async {
    try {
      MovieResult result = await movieRepository.getFavoriteMovie();

      if (result != null) {
        // change data
        favoriteMovie = result.data;
      }
      print('${result?.msg}');
      if (result?.msg == "Sesi Token Habis") {
        await authProvider4.logOut(true);
      }
      notifyListeners();
      return result;
    } catch (e) {
      print(e);
      return MovieResult(msg: 'Internet tidak dapat terhubung');
    }
  }

  ///
  /// NOTE: add favorite Method
  ///
  Future<MovieResult> addFavorite(int id) async {
    try {
      MovieResult result = await movieRepository.addFavorite(id);

      if (result?.msg == "Sesi Token Habis") {
        await authProvider4.logOut(true);
      }
      notifyListeners();
      return result;
    } catch (e) {
      print(e);
      return MovieResult(msg: 'Internet tidak dapat terhubung');
    }
  }

  ///
  /// NOTE: delete favorite Method
  ///
  Future<MovieResult> deleteFavorite(int id) async {
    try {
      MovieResult result = await movieRepository.deleteFavorite(id);

      if (result?.msg == "Sesi Token Habis") {
        await authProvider4.logOut(true);
      }
      notifyListeners();
      return result;
    } catch (e) {
      print(e);
      return MovieResult(msg: 'Internet tidak dapat terhubung');
    }
  }

  
  /// 
  /// NOTE: get all notes Method
  ///
  List<Youtube> youtube;
  Future<YoutubeResult> getYoutube() async {
    try {
      YoutubeResult result = await movieRepository.getYoutube();

      if (result != null) {
        // change data
        youtube = result.data;
      }
      print('${result?.msg}');
      if (result?.msg == "Sesi Token Habis") {
        await authProvider4.logOut(true);
      }
      notifyListeners();
      return result;
    } catch (e) {
      print(e);
      return YoutubeResult(msg: 'Internet tidak dapat terhubung');
    }
  }

}
