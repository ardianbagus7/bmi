part of '../../week5.dart';

class MovieFavoritePage extends StatefulWidget {
  @override
  _MovieFavoritePageState createState() => _MovieFavoritePageState();
}

class _MovieFavoritePageState extends State<MovieFavoritePage> {
  Flushbar flush = Flushbar();

  void getMovie() async {
    flush.dismiss(true);

    MovieResult result =
        await Provider.of<MovieProvider>(context, listen: false)
            .getFavoriteMovie();
    if (result.data == null) {
      flush = Flushbar<bool>(
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Color(0xFFFF5C83),
        message: result.msg,
        mainButton: FlatButton(
          onPressed: () => getMovie(),
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
    getMovie();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MovieProvider>(
        builder: (BuildContext context, provider, child) {
          if (provider.favoriteMovie != null) {
            return Column(
              children: [
                SafeArea(
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.chevron_left,
                            size: 30, color: colorMain),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Expanded(
                        child: Text(
                          'Favorite Movies',
                          style: blackTextFont.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: colorMain,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: CustomScrollView(
                    physics: BouncingScrollPhysics(),
                    slivers: [
                      SliverToBoxAdapter(child: SizedBox(height: 20)),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return GestureDetector(
                              child: Container(
                                padding: headerPadding,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        height: 150,
                                        width: 100,
                                        child: ImageCustom(
                                          image: provider
                                              .favoriteMovie[index].image,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${provider.favoriteMovie[index].title}',
                                            style: blackTextFont.copyWith(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            '${provider.favoriteMovie[index].category}',
                                            style: blackTextFont.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          StarWidget(
                                            star: provider
                                                .favoriteMovie[index].rating,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            '${provider.favoriteMovie[index].description}',
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: blackTextFont.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color:
                                                  Colors.grey.withOpacity(0.7),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          childCount: provider.favoriteMovie.length ?? 0,
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
