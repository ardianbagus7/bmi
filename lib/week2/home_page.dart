part of 'week2.dart';

class HomePage extends StatefulWidget {
  final String username;
  final String password;

  HomePage({this.username, this.password});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBg,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Username : ${widget.username}',
                style: blackTextFont.copyWith(
                    fontSize: 18, fontWeight: FontWeight.w600)),
            Text('Password : ${widget.password}',
                style: blackTextFont.copyWith(
                    fontSize: 18, fontWeight: FontWeight.w600)),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Login()));
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: colorMain,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text('Sign out',
                      style: whiteTextFont.copyWith(
                          fontSize: 18, fontWeight: FontWeight.w600)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
