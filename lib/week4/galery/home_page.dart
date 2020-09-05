part of '../week4.dart';

class GalleryHomePage extends StatefulWidget {
  @override
  _GalleryHomePageState createState() => _GalleryHomePageState();
}

class _GalleryHomePageState extends State<GalleryHomePage> {
  Flushbar flush = Flushbar();

  void getGallery() async {
    MarketplaceResult result =
        await Provider.of<MarketplaceProvider>(context, listen: false)
            .getStore();
    if (result.data == null) {
      flush = Flushbar<bool>(
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Color(0xFFFF5C83),
        message: result.msg,
        mainButton: FlatButton(
          onPressed: getGallery,
          child: Text(
            'Refresh',
            style: whiteTextFont.copyWith(fontSize: 16),
          ),
        ),
      )..show(context);
    }
  }

  ///
  /// Lifecycle
  ///
  @override
  void initState() {
    getGallery();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBg,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: headerPadding,
              alignment: Alignment.centerLeft,
              child: Text(
                'Gallery',
                style: blackTextFont.copyWith(
                  fontSize: 20,
                  color: colorMain,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Consumer<MarketplaceProvider>(
                  builder: (BuildContext context, provider, child) {
                if (provider.marketplace != null) {
                  return StaggeredGridView.countBuilder(
                    crossAxisCount: 4,
                    itemCount: provider.marketplace.length,
                    itemBuilder: (BuildContext context, int index) =>
                        GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => PhotoViewPage(
                              image: provider.marketplace[index].image,
                            ),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Hero(
                          tag: provider.marketplace[index].image,
                          child: CachedNetworkImage(
                            imageUrl: provider.marketplace[index].image,
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
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                    staggeredTileBuilder: (int index) =>
                        StaggeredTile.count(2, (index % 2 == 0) ? 3 : 2),
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                    padding: headerPadding,
                    physics: BouncingScrollPhysics(),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
            )
          ],
        ),
      ),
    );
  }
}
