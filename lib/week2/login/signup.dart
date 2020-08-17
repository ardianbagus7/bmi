part of '../week2.dart';

class SignUp extends StatelessWidget {
  const SignUp({
    Key key,
    @required this.emailController,
    @required this.passwordController,
    @required this.nameController,
    @required this.nomorController,
    @required this.signIn,
    @required this.signUp,
  }) : super(key: key);

  final Function signIn;
  final Function signUp;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController nameController;
  final TextEditingController nomorController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: mainPadding,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SafeArea(child: SizedBox(height: 20)),
          SlideUp(
            0.5,
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Text(
                'Create',
                style: blackTextFont.copyWith(
                    color: Colors.white,
                    fontSize: 27,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          SlideUp(
            0.75,
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Text(
                'Account',
                style: blackTextFont.copyWith(
                    color: Colors.white,
                    fontSize: 27,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Expanded(child: SizedBox(height: 10)),
          FadeInLeft(
            1,
            TextField(
              keyboardType: TextInputType.text,
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Name',
                hintStyle: blackTextFont.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.withOpacity(0.7)),
                prefixIcon: Icon(Icons.account_circle, color: colorMain),
                filled: true,
                fillColor: colorBg,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none),
              ),
            ),
          ),
          SizedBox(height: 20),
          FadeInRight(
            1,
            TextField(
              keyboardType: TextInputType.number,
              controller: nomorController,
              decoration: InputDecoration(
                hintText: 'Nomor HP',
                hintStyle: blackTextFont.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.withOpacity(0.7)),
                prefixIcon: Icon(Icons.phone, color: colorMain),
                filled: true,
                fillColor: colorBg,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none),
              ),
            ),
          ),
          SizedBox(height: 20),
          FadeInLeft(
            1,
            TextField(
              keyboardType: TextInputType.text,
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Email',
                hintStyle: blackTextFont.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.withOpacity(0.7)),
                prefixIcon: Icon(Icons.email, color: colorMain),
                filled: true,
                fillColor: colorBg,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none),
              ),
            ),
          ),
          SizedBox(height: 20),
          FadeInRight(
            1,
            TextField(
              obscureText: true,
              keyboardType: TextInputType.text,
              controller: passwordController,
              decoration: InputDecoration(
                hintText: 'Password',
                hintStyle: blackTextFont.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.withOpacity(0.7)),
                prefixIcon: Icon(Icons.lock, color: colorMain),
                filled: true,
                fillColor: colorBg,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none),
              ),
            ),
          ),
          SizedBox(height: 20),
          FadeInUp(
            1,
            InkWell(
              child: Container(
                height: 50,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: colorMain,
                ),
                child: Text(
                  'Sign up',
                  style: whiteTextFont.copyWith(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              onTap: () {
                signUp();
              },
            ),
          ),
          SizedBox(height: 10),
          FadeInUp(
            1.25,
            GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Already have account? ",
                      style: blackTextFont.copyWith(
                          fontSize: 14, color: Colors.grey.withOpacity(0.7))),
                  Text('Signin now',
                      style: blackTextFont.copyWith(
                          fontSize: 14, color: colorMain)),
                ],
              ),
              onTap: () {
                signIn();
              },
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
