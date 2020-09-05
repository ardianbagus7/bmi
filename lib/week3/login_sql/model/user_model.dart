part of '../../week3.dart';

class UserWeek3 {
  final String name;
  final String email;
  final int nomer;

  UserWeek3({this.name, this.email, this.nomer});
}

class AuthUser3Result {
  final String msg;
  final UserWeek3 data;

  AuthUser3Result({this.msg, this.data});
}
