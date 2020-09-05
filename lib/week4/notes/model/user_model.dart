part of '../../week4.dart';

class UserWeek4 {
  final String name;
  final String email;
  final String token;

  UserWeek4({this.name, this.email, this.token});
}

class AuthUser4Result {
  final String msg;
  final UserWeek4 data;

  AuthUser4Result({this.msg, this.data});
}

class EmailPW4 {
  final String email;
  final String password;

  EmailPW4({this.email, this.password});
}
