part of '../../week3.dart';

class HomePageSQL extends StatefulWidget {
  final UserWeek3 user;

  HomePageSQL({this.user});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePageSQL> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBg,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Padding(
              padding: mainPadding,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        'https://firebasestorage.googleapis.com/v0/b/hackaton-imhf.appspot.com/o/login.png?alt=media&token=d359bfd1-db76-4452-8e41-3a37f5a13d17'),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          '${widget.user.name} ',
                          style: blackTextFont.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        AutoSizeText(
                          '${widget.user.email} ',
                          style: blackTextFont.copyWith(
                            color: Colors.black45,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        AutoSizeText(
                          '${widget.user.nomer}',
                          style: blackTextFont.copyWith(
                            color: Colors.black45,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => LoginSql()));
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
