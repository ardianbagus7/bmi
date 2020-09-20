part of '../../week5.dart';

class MovieRepository {
  ///
  /// Get Movie
  ///
  Future<MovieResult> getMovie() async {
    final url = "https://udacoding.ardianbagus.com/api/movie";

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'bearer $token4',
    };

    try {
      print(url);
      final response = await http.get(
        url,
        headers: headers,
      );
      print(response.body);
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        final data = result as List;

        List<Movie> movie = data.map((e) => Movie.fromJson(e)).toList();

        return MovieResult(data: movie);
      } else if (response.statusCode == 422) {
        final _msg = json.decode(response.body);
        return MovieResult(msg: _msg['message']);
      } else if (response.statusCode == 401) {
        return MovieResult(msg: "Sesi Token Habis");
      } else {
        return MovieResult(msg: "Server sedang bermasalah");
      }
    } catch (e) {
      print(e);
      return MovieResult(msg: "Internet tidak dapat terhubung keserver");
    }
  }

  Future<MovieResult> getFavoriteMovie() async {
    final url = "https://udacoding.ardianbagus.com/api/favorite";

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'bearer $token4',
    };

    try {
      print(url);
      final response = await http.get(
        url,
        headers: headers,
      );
      print(response.body);
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        final data = result as List;

        List<Movie> movie = data.map((e) => Movie.fromJson(e)).toList();

        return MovieResult(data: movie);
      } else if (response.statusCode == 422) {
        final _msg = json.decode(response.body);
        return MovieResult(msg: _msg['message']);
      } else if (response.statusCode == 401) {
        return MovieResult(msg: "Sesi Token Habis");
      } else {
        return MovieResult(msg: "Server sedang bermasalah");
      }
    } catch (e) {
      print(e);
      return MovieResult(msg: "Internet tidak dapat terhubung keserver");
    }
  }

  ///
  /// Favorite
  ///

  Future<MovieResult> addFavorite(int id) async {
    final url = "https://udacoding.ardianbagus.com/api/favorite/add";

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'bearer $token4',
    };

    Map<String, String> body = {'id': '$id'};

    try {
      print(url);
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );
      print(response.body);
      if (response.statusCode == 201) {
        return MovieResult(data: [Movie()], msg: 'Add success');
      } else if (response.statusCode == 422) {
        final _msg = json.decode(response.body);
        return MovieResult(msg: _msg['message']);
      } else if (response.statusCode == 401) {
        return MovieResult(msg: "Sesi Token Habis");
      } else {
        return MovieResult(msg: "Server sedang bermasalah");
      }
    } catch (e) {
      print(e);
      return MovieResult(msg: "Internet tidak dapat terhubung keserver");
    }
  }

  Future<MovieResult> deleteFavorite(int id) async {
    final url = "https://udacoding.ardianbagus.com/api/favorite/delete";

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'bearer $token4',
    };

    Map<String, String> body = {'id': '$id'};

    try {
      print(url);
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );
      print(response.body);
      if (response.statusCode == 201) {
        return MovieResult(data: [Movie()], msg: 'Delete success');
      } else if (response.statusCode == 422) {
        final _msg = json.decode(response.body);
        return MovieResult(msg: _msg['message']);
      } else if (response.statusCode == 401) {
        return MovieResult(msg: "Sesi Token Habis");
      } else {
        return MovieResult(msg: "Server sedang bermasalah");
      }
    } catch (e) {
      print(e);
      return MovieResult(msg: "Internet tidak dapat terhubung keserver");
    }
  }

  ///
  /// Get Youtube
  ///
  Future<YoutubeResult> getYoutube() async {
    final url = "https://flutterrlist.herokuapp.com/";

    Map<String, String> headers = {
      'Accept': 'application/json',
    };

    try {
      print(url);
      final response = await http.get(
        url,
        headers: headers,
      );
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        final data = result as List;

        List<Youtube> youtube = data.map((e) => Youtube.fromJson(e)).toList();

        return YoutubeResult(data: youtube);
      } else if (response.statusCode == 422) {
        final _msg = json.decode(response.body);
        return YoutubeResult(msg: _msg['message']);
      } else if (response.statusCode == 401) {
        return YoutubeResult(msg: "Sesi Token Habis");
      } else {
        return YoutubeResult(msg: "Server sedang bermasalah");
      }
    } catch (e) {
      print(e);
      return YoutubeResult(msg: "Internet tidak dapat terhubung keserver");
    }
  }
}
