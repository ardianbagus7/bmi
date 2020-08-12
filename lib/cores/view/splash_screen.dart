part of '../cores.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  start() async {
    var _durasi = Duration(seconds: 3);
    return new Timer(_durasi, pageNavigasi);
  }

  ///ANCHOR: GANTI PAGE NAVIGASI
  void pageNavigasi() {
    //WEEK 1 LOGIN
    // Navigator.of(context).pushReplacementNamed('/login');
    //WEEK 2 BMI
    // Navigator.of(context).pushReplacementNamed('/bmi');
    Navigator.of(context).pushReplacementNamed('/pilih');
  }

  @override
  void initState() {
    super.initState();
    start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorMain,
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Image.asset('assets/udacoding_2.png'),
        ),
      ),
    );
  }
}
