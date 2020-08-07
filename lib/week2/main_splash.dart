part of 'week2.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Size layar
  double get maxWidht => MediaQuery.of(context).size.width;
  double get maxHeight => MediaQuery.of(context).size.height;

  // Animasi
  bool isSignIn = true;

  // Text Field
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

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
              (!isSignIn)
                  ? SignUp(
                      signIn: signIn,
                      signUp: signUp,
                      emailController: emailController,
                      passwordController: passwordController,
                      nameController: nameController,
                    )
                  : SignIn(
                      signIn: signIn,
                      signUp: signUp,
                      emailController: emailController,
                      passwordController: passwordController),
            ],
          ),
        ),
      ),
    );
  }

  void signIn() {
    if (isSignIn) {
      if (emailController.text == "admin" &&
          passwordController.text == "admin") {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => HomePage(
                      username: emailController.text,
                      password: passwordController.text,
                    )));
      } else {
        Flushbar(
          duration: Duration(milliseconds: 2000),
          flushbarPosition: FlushbarPosition.TOP,
          backgroundColor: Color(0xFFFF5C83),
          message: 'Username atau password salah!',
        )..show(context);
      }
    } else {
      setState(() {
        isSignIn = true;
      });
    }
  }

  void signUp() {
    setState(() {
      isSignIn = false;
    });
  }

  Text heading(String text) {
    return Text(
      text,
      style: blackTextFont.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
    );
  }
}
