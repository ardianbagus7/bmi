part of '../../week4.dart';

enum Status {
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated,
  Relogin
}

String token4;

class AuthProvider4 extends ChangeNotifier {
  ///
  /// Depedency
  ///
  AuthRepository4 authRepository4 = AuthRepository4();
  AuthLocalRepository4 authLocalRepository4 = AuthLocalRepository4();

  ///
  /// Data
  ///
  Status status = Status.Uninitialized;
  UserWeek4 user;

  //! METHOD
  
  ///
  ///NOTE: Init
  ///
  initAuthProvider() async {
    UserWeek4 _user = await authLocalRepository4.getUserData();
    if (_user?.token != null) {
      user = _user;
      status = Status.Authenticated;
    } else {
      status = Status.Unauthenticated;
    }
    notifyListeners();
  }


  ///
  /// NOTE: Signin Method
  ///
  Future<AuthUser4Result> signin(String email, String password) async {
 


    AuthUser4Result result = await authRepository4.signin(email, password);
    
    if (result.data != null) {
      // change data
      user = result.data;
      status = Status.Authenticated;
      token4 = result.data.token;
      // Store local data
      await authLocalRepository4.storeUserData(result.data, email, password);
      print('login sukses');
    } else {
      status = Status.Unauthenticated;
    }

    notifyListeners();
    return result;
  }

  ///
  /// NOTE: Signup Method
  ///

  Future<AuthUser4Result> signup(
      String email, String password, String name) async {


    AuthUser4Result result = await authRepository4.signup(
      email,
      password,
      name,
      ''
    );

    if (result.data != null) {
      // change data
      user = result.data;
      status = Status.Authenticated;
      token4 = result.data.token;

      // Store local data
      await authLocalRepository4.storeUserData(result.data, email, password);
    } else {
      status = Status.Unauthenticated;
    }

    notifyListeners();
    return result;
  }

  ///
  ///NOTE: Logout Method
  ///
  logOut([bool tokenExpired = false]) async {
    if (tokenExpired == true) {
      await reLogin();
    } else {
      status = Status.Unauthenticated;
      SharedPreferences storage = await SharedPreferences.getInstance();
      await storage.clear();
      user = null;
      token4 = null;
      notifyListeners();
    }
  }

  ///
  ///NOTE: ReLogin Method
  ///
  Future reLogin() async {
    status = Status.Authenticating;
    notifyListeners();

    EmailPW4 emailPW = await authLocalRepository4.getEmailPw();
    await signin(emailPW.email, emailPW.password);
  }
}
