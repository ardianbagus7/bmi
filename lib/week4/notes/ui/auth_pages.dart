part of '../../week4.dart';

class AuthPage4 extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<AuthPage4> {
  // Size layar
  double get maxWidht => MediaQuery.of(context).size.width;
  double get maxHeight => MediaQuery.of(context).size.height;

  // Animasi
  bool isSignIn = true;
  bool isLoading = false;

  // Text Field
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController nomorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              ///NOTE: BACKGROUND
              SlideDown(
                0.5,
                ClipPath(
                  clipper: CustomClipPath1(),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            colorAccent1,
                            colorMain,
                          ],
                          stops: [
                            0.0,
                            1.0
                          ],
                          begin: FractionalOffset.topLeft,
                          end: FractionalOffset.bottomRight,
                          tileMode: TileMode.repeated),
                    ),
                  ),
                ),
              ),

              ///NOTE: VIEW
              (!isSignIn)
                  ? SignUp(
                      signIn: signIn,
                      signUp: signUp,
                      emailController: emailController,
                      passwordController: passwordController,
                      nameController: nameController,
                      nomorController: nomorController,
                    )
                  : SignIn(
                      signIn: signIn,
                      signUp: signUp,
                      emailController: emailController,
                      passwordController: passwordController),

              ///NOTE: LOADING
              (isLoading)
                  ? Container(
                      height: maxHeight,
                      width: maxWidht,
                      color: Colors.white60,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  void signIn() async {
    if (isSignIn) {
      if (emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty) {
        setState(() {
          isLoading = true;
        });

        AuthUser4Result result =
            await Provider.of<AuthProvider4>(context, listen: false).signin(
          emailController.text,
          passwordController.text,
        );

        if (result.data == null) {
          setState(() {
            isLoading = false;
          });
          Flushbar(
            duration: Duration(milliseconds: 2000),
            flushbarPosition: FlushbarPosition.TOP,
            backgroundColor: Color(0xFFFF5C83),
            message: result.msg,
          )..show(context);
        }
      } else {
        setState(() {
          isLoading = false;
        });

        Flushbar(
          duration: Duration(milliseconds: 2000),
          flushbarPosition: FlushbarPosition.TOP,
          backgroundColor: Color(0xFFFF5C83),
          message: 'Email atau password tidak boleh kosong!',
        )..show(context);
      }
    } else {
      setState(() {
        isSignIn = true;
        nameController.clear();
        emailController.clear();
        nomorController.clear();
        passwordController.clear();
      });
    }
  }

  void signUp() async {
    if (!isSignIn) {
      if (emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          nomorController.text.isNotEmpty &&
          nameController.text.isNotEmpty) {
        setState(() {
          isLoading = true;
        });

        AuthUser4Result result =
            await Provider.of<AuthProvider4>(context, listen: false).signup(
          emailController.text,
          passwordController.text,
          nameController.text,
        );

        if (result.data == null) {
          setState(() {
            isLoading = false;
          });
          Flushbar(
            duration: Duration(milliseconds: 2000),
            flushbarPosition: FlushbarPosition.TOP,
            backgroundColor: Color(0xFFFF5C83),
            message: result.msg,
          )..show(context);
        }
      } else {
        Flushbar(
          duration: Duration(milliseconds: 2000),
          flushbarPosition: FlushbarPosition.TOP,
          backgroundColor: Color(0xFFFF5C83),
          message: 'Data tidak boleh kosong!',
        )..show(context);
      }
    } else {
      setState(() {
        isSignIn = false;
        nameController.clear();
        emailController.clear();
        nomorController.clear();
        passwordController.clear();
      });
    }
  }

  Text heading(String text) {
    return Text(
      text,
      style: blackTextFont.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
    );
  }
}
