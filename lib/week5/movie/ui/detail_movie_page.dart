part of '../../week5.dart';

class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage({
    this.movie,
  });

  final Movie movie;

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage>
    with TickerProviderStateMixin {
  Flushbar flush = Flushbar();
  // NOTE: ANIMASI APP BAR
  ScrollController scrollControl;
  AnimationController _appBarAnimationController;
  Animation _opacityTween,
      _transformTween,
      _zoomTween,
      _textTween,
      _zoomTextTween;
  bool favorite = false;
  bool isLoading = false;

  // video
  YoutubePlayerController _controller;

  void animation() {
    _appBarAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 0));
    _opacityTween =
        Tween<double>(begin: 1, end: 0).animate(_appBarAnimationController);
    _transformTween =
        Tween<double>(begin: 0, end: -200).animate(_appBarAnimationController);
    _zoomTween =
        Tween<double>(begin: 1, end: 1.5).animate(_appBarAnimationController);
    _zoomTextTween =
        Tween<double>(begin: 0.7, end: 1).animate(_appBarAnimationController);

    _textTween = Tween(begin: Offset(30, 15), end: Offset(0, 15))
        .animate(_appBarAnimationController);
  }

  bool _scrollListener(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.axis == Axis.vertical) {
      _appBarAnimationController.animateTo(scrollInfo.metrics.pixels / 250);
      return true;
    } else {
      return false;
    }
  }

  // favorite
  void favoriteMethod() async {
    flush.dismiss(true);
    MovieResult result;
    setState(() {
      isLoading = true;
    });
    if (!widget.movie.status) {
      result = await Provider.of<MovieProvider>(context, listen: false)
          .addFavorite(widget.movie.id);
    } else {
      result = await Provider.of<MovieProvider>(context, listen: false)
          .deleteFavorite(widget.movie.id);
    }
    await Provider.of<MovieProvider>(context, listen: false).getMovie();
    setState(() {
      favorite = !favorite;
      isLoading = false;
    });

    if (result.data == null) {
      flush = Flushbar<bool>(
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Color(0xFFFF5C83),
        message: result.msg,
        mainButton: FlatButton(
          onPressed: () => favoriteMethod(),
          child: Text(
            'Refresh',
            style: whiteTextFont.copyWith(fontSize: 16),
          ),
        ),
      )..show(context);
    }
  }

  @override
  void initState() {
    animation();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.movie.video),
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
    favorite = widget.movie.status;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBg,
      body: NotificationListener<ScrollNotification>(
          onNotification: _scrollListener,
          child: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              customAppBar(),
              SliverToBoxAdapter(
                child: Padding(
                  padding: mainPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Divider(thickness: 1),
                      SizedBox(height: 10),
                      Text(
                        'Trailer',
                        style: blackTextFont.copyWith(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      YoutubePlayer(
                        controller: _controller,
                        showVideoProgressIndicator: true,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Description',
                        style: blackTextFont.copyWith(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '${widget.movie.description}',
                        style: blackTextFont.copyWith(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: 250)
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }

  AnimatedBuilder customAppBar() {
    return AnimatedBuilder(
      animation: _appBarAnimationController,
      builder: (context, child) => SliverAppBar(
        backgroundColor: colorBg,
        expandedHeight: 300,
        floating: false,
        pinned: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: CircleAvatar(
            backgroundColor: colorBg,
            child: Icon(
              Icons.chevron_left,
              size: 30,
              color: colorMain,
            ),
          ),
        ),
        actions: [
          CircleAvatar(
            backgroundColor: colorBg,
            child: isLoading
                ? CircularProgressIndicator()
                : IconButton(
                    icon: Icon(
                        favorite ? Icons.bookmark : Icons.bookmark_border,
                        color: colorMain),
                    onPressed: favoriteMethod,
                  ),
          ),
          SizedBox(width: 16),
        ],
        flexibleSpace: FlexibleSpaceBar(
          collapseMode: CollapseMode.parallax,
          title: Transform.scale(
            scale: _zoomTextTween.value,
            child: Transform.translate(
              offset: _textTween.value,
              child: Wrap(
                direction: Axis.vertical,
                children: <Widget>[
                  Text(
                    widget.movie.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: blackTextFont.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.movie.category,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: blackTextFont.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Opacity(
                    opacity: _opacityTween.value,
                    child: StarWidget(
                      star: widget.movie.rating,
                    ),
                  ),
                ],
              ),
            ),
          ),
          background: Stack(
            children: <Widget>[
              Container(
                height: 230,
                decoration: BoxDecoration(
                  image: new DecorationImage(
                    fit: BoxFit.cover,
                    image: new CachedNetworkImageProvider(widget.movie.image),
                  ),
                ),
              ),
              Positioned(
                left: 16,
                bottom: 0,
                child: Transform(
                  transform:
                      Matrix4.translationValues(0, _transformTween.value, 0)
                        ..scale(_zoomTween.value),
                  child: Opacity(
                    opacity: _opacityTween.value,
                    child: Hero(
                      tag: '${widget.movie.image}',
                      child: Container(
                        width: 100,
                        height: 150,
                        child: ImageCustom(
                          image: widget.movie.image,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
