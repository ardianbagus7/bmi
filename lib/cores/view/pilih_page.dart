part of '../cores.dart';

class PilihPage extends StatelessWidget {
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
                    fontSize: 20, fontWeight: FontWeight.bold),
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
