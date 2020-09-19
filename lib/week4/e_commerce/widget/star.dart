part of '../../week4.dart';

class StarWidget extends StatelessWidget {
  final int star;
  final MainAxisAlignment mainAxis;

  const StarWidget(
      {Key key, this.star, this.mainAxis = MainAxisAlignment.start})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = List.generate(
      5,
      (index) => Icon(
        index < star ? Icons.star : Icons.star_outline,
        color: Colors.yellow,
        size: 20,
      ),
    );
    return Row(
      mainAxisAlignment: mainAxis,
      children: widgets,
    );
  }
}
