part of '../../week3.dart';

class KamusPage extends StatefulWidget {
  @override
  _KamusPageState createState() => _KamusPageState();
}

class _KamusPageState extends State<KamusPage> {
  // Size layar
  double get maxWidht => MediaQuery.of(context).size.width;
  double get maxHeight => MediaQuery.of(context).size.height;

  // Text Controller
  TextEditingController searchController = TextEditingController();

  // Data
  KamusRepository kamusRepository = KamusRepository();
  List<Kamus> data;
  List<Kamus> searchData;
  List<dynamic> json;
  Flushbar flush = Flushbar();


  ///
  /// Get api
  ///
  void getData() async {
    flush.dismiss(true);
    KamusResult result = await kamusRepository.getKamus();
    if (result.data != null) {
      /// 
      /// Success get data
      /// 
      setState(() {
        data = result.data;
        searchData = result.data;
        json = result.json;
      });
    } else {
      ///
      /// Failed, show flushbar & retry button
      ///
      flush = Flushbar<bool>(
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Color(0xFFFF5C83),
        message: result.msg,
        mainButton: FlatButton(
          onPressed: getData,
          child: Text(
            'Refresh',
            style: whiteTextFont.copyWith(fontSize: 16),
          ),
        ),
      )..show(context);
    }
  }

  void search(String value) {
    setState(() {
      if (value.length == 0) {
        searchData = data;
      } else {
        final jsonSearch = json
            .where((string) =>
                string['title'].substring(0, value.length).toLowerCase() ==
                value.toLowerCase())
            .toList();
        searchData = jsonSearch.map((e) => Kamus.fromJson(e)).toList();
      }
    });
  }

  // Life Cycle
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBg,
      body: Column(
        children: [
          ///
          /// Search Widget
          ///
          SearchWidget(
              maxWidht: maxWidht,
              searchController: searchController,
              search: search),
          SizedBox(height: 10),
          ///
          /// List View Kamus
          ///
          Expanded(
            child: (data == null)
                ? Center(child: SizedBox(child: CircularProgressIndicator()))
                : ListKamus(searchData: searchData),
          ),
        ],
      ),
    );
  }
}
