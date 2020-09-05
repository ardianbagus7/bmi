part of '../../week4.dart';

class OnboardingMarketplacePage extends StatefulWidget {
  @override
  _OnboardingMarketplacePageState createState() =>
      _OnboardingMarketplacePageState();
}

class _OnboardingMarketplacePageState extends State<OnboardingMarketplacePage> {
  // Onboarding Text
  final List<String> title = ['Marketplace', 'Start Now'];
  final List<String> description = [
    'Central marketing ideas or messages, or benefit on product features, that are known or are likely to have maximum appeal to the target market segment',
    'Register now for get full experience here!',
  ];

  void nextPage() {
    if (index == 0) {
      pageController.animateToPage(1,
          duration: Duration(milliseconds: 600), curve: Curves.easeOut);
    } else if (index == 1) {
      setState(() {
        authWidget = AuthPage4();
      });
    }
  }

  // Page View
  PageController pageController;
  Widget authWidget = SizedBox();
  int index = 0;
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0, keepPage: false);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white,
            alignment: Alignment.center,
            child: PageView.builder(
              controller: pageController,
              itemCount: title.length,
              onPageChanged: (int i) {
                setState(() {
                  index = i;
                });
              },
              itemBuilder: (context, i) {
                return Column(
                  children: [
                    Expanded(child: SizedBox()),
                    FadeInUp(
                      0.5,
                      Container(
                        padding: mainPadding,
                        width: double.infinity,
                        child: Image.asset('assets/onboarding$i.png'),
                      ),
                    ),
                    FadeInUp(
                      0.6,
                      Text(
                        '${title[i]}',
                        style: blackTextFont.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: FadeInUp(
                        0.7,
                        Container(
                          padding: mainPadding,
                          child: Text(
                            '${description[i]}',
                            style: blackTextFont.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    Expanded(child: SizedBox()),
                  ],
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: nextPage,
              child: Container(
                height: 50,
                width: 150,
                padding: headerPadding,
                alignment: Alignment.centerRight,
                child: Text(
                  (index == 1) ? 'Get Started' : 'Next',
                  style: blackTextFont.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: colorMain,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 50,
              width: double.infinity,
              alignment: Alignment.center,
              child: SmoothPageIndicator(
                  controller: pageController,
                  count: title.length,
                  effect: WormEffect(),
                  onDotClicked: (index) {}),
            ),
          ),
          authWidget,
        ],
      ),
    );
  }
}
