part of '../../week4.dart';

List<String> kategoriMarketplace = [
  'Semua',
  'Pakaian',
  'Elektronik',
  'Kesehatan',
  'Olahraga'
];

class KategoriListView extends StatelessWidget {
  KategoriListView({
    Key key,
    @required this.function,
    @required this.kategoriIndex,
    this.kategoriScrollController,
    this.isInput = false,
  }) : super(key: key);

  final int kategoriIndex;
  final Function function;
  final ScrollController kategoriScrollController;
  final bool isInput;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: (isInput)?0:1,
            color: colorBg,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        controller: kategoriScrollController,
        itemCount: kategoriMarketplace.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, i) {
          if(isInput&&i==0){
            return SizedBox();
          }
          return InkWell(
            onTap: () => function(i),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                  left: (i == 0) ? 16 :(isInput&&i==1)?16: 10,
                  right: (kategoriMarketplace[i] == kategoriMarketplace.last) ? 16 : 0),
              decoration: BoxDecoration(
                color: (i == kategoriIndex)
                    ? colorMain
                    : Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.all(
                  Radius.circular(50.0),
                ),
              ),
              child: Text(
                '${kategoriMarketplace[i]}',
                style: blackTextFont.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: (kategoriIndex == i)
                      ? Colors.white
                      : Colors.grey.withOpacity(0.6),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
