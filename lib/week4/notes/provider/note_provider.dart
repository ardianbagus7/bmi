part of '../../week4.dart';

class NoteProvider extends ChangeNotifier {
  ///
  /// Depedency
  ///
  NoteRepository noteRepository = NoteRepository();
  AuthProvider4 authProvider4 = AuthProvider4();

  ///
  /// Data
  ///
  List<Note> notes;

  //! METHODS

  ///
  /// NOTE: get all notes Method
  ///
  Future<NoteResult> getNotes() async {
    try {
      NoteResult result = await noteRepository.getNote();

      if (result != null) {
        // change data
        notes = result.data;
      }
      print('${result?.msg}');
      if (result?.msg == "Sesi Token Habis") {
        await authProvider4.logOut(true);
      }
      notifyListeners();
      return result;
    } catch (e) {
      print(e);
      return NoteResult(msg:'Internet tidak dapat terhubung');
    }
  }
  
  ///
  /// NOTE: add note Method
  ///
  Future<NoteResult> addNote(String judul, String deskripsi) async {
    try {
      NoteResult result = await noteRepository.addNote(judul,deskripsi);

      if (result?.msg == "Sesi Token Habis") {
        await authProvider4.logOut(true);
      }
      notifyListeners();
      return result;
    } catch (e) {
      print(e);
      return NoteResult(msg:'Internet tidak dapat terhubung');
    }
  }

  ///
  /// NOTE: edit note Method
  ///
  Future<NoteResult> editNote(int id,String judul, String deskripsi) async {
    try {
      NoteResult result = await noteRepository.editNote(id,judul,deskripsi);

      if (result?.msg == "Sesi Token Habis") {
        await authProvider4.logOut(true);
      }
      notifyListeners();
      return result;
    } catch (e) {
      print(e);
      return NoteResult(msg:'Internet tidak dapat terhubung');
    }
  }
  
  ///
  /// NOTE: delete note Method
  ///
  Future<NoteResult> deleteNote(int id) async {
    try {
      NoteResult result = await noteRepository.deleteNote(id);

      if (result?.msg == "Sesi Token Habis") {
        await authProvider4.logOut(true);
      }
      notifyListeners();
      return result;
    } catch (e) {
      print(e);
      return NoteResult(msg:'Internet tidak dapat terhubung');
    }
  }

  Future<void> clear() async{
    notes = null;
  }
}
