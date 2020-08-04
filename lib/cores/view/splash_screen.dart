
part of '../cores.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  start() async {
    var _durasi = Duration(seconds:3);
    return new Timer(_durasi, pageNavigasi);
  }

  ///ANCHOR: GANTI PAGE NAVIGASI
  void pageNavigasi(){
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  void initState(){
    super.initState();
    start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF26049D),
        body: Center(child: Image.asset('assets/udacoding_2.png')),
    );
  }
}