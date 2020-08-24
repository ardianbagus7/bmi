part of '../../week4.dart';

class MainPage4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MyApp4(
    );
  }
}

class MyApp4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider4>(
      builder: (context, provider, child) {
        switch (provider.status) {
          case Status.Uninitialized:
            return InitAuth4();
          case Status.Relogin:
            return Loading();
          case Status.Unauthenticated:
            return AuthPage4();
          case Status.Authenticated:
            return HomePage4();
          default:
            return Loading();
        }
      },
    );
  }
}

class InitAuth4 extends StatelessWidget {
  initAuthProvider(context) async {
    Provider.of<AuthProvider4>(context).initAuthProvider();
  }

  @override
  Widget build(BuildContext context) {
    initAuthProvider(context);

    return Scaffold(
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
            child: new CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
