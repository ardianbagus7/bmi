part of '../../week4.dart';

class StarWidget extends StatelessWidget {
  final int star;

  const StarWidget({Key key, this.star}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = List.generate(
      5,
      (index) => Icon(
        index < star ? Icons.star : Icons.star_outline,
        color: Colors.yellow,
        size:20,
      ),
    );
    return Row(
      children:widgets,
    );
  }
}
