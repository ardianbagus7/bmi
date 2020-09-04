part of '../../week4.dart';

class HomePageMarketplace extends StatefulWidget {
  @override
  _HomePageMarketplaceState createState() => _HomePageMarketplaceState();
}

class _HomePageMarketplaceState extends State<HomePageMarketplace> {
  Flushbar flush = Flushbar();

  ///
  /// Methods
  ///
  int kategoriIndex = 0;
  void changeKategori(int i) async {
    flush.dismiss(true);
    setState(() {
      kategoriIndex = i;
    });
    if (kategoriIndex == 0) {
      MarketplaceResult result =
          await Provider.of<MarketplaceProvider>(context, listen: false)
              .getStore();
      if (result.data == null) {
        flush = Flushbar<bool>(
          flushbarPosition: FlushbarPosition.TOP,
          backgroundColor: Color(0xFFFF5C83),
          message: result.msg,
          mainButton: FlatButton(
            onPressed: () => changeKategori(i),
            child: Text(
              'Refresh',
              style: whiteTextFont.copyWith(fontSize: 16),
            ),
          ),
        )..show(context);
      }
    } else {
      MarketplaceResult result =
          await Provider.of<MarketplaceProvider>(context, listen: false)
              .getCategoryStore(kategoriMarketplace[kategoriIndex]);
      if (result.data == null) {
        flush = Flushbar<bool>(
          flushbarPosition: FlushbarPosition.TOP,
          backgroundColor: Color(0xFFFF5C83),
          message: result.msg,
          mainButton: FlatButton(
            onPressed: () => changeKategori(i),
            child: Text(
              'Refresh',
              style: whiteTextFont.copyWith(fontSize: 16),
            ),
          ),
        )..show(context);
      }
    }
  }

  void logOut() {
    Navigator.pop(context);
    Provider.of<AuthProvider4>(context, listen: false).logOut();
  }

  ///
  /// Lifecycle
  ///
  @override
  void initState() {
    changeKategori(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBg,
      body: SafeArea(
        child: Column(
          children: [
            appBarCustom(context),
            KategoriListView(
              function: changeKategori,
              kategoriIndex: kategoriIndex,
            ),
            Expanded(
              child: Consumer<MarketplaceProvider>(
                builder: (BuildContext context, provider, child) {
                  if (provider.marketplace != null && kategoriIndex == 0) {
                    return StoreGridView(listMarketplace: provider.marketplace);
                  }
                  if (provider.categoryMarketplace != null &&
                      kategoriIndex != 0) {
                    return StoreGridView(
                        listMarketplace: provider.categoryMarketplace);
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget appBarCustom(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return SingleChildScrollView(
                      child: GestureDetector(
                    onTap: logOut,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: colorMain,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text('Sign out',
                            style: whiteTextFont.copyWith(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ));
                },
              );
            },
          ),
          Text(
            'Marketplace',
            style: blackTextFont.copyWith(
                fontSize: 20, color: colorMain, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class StoreGridView extends StatelessWidget {
  const StoreGridView({
    Key key,
    this.listMarketplace,
  }) : super(key: key);

  final List<Marketplace> listMarketplace;

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      itemCount: listMarketplace.length,
      itemBuilder: (BuildContext context, int index) => GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  DetailMarketplacePage(marketplace: listMarketplace[index]),
            ),
          );
        },
        child: cardMarketplace(
          listMarketplace[index],
        ),
      ),
      staggeredTileBuilder: (int index) => StaggeredTile.count(2, 3),
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
      padding: headerPadding,
      physics: BouncingScrollPhysics(),
    );
  }

  Widget cardMarketplace(Marketplace marketplace) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(0.4),
                spreadRadius: 20),
          ],
        ),
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Hero(
                  tag: marketplace.image,
                  child: CachedNetworkImage(
                    imageUrl: marketplace.image,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => Center(
                        child: Icon(Icons.image,
                            color: Theme.of(context).cardColor)),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Text(
              '${marketplace.title}',
              style: blackTextFont.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.start,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              '${marketplace.category}',
              style: blackTextFont.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: colorMain,
              ),
              textAlign: TextAlign.start,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              intl.NumberFormat.currency(
                locale: 'id_ID',
                decimalDigits: 0,
                symbol: 'Rp. ',
              ).format(marketplace.price),
              style: blackTextFont.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
              textAlign: TextAlign.start,
              maxLines: 1,
            ),
            StarWidget(star: marketplace.star),
          ],
        ),
      ),
    );
  }
}
