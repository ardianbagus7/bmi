part of '../../week4.dart';

class NoteRepository {
  ///
  /// Get Notes
  ///
  Future<NoteResult> getNote() async {
    final url = "https://ardianbagus.com/udacoding/api/note";

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

        List<Note> note = data.map((e) => Note.fromJson(e)).toList();

        return NoteResult(data: note);
      } else if (response.statusCode == 422) {
        final _msg = json.decode(response.body);
        return NoteResult(msg: _msg['message']);
      } else if (response.statusCode == 401) {
        return NoteResult(msg: "Sesi Token Habis");
      } else {
        return NoteResult(msg: "Server sedang bermasalah");
      }
    } catch (e) {
      print(e);
      return NoteResult(msg: "Internet tidak dapat terhubung keserver");
    }
  }

  Future<NoteResult> addNote(String judul, String deskripsi) async {
    final url = "https://ardianbagus.com/udacoding/api/note";

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'bearer $token4',
    };

    Map<String, String> body = {
      'judul': '$judul',
      'deskripsi': '$deskripsi',
    };

    try {
      print(url);
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );
      print(response.body);
      if (response.statusCode == 201) {
        
        Note note = Note();

        return NoteResult(data: [note],msg: 'Add success');
      } else if (response.statusCode == 422) {
        final _msg = json.decode(response.body);
        return NoteResult(msg: _msg['message']);
      } else if (response.statusCode == 401) {
        return NoteResult(msg: "Sesi Token Habis");
      } else {
        return NoteResult(msg: "Server sedang bermasalah");
      }
    } catch (e) {
      print(e);
      return NoteResult(msg: "Internet tidak dapat terhubung keserver");
    }
  }

  ///
  /// Edit Note
  ///
  Future<NoteResult> editNote(int id, String judul, String deskripsi) async {
    final url = "https://ardianbagus.com/udacoding/api/note/$id";

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'bearer $token4',
    };

     Map<String, String> body = {
       '_method': 'PATCH',
      'judul': '$judul',
      'deskripsi': '$deskripsi',
    };

    try {
      print(url);
      final response = await http.post(
        url,
        headers: headers,
        body:body,
      );
      print(response.body);
      if (response.statusCode == 200) {

        Note note = Note();

        return NoteResult(data: [note],msg: 'Edit success');
      } else if (response.statusCode == 422) {
        final _msg = json.decode(response.body);
        return NoteResult(msg: _msg['message']);
      } else if (response.statusCode == 401) {
        return NoteResult(msg: "Sesi Token Habis");
      } else {
        return NoteResult(msg: "Server sedang bermasalah");
      }
    } catch (e) {
      print(e);
      return NoteResult(msg: "Internet tidak dapat terhubung keserver");
    }
  }

  Future<NoteResult> deleteNote(int id) async {
    final url = "https://ardianbagus.com/udacoding/api/note/$id";

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'bearer $token4',
    };

    Map<String, String> body = {'_method': 'DELETE'};

    try {
      print(url);
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );
      print(response.body);
      if (response.statusCode == 200) {

        Note note = Note();

        return NoteResult(data: [note],msg: 'Delete success');
      } else if (response.statusCode == 422) {
        final _msg = json.decode(response.body);
        return NoteResult(msg: _msg['message']);
      } else if (response.statusCode == 401) {
        return NoteResult(msg: "Sesi Token Habis");
      } else {
        return NoteResult(msg: "Server sedang bermasalah");
      }
    } catch (e) {
      print(e);
      return NoteResult(msg: "Internet tidak dapat terhubung keserver");
    }
  }
}
