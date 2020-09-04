part of '../../week4.dart';

class AuthRepository4 {
  Future<AuthUser4Result> signin(String email, String password) async {
    final url = 'https://ardianbagus.com/udacoding/api/user/signin';

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
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = json.decode(response.body);

        UserWeek4 data = UserWeek4(
          email: result['user']['email'],
          name: result['user']['name'],
          token: result['token'],
        );
        return AuthUser4Result(data: data);
      } else if (response.statusCode == 404) {
        return AuthUser4Result(msg: "Email atau password salah");
      } else if (response.statusCode == 422) {
        final _msg = json.decode(response.body);
        return AuthUser4Result(msg: _msg['message']);
      } else if (response.statusCode == 401) {
        return AuthUser4Result(msg: "Sesi Token Habis");
      } else {
        return AuthUser4Result(msg: "Server sedang bermasalah");
      }
    } catch (e) {
      print(e);
      return AuthUser4Result(msg: "Internet tidak dapat terhubung keserver");
    }
  }

  Future<AuthUser4Result> signup(
      String email, String password, String nama, String nomer) async {
    final url = 'https://ardianbagus.com/udacoding/api/user/register';

    Map<String, String> body = {
      'email': email,
      'password': password,
      'name': nama,
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
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = json.decode(response.body);

        UserWeek4 data = UserWeek4(
          email: result['user']['email'],
          name: result['user']['name'],
          token: result['token'],
        );
        return AuthUser4Result(msg: 'Akun berhasil dibuat', data: data);
      } else if (response.statusCode == 404) {
        return AuthUser4Result(msg: "Email atau password salah");
      } else if (response.statusCode == 422) {
        final _msg = json.decode(response.body);
        return AuthUser4Result(msg: _msg['message']);
      } else {
        final _msg = json.decode(response.body);
        return AuthUser4Result(
            msg: _msg['message']
                .toString()
                .split("'")[0]
                .split("1062")[1]
                .trim());
      }
    } catch (e) {
      print(e);
      return AuthUser4Result(msg: "Internet tidak dapat terhubung keserver");
    }
  }
}
