part of '../week2.dart';

class Kalkulator extends StatefulWidget {
  @override
  _KalkulatorState createState() => _KalkulatorState();
}

class _KalkulatorState extends State<Kalkulator> {
  ///NOTE: LOGIC KALKULATOR
  double nilaiA, nilaiB, total = 0;
  String operator = "";
  var buffer = new StringBuffer();

  void addValue(String str) {
    setState(() {
      bool hitung = false;

      String strNow = " ";
      String lastCharacter = " ";

      if (buffer.isNotEmpty) {
        strNow = buffer.toString();
        lastCharacter = strNow.substring(strNow.length - 1);
      }
      print(lastCharacter);

      /// validation
      bool isLastCharacterOperator = (lastCharacter == "/" ||
          lastCharacter == "x" ||
          lastCharacter == "-" ||
          lastCharacter == "+");
      bool isInputOperator =
          (str == "/" || str == "x" || str == "-" || str == "+");

      /// Cek
      if ((isInputOperator && isLastCharacterOperator) ||
          (strNow[0] == "0" && str == "0") ||
          (buffer.isEmpty && isInputOperator)) {
        return;
      } else if (str == "=") {
        hitung = true;
      } else if (isInputOperator && (buffer.toString() != "0")) {
        if ((operator != "" && !isLastCharacterOperator) && strNow[0] != "-") {
          Flushbar(
            duration: Duration(milliseconds: 2000),
            flushbarPosition: FlushbarPosition.TOP,
            backgroundColor: Color(0xFFFF5C83),
            message: 'Kalkulator sederhana hanya bisa 1 operator',
          )..show(context);
          return;
        } else if (isLastCharacterOperator) {
          deleteValue();
          print('aw');
          buffer.write(str);
          operator = str;
          return;
        } else {
          operator = str;
        }
      } else if (str == "AC") {
        hitung = false;
        if (buffer.isNotEmpty) buffer.clear();
        buffer.write("0");
        total = 0;
        operator = "";
        return;
      } else if ((buffer.toString() == "0" ) && (str == '/'|| str == "x" || str == "+")) {
        return;
      }

      /// Logic
      if (!hitung) {
        /// TAMBAH BUFFER
        if (buffer.toString() == "0" && str != "0") {
          buffer.clear();
        }
        total = 0;
        buffer.write(str);
      } else {
        /// HITUNG
        List<String> values = buffer.toString().split(operator);
        if (values.length == 2 &&
            values[0].isNotEmpty &&
            values[1].isNotEmpty) {
          nilaiA = double.parse(values[0]);
          nilaiB = double.parse(values[1]);
          print('$nilaiA  $nilaiB');
          buffer.clear();
          switch (operator) {
            case "+":
              total = nilaiA + nilaiB;
              break;
            case "-":
              total = nilaiA - nilaiB;
              break;
            case "x":
              total = nilaiA * nilaiB;
              break;
            case "/":
              total = nilaiA / nilaiB;
              break;
            default:
          }

          operator = "";
          hitung = false;
        } else {
          Flushbar(
            duration: Duration(milliseconds: 2000),
            flushbarPosition: FlushbarPosition.TOP,
            backgroundColor: Color(0xFFFF5C83),
            message: 'Minimal 2 bilangan',
          )..show(context);
        }
      }
    });
  }

  void deleteValue() => setState(() {
        String str = buffer.toString();
        if (str.length > 0) {
          String lastCharacter = str.substring(str.length - 1);
          if (lastCharacter == "/" ||
              lastCharacter == "x" ||
              lastCharacter == "-" ||
              lastCharacter == "+") {
            operator = "";
          }
          str = str.substring(0, str.length - 1);
          buffer.clear();
          buffer.write(str.length == 0 ? "0" : str);
        }
      });

  ///NOTE: LIFE CYCLE
  @override
  void initState() {
    super.initState();
    buffer.write("0");
    operator = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBg,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                padding: headerPadding,
                alignment: Alignment.bottomRight,
                child: Text(
                  (total != 0) ? '$total' : buffer.toString(),
                  style: blackNumberFont.copyWith(fontSize: 35),
                  maxLines: 1,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: <Widget>[
                  ///NOTE: BARIS 1
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                          child: CustomButton(
                            text: '/',
                            function: () => addValue("/"),
                          ),
                        ),
                        Expanded(
                          child: CustomButton(
                            text: 'X',
                            function: () => addValue("x"),
                          ),
                        ),
                        Expanded(
                          child: CustomButton(
                            text: '-',
                            function: () => addValue("-"),
                          ),
                        ),
                        Expanded(
                          child: CustomButton(
                            text: '+',
                            function: () => addValue("+"),
                          ),
                        ),
                      ],
                    ),
                  ),

                  ///NOTE: BARIS 2
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                          child: CustomButton(
                            text: '7',
                            function: () => addValue("7"),
                          ),
                        ),
                        Expanded(
                          child: CustomButton(
                            text: '8',
                            function: () => addValue("8"),
                          ),
                        ),
                        Expanded(
                          child: CustomButton(
                            text: '9',
                            function: () => addValue("9"),
                          ),
                        ),
                        Expanded(
                          child: CustomButton(
                            text: 'AC',
                            function: () => addValue("AC"),
                          ),
                        ),
                      ],
                    ),
                  ),

                  ///NOTE: BARIS 3
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                          child: CustomButton(
                            text: '4',
                            function: () => addValue("4"),
                          ),
                        ),
                        Expanded(
                          child: CustomButton(
                            text: '5',
                            function: () => addValue("5"),
                          ),
                        ),
                        Expanded(
                          child: CustomButton(
                            text: '6',
                            function: () => addValue("6"),
                          ),
                        ),
                        Expanded(
                          child: CustomButton(
                            text: 'logo',
                            function: deleteValue,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    flex: 2,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: <Widget>[
                              ///NOTE: BARIS 4
                              Expanded(
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Expanded(
                                      child: CustomButton(
                                        text: '1',
                                        function: () => addValue("1"),
                                      ),
                                    ),
                                    Expanded(
                                      child: CustomButton(
                                        text: '2',
                                        function: () => addValue("2"),
                                      ),
                                    ),
                                    Expanded(
                                      child: CustomButton(
                                        text: '3',
                                        function: () => addValue("3"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              ///NOTE: BARIS 5
                              Expanded(
                                child: CustomButton(
                                  text: '0',
                                  function: () => addValue("0"),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: CustomButton(
                            text: '=',
                            function: () => addValue("="),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
