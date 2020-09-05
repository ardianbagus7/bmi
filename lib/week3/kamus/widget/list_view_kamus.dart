part of '../../week3.dart';

class ListKamus extends StatelessWidget {
  const ListKamus({
    Key key,
    @required this.searchData,
  }) : super(key: key);

  final List<Kamus> searchData;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 10),
                  color: Colors.white,
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        searchData[index].title,
                        style: blackTextFont.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        searchData[index].description,
                        style: blackTextFont.copyWith(
                          color: Colors.black54,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                );
              },
              childCount: searchData.length,
            ),
          ),
        ],
      ),
    );
  }
}
