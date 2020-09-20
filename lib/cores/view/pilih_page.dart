part of '../cores.dart';

class PilihPage extends StatefulWidget {
  @override
  _PilihPageState createState() => _PilihPageState();
}

class _PilihPageState extends State<PilihPage> {
  void navigate(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          switch (index) {
            case 0:
              return Week2();
            case 1:
              return Week3();
            case 2:
              return Week4();
            case 3:
              return Week5();
            default:
              return Week2();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          FadeInUp(
            0.5,
            Container(
              height: 100,
              width: double.infinity,
              alignment: Alignment.center,
              child: Text(
                'Udacoding Bootcamp',
                style: blackTextFont.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: colorMain,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Container(
              child: CustomScrollView(
                slivers: [
                  SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return FadeInUp(
                          0.5 + (index / 4),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              child: Container(
                                height: 100,
                                width: 100,
                                transform: Matrix4.translationValues(
                                    0, (index % 2 == 0) ? 0 : 50, 0),
                                decoration: BoxDecoration(
                                  color: colorMain,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'Week ${index + 2}',
                                  style: whiteTextFont.copyWith(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              onTap: () => navigate(context, index),
                            ),
                          ),
                        );
                      },
                      childCount: 4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

class Week2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBg,
      body: Padding(
        padding: mainPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FadeInLeft(
              0.5,
              Text(
                'WEEK 2 SUBMISSION',
                style: blackTextFont.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: colorMain,
                ),
              ),
            ),
            SizedBox(height: 20),
            CustomTapButton(
              text: 'Cek Login',
              function: () {
                Navigator.pushNamed(context, "/login");
              },
            ),
            SizedBox(height: 10),
            CustomTapButton(
              text: 'Kalkulator Sederhana',
              function: () {
                Navigator.pushNamed(context, "/kalkulator");
              },
            ),
            SizedBox(height: 10),
            CustomTapButton(
              text: 'BMI Kalkulator',
              function: () {
                Navigator.pushNamed(context, "/bmi");
              },
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class Week3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBg,
      body: Padding(
        padding: mainPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FadeInLeft(
              0.5,
              Text(
                'WEEK 3 SUBMISSION',
                style: blackTextFont.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: colorMain,
                ),
              ),
            ),
            SizedBox(height: 20),
            CustomTapButton(
              text: 'Login MySql',
              function: () {
                Navigator.pushNamed(context, "/loginweek3");
              },
            ),
            SizedBox(height: 10),
            CustomTapButton(
              text: 'Kamus',
              function: () {
                Navigator.pushNamed(context, "/kamus");
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Week4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBg,
      body: Padding(
        padding: mainPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FadeInLeft(
              0.5,
              Text(
                'WEEK 4 SUBMISSION',
                style: blackTextFont.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: colorMain,
                ),
              ),
            ),
            SizedBox(height: 20),
            CustomTapButton(
              text: 'Note',
              function: () {
                Navigator.pushNamed(context, '/note');
              },
            ),
            SizedBox(height: 10),
            CustomTapButton(
              text: 'Marketplace',
              function: () {
                Navigator.pushNamed(context, '/marketplace');
              },
            ),
            SizedBox(height: 10),
            CustomTapButton(
              text: 'Gallery',
              function: () {
                Navigator.pushNamed(context, '/gallery');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Week5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBg,
      body: Padding(
        padding: mainPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FadeInLeft(
              0.5,
              Text(
                'WEEK 5 SUBMISSION',
                style: blackTextFont.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: colorMain,
                ),
              ),
            ),
            SizedBox(height: 20),
            CustomTapButton(
              text: 'Movie',
              function: () {
                Navigator.pushNamed(context, '/movie');
              },
            ),
            SizedBox(height: 10),
            CustomTapButton(
              text: 'Youtube',
              function: () {
                Navigator.pushNamed(context, '/youtube');
              },
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class CustomTapButton extends StatelessWidget {
  const CustomTapButton({
    Key key,
    this.function,
    this.text,
  }) : super(key: key);

  final String text;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      0.5,
      GestureDetector(
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
              color: colorMain, borderRadius: BorderRadius.circular(16)),
          alignment: Alignment.center,
          child: Text(text, style: whiteTextFont.copyWith(fontSize: 18)),
        ),
        onTap: function,
      ),
    );
  }
}
