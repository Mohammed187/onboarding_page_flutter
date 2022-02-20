import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onboarding_page_flutter/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final controller = PageController();
  int currentPage = 0;
  bool isLastPage = false;

  final Color color_1 = const Color(0xffFFAF4E);
  final Color color_2 = const Color(0xffFFBE96);
  final Color color_3 = const Color(0xff1FB090);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget buildPage({
    required Color color,
    required String urlImage,
    required String title,
    required String subtitle,
  }) =>
      Container(
        color: color,
        padding: const EdgeInsets.only(bottom: 120.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SvgPicture.asset(
                urlImage,
                fit: BoxFit.contain,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 50.0),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
              child: Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          child: PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
                isLastPage = index == 2;
              });
            },
            children: [
              buildPage(
                  color: color_1,
                  urlImage: 'assets/images/inspiration.svg',
                  title: 'Get inspired',
                  subtitle:
                      'Don\'t know what to eat? Take a picture, we\'ll suggest things to cook with your ingredients.'),
              buildPage(
                  color: color_2,
                  urlImage: 'assets/images/healthy_options.svg',
                  title: 'Easy & healthy',
                  subtitle:
                      'Find thousands of easy and healthy recipes so you save time and eat better.'),
              buildPage(
                  color: color_3,
                  urlImage: 'assets/images/like_dislik.svg',
                  title: 'Save your favourites',
                  subtitle:
                      'Save your favourites recipes and get reminders to buy the ingredients to cook them.'),
            ],
          ),
        ),
      ),
      bottomSheet: isLastPage
          ? Container(
              height: 80,
              color: color_3,
              padding: const EdgeInsets.all(7.0),
              child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    backgroundColor: Colors.white,
                    primary: color_3,
                    minimumSize: const Size.fromHeight(70),
                  ),
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setBool('showHome', true);

                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ));
                  },
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.0,
                    ),
                  )),
            )
          : Container(
              color: currentPage == 0 ? color_1 : color_2,
              height: 80.0,
              child: Column(
                children: [
                  Center(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: 3,
                      effect: const ExpandingDotsEffect(
                        dotWidth: 7.0,
                        dotHeight: 7.0,
                        spacing: 5.0,
                        dotColor: Colors.white,
                        activeDotColor: Colors.white,
                      ),
                      onDotClicked: (index) => controller.animateToPage(index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () => controller.jumpToPage(2),
                          child: const Text(
                            'Skip',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )),
                      TextButton(
                        onPressed: () => controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        ),
                        child: Row(
                          children: const [
                            Text(
                              'Next',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              size: 16.0,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
    );
  }
}
