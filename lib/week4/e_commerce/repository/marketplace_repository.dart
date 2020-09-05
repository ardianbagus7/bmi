part of '../../week4.dart';

class MarketplaceRepository {
  Future<MarketplaceResult> getStore() async {
    final url = "https://ardianbagus.com/udacoding/api/marketplace";

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

        List<Marketplace> marketplace =
            data.map((e) => Marketplace.fromJson(e)).toList();
            
        return MarketplaceResult(data: marketplace);
      } else if (response.statusCode == 422) {
        final _msg = json.decode(response.body);
        return MarketplaceResult(msg: _msg['message']);
      } else if (response.statusCode == 401) {
        return MarketplaceResult(msg: "Sesi Token Habis");
      } else {
        return MarketplaceResult(msg: "Server sedang bermasalah");
      }
    } catch (e) {
      print(e);
      return MarketplaceResult(msg: "Internet tidak dapat terhubung keserver");
    }
  }

  Future<MarketplaceResult> getCategoryStore(String query) async {
    final url = "https://ardianbagus.com/udacoding/api/marketplace/search";

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'bearer $token4',
    };

    Map<String, String> body = {
      'query': '$query',
    };

    try {
      print(url);
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );
      print(response.body);
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        final data = result as List;

        List<Marketplace> marketplace =
            data.map((e) => Marketplace.fromJson(e)).toList();

        return MarketplaceResult(data: marketplace);
      } else if (response.statusCode == 422) {
        final _msg = json.decode(response.body);
        return MarketplaceResult(msg: _msg['message']);
      } else if (response.statusCode == 401) {
        return MarketplaceResult(msg: "Sesi Token Habis");
      } else {
        return MarketplaceResult(msg: "Server sedang bermasalah");
      }
    } catch (e) {
      print(e);
      return MarketplaceResult(msg: "Internet tidak dapat terhubung keserver");
    }
  }
}
