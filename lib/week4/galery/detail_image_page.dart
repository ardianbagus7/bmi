part of '../week4.dart';

class PhotoViewPage extends StatelessWidget {
  final String image;

  const PhotoViewPage({Key key, this.image}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBg,
      body: SafeArea(
        child: Hero(
          tag: image,
          child: PhotoView(
            imageProvider: CachedNetworkImageProvider(image),
          ),
        ),
      ),
    );
  }
}
