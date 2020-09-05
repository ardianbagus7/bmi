part of '../week2.dart';

class HomeBMI extends StatefulWidget {
  @override
  _HomeBMIState createState() => _HomeBMIState();
}

class _HomeBMIState extends State<HomeBMI> with TickerProviderStateMixin {
  double get maxHeight => MediaQuery.of(context).size.height;
  double get maxWidth => MediaQuery.of(context).size.width;

  double height = 140;
  double bb = 40;
  int image = 1;
  bool isHasil = false;
  double _hasil = 0;
  String keterangan;
  Color colorsKeterangan;
  bool isOpen = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Color(0xFF313131),
          ),
          PopUp(
            0.5,
            ClipPath(
              clipper: CustomClipPath(),
              child: Container(
                height: double.infinity,
                width: double.infinity,
                color: Color(0xFF363636),
              ),
            ),
          ),
          (isOpen)
              ? SizedBox()
              : Column(
                  children: <Widget>[
                    // TINGGI
                    Container(
                      height: maxHeight * 10 / 16,
                      width: maxWidth,
                      child: Stack(
                        children: <Widget>[

                          Positioned(
                            top: maxHeight * 1 / 28,
                            left: maxWidth / 3,
                            child: SafeArea(
                              child: FadeInUp(
                                0.5,
                                Text('Tinggi Badan (CM)',
                                    style: blackTextFont.copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey)),
                              ),
                            ),
                          ),
                          FadeInLeft(
                            0.5,
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  alignment: Alignment.topRight,
                                  height:
                                      ((height / 220) * (maxHeight * 8 / 16)) +
                                          5,
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        alignment: Alignment.topRight,
                                        child: AnimatedFlipCounter(
                                          duration: Duration(milliseconds: 500),
                                          value: height.toInt(),
                                          color: Colors.white,
                                          size: 25,
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.topRight,
                                          child: Divider(
                                            thickness: 2,
                                            color:
                                                Colors.white.withOpacity(0.7),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          PopUp(
                            0.5,
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: ((height / 220) * (maxHeight * 8 / 16)),
                                child: Image.asset(
                                  'assets/bmi$image.png',
                                  alignment: Alignment.bottomCenter,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),

                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: FadeInUp(
                              0.5,
                              Container(
                                height: maxHeight * 8 / 16,
                                child: SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    trackShape: CustomTrackShape(),
                                    activeTrackColor:
                                        Colors.white.withOpacity(0.5),
                                    inactiveTrackColor:
                                        Colors.white.withOpacity(0.2),
                                    trackHeight: 10.0,
                                    thumbColor: Colors.white,
                                    thumbShape: RoundSliderThumbShape(
                                        enabledThumbRadius: 15.0),
                                    overlayShape: RoundSliderOverlayShape(
                                        overlayRadius: 30.0),
                                    overlayColor: Colors.red.withAlpha(32),
                                  ),
                                  child: RotatedBox(
                                    quarterTurns: 3,
                                    child: Slider(
                                      value: height,
                                      max: 220,
                                      min: 0,
                                      onChanged: (val) {
                                        height = val;
                                        print(((height / 220)));
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // BERAT BADAN
                    Container(
                      height: maxHeight * 4 / 16,
                      width: maxWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FadeInUp(
                            0.5,
                            Text('Berat Badan (KG)',
                                style: blackTextFont.copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey)),
                          ),
                          SizedBox(height: 10),
                          FadeInUp(
                            0.5,
                            AnimatedFlipCounter(
                              duration: Duration(milliseconds: 500),
                              value: bb.toInt(),
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                          FadeInLeft(
                            0.5,
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: Colors.white.withOpacity(0.5),
                                inactiveTrackColor:
                                    Colors.white.withOpacity(0.2),
                                trackHeight: 10.0,
                                thumbColor: Colors.white,
                                thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 15.0),
                                overlayShape: RoundSliderOverlayShape(
                                    overlayRadius: 30.0),
                                overlayColor: Colors.red.withAlpha(32),
                              ),
                              child: Slider(
                                value: bb,
                                max: 200,
                                min: 0,
                                onChanged: (val) {
                                  bb = val;
                                  bb < 50
                                      ? image = 1
                                      : bb > 50 && bb < 90
                                          ? image = 2
                                          : image = 3;
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
          Align(
            alignment: Alignment.bottomCenter,
            child: PopUp(
              0.75,
              GestureDetector(
                onTap: () {
                  setState(() {
                    _hasil = bb / ((height / 100) * (height / 100));
                    if (_hasil <= 18.5) {
                      keterangan = "Underweight";
                      colorsKeterangan = Colors.yellow;
                    } else if (_hasil >= 18.5 && _hasil <= 24.9) {
                      keterangan = "Normal";
                      colorsKeterangan = Colors.green;
                    } else if (_hasil >= 25.0 && _hasil <= 29.9) {
                      keterangan = "Overweight";
                      colorsKeterangan = Colors.yellow;
                    } else {
                      keterangan = "Obese";
                      colorsKeterangan = Colors.red;
                    }
                    print(_hasil);
                    isHasil = true;
                  });
                  Future.delayed(Duration(milliseconds: 600), () {
                    setState(() {
                      isOpen = true;
                    });
                  });
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 600),
                  height: (isHasil) ? maxHeight : 60,
                  width: maxWidth,
                  curve: Curves.easeInOut,
                  alignment: Alignment.center,
                  margin: (isHasil) ? EdgeInsets.all(0) : EdgeInsets.all(16),
                  padding: (isHasil)
                      ? EdgeInsets.all(0)
                      : EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    borderRadius: (isHasil)
                        ? BorderRadius.circular(0)
                        : BorderRadius.circular(20),
                    color: colorBg,
                  ),
                  child: (!isHasil && !isOpen)
                      ? Text(
                          'Hitung',
                          style: whiteTextFont.copyWith(
                              fontSize: 17,
                              color: Color(0xFF313131),
                              fontWeight: FontWeight.bold),
                        )
                      : (isHasil && isOpen)
                          ? SafeArea(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  FadeInUp(
                                    0,
                                    Text(
                                      'BMI RESULT',
                                      style: whiteTextFont.copyWith(
                                        fontSize: 20,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  FadeInUp(
                                    0.25,
                                    Text(
                                      '${_hasil.toStringAsFixed(2)}',
                                      style: whiteNumberFont.copyWith(
                                        fontSize: 100,
                                        color: Color(0xFF363636),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  FadeInUp(
                                    0.5,
                                    Text(
                                      keterangan,
                                      style: whiteTextFont.copyWith(
                                        fontSize: 20,
                                        color: colorsKeterangan,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 50),
                                  FadeInUp(
                                    1,
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isHasil = false;
                                            isOpen = false;
                                            height = 140;
                                            bb = 40;
                                            image = 1;
                                          });
                                        },
                                        child: Container(
                                          height: 50,
                                          width: double.infinity,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF363636),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          child: Text(
                                            'Try Again',
                                            style: whiteTextFont.copyWith(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    @required RenderBox parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width, 0.0);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
