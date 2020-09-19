part of '../../week5.dart';

class MovieHomePage extends StatefulWidget {
  @override
  _MovieHomePageState createState() => _MovieHomePageState();
}

class _MovieHomePageState extends State<MovieHomePage> {
  Flushbar flush = Flushbar();
  PageController pageController;
  PageController bgController;

  Size get size => MediaQuery.of(context).size;
  double get movieItemWidth => size.width / 2 + 48;

  void logOut() {
    Navigator.pop(context);
    Provider.of<AuthProvider4>(context, listen: false).logOut();
  }

  void getMovie() async {
    flush.dismiss(true);

    MovieResult result =
        await Provider.of<MovieProvider>(context, listen: false).getMovie();
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

    bgController = PageController();
    pageController = PageController(viewportFraction: 0.85)
      ..addListener(() {
        bgController.jumpTo(pageController.page * size.width);
      });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MovieProvider>(
        builder: (BuildContext context, provider, child) {
          if (provider.movie != null) {
            return Stack(
              children: [
                //* BACKGROUND
                PageView.builder(
                  controller: bgController,
                  itemCount: provider.movie.length,
                  reverse: true,
                  itemBuilder: (context, index) {
                    return ImageCustom(image: provider.movie[index].image);
                  },
                ),
                Container(
                  width: size.width,
                  height: size.height,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                    child: Container(
                      color: Colors.black.withOpacity(0.50),
                    ),
                  ),
                ),
                //* KONTEN
                SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: mainPadding,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(Icons.menu,
                                  color: Colors.white, size: 30),
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
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          child: Text('Sign out',
                                              style: whiteTextFont.copyWith(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600)),
                                        ),
                                      ),
                                    ));
                                  },
                                );
                              },
                            ),
                            Text(
                              'Movies',
                              style: blackTextFont.copyWith(
                                fontSize: 28,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.bookmark_border,
                                  color: Colors.white, size: 30),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        MovieFavoritePage(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(child: SizedBox()),
                      Container(
                        height: size.height * 0.7,
                        child: PageView.builder(
                          controller: pageController,
                          itemCount: provider.movie.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: mainPadding,
                              child: GestureDetector(
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Hero(
                                          tag: provider.movie[index].image,
                                          child: ImageCustom(
                                            image: provider.movie[index].image,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      '${provider.movie[index].title}',
                                      style: blackTextFont.copyWith(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      '${provider.movie[index].category}',
                                      style: blackTextFont.copyWith(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    StarWidget(
                                      star: provider.movie[index].rating,
                                      mainAxis: MainAxisAlignment.center,
                                    ),
                                    SizedBox(height: 5),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          MovieDetailPage(
                                              movie: provider.movie[index]),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      Expanded(flex: 2, child: SizedBox()),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class ImageCustom extends StatelessWidget {
  const ImageCustom({
    Key key,
    this.image,
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) =>
          Center(child: Icon(Icons.image, color: Theme.of(context).cardColor)),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
