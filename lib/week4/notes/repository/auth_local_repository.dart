part of '../../week4.dart';

class AuthLocalRepository4 {
    storeUserData(UserWeek4 user, email, password) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setString('email', email);
    await storage.setString('password', password);
    await storage.setString('token', user.token);
    await storage.setString('name', user.name);
  }

  Future<UserWeek4> getUserData() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    return UserWeek4(
      name: storage.getString('name'),
      token:  storage.getString('token'),
      email: storage.getString('email'),
    );
  }

  Future<EmailPW4> getEmailPw() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    return EmailPW4(
      email: storage.getString('email'),
      password: storage.getString('password'),
    );
  }

  Future<String> getToken() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    return storage.getString('token');
  }
}