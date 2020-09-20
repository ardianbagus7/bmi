part of '../../week5.dart';

class YoutubeHomePage extends StatefulWidget {
  @override
  _YoutubeHomePageState createState() => _YoutubeHomePageState();
}

class _YoutubeHomePageState extends State<YoutubeHomePage> {
  Flushbar flush = Flushbar();

  void getMovie() async {
    flush.dismiss(true);

    YoutubeResult result =
        await Provider.of<MovieProvider>(context, listen: false).getYoutube();
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
      backgroundColor: Colors.white,
      body: Consumer<MovieProvider>(
        builder: (BuildContext context, provider, child) {
          if (provider.youtube != null) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SafeArea(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          icon: Icon(Icons.chevron_left,
                              color: colorMain, size: 30),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                      Text(
                        'Youtube',
                        style: blackTextFont.copyWith(
                          fontSize: 20,
                          color: colorMain,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: CustomScrollView(
                    physics: BouncingScrollPhysics(),
                    slivers: [
                      SliverToBoxAdapter(child: SizedBox(height: 0)),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return GestureDetector(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 220,
                                    width: double.infinity,
                                    child: ImageCustom(
                                      image: provider.youtube[index].image,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: mainPadding,
                                    child: Text(
                                      '${provider.youtube[index].title}',
                                      style: blackTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: mainPadding,
                                    child: Text(
                                      '${provider.youtube[index].channelTitle} • ${timeAgoIndo(provider.youtube[index].publishedAt)}',
                                      style: blackTextFont.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        DetailYoutubePage(
                                            youtube: provider.youtube[index]),
                                  ),
                                );
                              },
                            );
                          },
                          childCount: provider.youtube.length ?? 0,
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
