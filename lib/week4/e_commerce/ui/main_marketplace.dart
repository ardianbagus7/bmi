part of '../../week4.dart';

class MainPageMarketplace extends StatelessWidget {
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
            return OnboardingMarketplacePage();
          case Status.Authenticated:
            return HomePageMarketplace();
          default:
            return Loading();
        }
      },
    );
  }
}
