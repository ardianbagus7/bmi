part of '../week2.dart';


class CustomButton extends StatelessWidget {
  const CustomButton({
    Key key,
    this.text,
    this.function,
  }) : super(key: key);

  final String text;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withOpacity(0.0),
      child: Ink(
        decoration: BoxDecoration(
          color: (text == '=') ? colorMain : Colors.white,
          border: Border.all(width: 0.1, color: Colors.grey.withOpacity(0.4)),
        ),
        child: InkWell(
          splashColor: colorMain,
          child: (text == 'logo')
              ? Center(child: Icon(Icons.backspace, color: Colors.grey))
              : Center(
                  child: Text(
                    text,
                    style: blackNumberFont.copyWith(
                      fontSize:
                          (text == '+' || text == '-' || text == '=') ? 26 : 18,
                      color: (text == '=') ? Colors.white : Colors.grey,
                    ),
                  ),
                ),
          onTap: function,
        ),
      ),
    );
  }
}
