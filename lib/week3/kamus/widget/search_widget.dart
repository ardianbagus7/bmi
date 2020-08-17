part of '../../week3.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    Key key,
    @required this.maxWidht,
    @required this.searchController,
    @required this.search,
  }) : super(key: key);

  final double maxWidht;
  final TextEditingController searchController;
  final Function search;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Stack(
        children: [
          ClipPath(
            clipper: CustomClipPath2(),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      colorAccent1,
                      colorMain,
                    ],
                    stops: [
                      0.0,
                      1.0
                    ],
                    begin: FractionalOffset.topLeft,
                    end: FractionalOffset.bottomRight,
                    tileMode: TileMode.repeated),
              ),
            ),
          ),
          Positioned(
            top: 15,
            child: SafeArea(
                child: Container(
              width: maxWidht,
              alignment: Alignment.center,
              child: Text(
                'Kamus Antariksa',
                style: whiteTextFont.copyWith(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: searchController,
                maxLines: 1,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: 'Cari..',
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10),
                ),
                textInputAction: TextInputAction.search,
                onChanged: (value) => search(value),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
