part of '../../week5.dart';

class DetailYoutubePage extends StatefulWidget {
  const DetailYoutubePage({
    this.youtube,
  });

  final Youtube youtube;

  @override
  _DetailYoutubePageState createState() => _DetailYoutubePageState();
}

class _DetailYoutubePageState extends State<DetailYoutubePage> {
  // video
  YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: widget.youtube.video,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Padding(
              padding: mainPadding,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.youtube.title}',
                      style: blackTextFont.copyWith(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${widget.youtube.channelTitle} • ${timeAgoIndo(widget.youtube.publishedAt)}',
                      style: blackTextFont.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 10),
                    Divider(thickness: 3, color: colorBg),
                    SizedBox(height: 10),
                    Text(
                      '${widget.youtube.description}',
                      style: blackTextFont.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
