part of '../../week3.dart';

class LoginSqlRepository {
  Future<AuthUser3Result> signin(String email, String password) async {
    final url = 'http://52.163.49.100/api/v1/user/signin';

    Map<String, String> body = {
      'email': email,
      'password': password,
    };

    Map<String, String> headers = {'Accept': 'application/json'};
    try {
      print(url);
      final response = await http.post(
        url,
        body: body,
        headers: headers,
      );
      print(response.body);
      if (response.statusCode == 200) {
        final result = json.decode(response.body);

        UserWeek3 data = UserWeek3(
          email: result['user']['email'],
          name: result['user']['name'],
          nomer: result['user']['nomer'],
        );
        return AuthUser3Result(data: data);
      } else if (response.statusCode == 404) {
        return AuthUser3Result(msg: "Email atau password salah");
      } else if (response.statusCode == 422) {
        final _msg = json.decode(response.body);
        return AuthUser3Result(msg: _msg['message']);
      } else {
        return AuthUser3Result(msg: "Server sedang bermasalah");
      }
    } catch (e) {
      print(e);
      return AuthUser3Result(msg: "Internet tidak dapat terhubung keserver");
    }
  }

  Future<AuthUser3Result> signup(
      String email, String password, String nama, String nomer) async {
    final url = 'http://52.163.49.100/api/v1/user/register';

    Map<String, String> body = {
      'email': email,
      'password': password,
      'name': nama,
      'nomer': nomer,
      'angkatan': '2020',
    };

    Map<String, String> headers = {'Accept': 'application/json'};

    try {
      print(url);
      final response = await http.post(
        url,
        body: body,
        headers: headers,
      );
      print(response.body);
      if (response.statusCode == 201) {
        final result = json.decode(response.body);

        UserWeek3 data = UserWeek3(
          email: result['user']['email'],
          name: result['user']['name'],
          nomer: int.parse(result['user']['nomer']),
        );
        return AuthUser3Result(msg: 'Akun berhasil dibuat', data: data);
      } else if (response.statusCode == 404) {
        return AuthUser3Result(msg: "Email atau password salah");
      } else if (response.statusCode == 422) {
        final _msg = json.decode(response.body);
        return AuthUser3Result(msg: _msg['message']);
      } else {
        return AuthUser3Result(msg: "Server sedang bermasalah");
      }
    } catch (e) {
      print(e);
      return AuthUser3Result(msg: "Internet tidak dapat terhubung keserver");
    }
  }
}
