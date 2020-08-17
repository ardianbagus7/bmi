part of '../../week3.dart';

class KamusRepository {
  Future<KamusResult> getKamus() async {
    final url = "http://52.163.49.100/api/v1/kamus";

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
        final data = result['data'] as List;

        List<Kamus> kamus = data.map((e) => Kamus.fromJson(e)).toList();
        
        return KamusResult(data: kamus,json: data);
      } else {
        return KamusResult(msg: "Server sedang bermasalah");
      }
    } catch (e) {
      print(e);
      return KamusResult(msg: "Internet tidak dapat terhubung keserver");
    }
  }
}

