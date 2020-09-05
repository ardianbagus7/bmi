part of '../../week4.dart';

class MarketplaceProvider extends ChangeNotifier {
  ///
  /// Depedency
  ///
  MarketplaceRepository marketplaceRepository = MarketplaceRepository();
  AuthProvider4 authProvider4 = AuthProvider4();

  ///
  /// Data
  ///
  List<Marketplace> marketplace;
  List<Marketplace> categoryMarketplace;
  

  //! METHODS

  ///
  /// NOTE: get all store Method
  ///
  Future<MarketplaceResult> getStore() async {
    try {
      MarketplaceResult result = await marketplaceRepository.getStore();

      if (result != null) {
        // change data
        marketplace = result.data;
      }
      print('${result?.msg}');
      if (result?.msg == "Sesi Token Habis") {
        await authProvider4.logOut(true);
      }
      notifyListeners();
      return result;
    } catch (e) {
      print(e);
      return MarketplaceResult(msg:'Internet tidak dapat terhubung');
    }
  }
  ///
  /// NOTE: get all category store Method
  ///
  Future<MarketplaceResult> getCategoryStore(String query) async {
    try {
      categoryMarketplace = null;
      notifyListeners();
      
      MarketplaceResult result = await marketplaceRepository.getCategoryStore(query);

      if (result != null) {
        // change data
        categoryMarketplace = result.data;
      }
      print('${result?.msg}');
      if (result?.msg == "Sesi Token Habis") {
        await authProvider4.logOut(true);
      }
      notifyListeners();
      return result;
    } catch (e) {
      print(e);
      return MarketplaceResult(msg:'Internet tidak dapat terhubung');
    }
  }
}