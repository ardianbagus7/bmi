import 'package:flutter/material.dart';
import 'package:udacoding_bootcamp/bmi_calculator/hasil.dart';

import 'animation_number.dart';

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      body: Column(
        children: <Widget>[
          // TINGGI
          Container(
            height: maxHeight * 10 / 16,
            width: maxWidth,
            color: Colors.white10,
            child: Stack(
              children: <Widget>[
                // GARIS TINGGI
                Positioned(
                  top: maxHeight * 1 / 28,
                  left: maxWidth / 3,
                  child: SafeArea(
                    child: Text(
                      'Tinggi Badan (CM)',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      alignment: Alignment.topRight,
                      height: ((height / 220) * (maxHeight * 8 / 16)) + 5,
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
                                color: Colors.white.withOpacity(0.7),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // GAMBAR TINGGI
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: ((height / 220) * (maxHeight * 8 / 16)),
                    // height: _heightDouble.value,
                    child: Image.asset(
                      'assets/bmi$image.png',
                      alignment: Alignment.bottomCenter,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                // SLIDER
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    height: maxHeight * 8 / 16,
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackShape: CustomTrackShape(),
                        activeTrackColor: Colors.white.withOpacity(0.5),
                        inactiveTrackColor: Colors.white.withOpacity(0.2),
                        trackHeight: 10.0,
                        thumbColor: Colors.white,
                        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
                        overlayShape: RoundSliderOverlayShape(overlayRadius: 30.0),
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
              ],
            ),
          ),
          // BERAT BADAN
          Container(
            height: maxHeight * 4 / 16,
            width: maxWidth,
            color: Colors.blue,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Berat Badan (KG)',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 10),
                AnimatedFlipCounter(
                  duration: Duration(milliseconds: 500),
                  value: bb.toInt(),
                  color: Colors.white,
                  size: 40,
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.white.withOpacity(0.5),
                    inactiveTrackColor: Colors.white.withOpacity(0.2),
                    trackHeight: 10.0,
                    thumbColor: Colors.white,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 30.0),
                    overlayColor: Colors.red.withAlpha(32),
                  ),
                  child: Slider(
                    value: bb,
                    max: 200,
                    min: 0,
                    onChanged: (val) {
                      bb = val;
                      bb < 50 ? image = 1 : bb > 50 && bb < 90 ? image = 2 : image = 3;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),
          // HITUNG
          Container(
            height: maxHeight * 2 / 16,
            width: maxWidth,
            child: RaisedButton(
              color: Colors.red,
              child: Text('Hitung'),
              onPressed: () {
                double _hasil = bb / (height * height);
                Navigator.of(context).push(
                  PageRouteBuilder(
                    opaque: false,
                    pageBuilder: (BuildContext context, _, __) => HasilBMI(
                      _hasil,
                    ),
                  ),
                );
              },
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
    final double trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
