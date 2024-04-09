import 'package:flutter/material.dart';
import 'package:hackathon/pages/homepage/build_onboardpage.dart';
import 'package:hackathon/pages/homepage/reviewpage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() => isLastPage = index == 2);
          },
          children: [
            BuildPage(
              color: Colors.black12,
              url: 'lib/animation/Animation - greenhome.json',
              title: 'Welcome to Gojo RentHub',
              subtitle:
                  'Explore a world of endless possibilities with Gojo RentHub! Our app is designed to simplify your search for the perfect home rental. From cozy apartments to spacious houses, we\'ve got you covered. Get started today and find your dream home hassle-free!',
            ),
            BuildPage(
              color: Colors.black12,
              url: 'lib/animation/Animation - home.json',
              title: 'Discover Your Ideal Space',
              subtitle:
                  'Let Gojo RentHub guide you through the journey of finding your ideal space. Our intuitive search features allow you to customize your preferences, from location and budget to amenities and more. Say goodbye to endless scrolling and let us match you with the perfect rental that fits your lifestyle.',
            ),
            BuildPage(
              color: Colors.black12,
              url: 'lib/animation/Like.json',
              title: 'Save Time, Find Your Home',
              subtitle:
                  'With Gojo RentHub, say goodbye to hours of searching and endless open house visits. Our smart algorithms do the heavy lifting for you, delivering personalized recommendations tailored to your needs. Spend less time searching and more time enjoying your new home. Start your rental journey with Gojo RentHub today!',
            ),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? TextButton(
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  backgroundColor: Colors.teal.shade700,
                  minimumSize: const Size.fromHeight(80)),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool('showHome', true);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Reviews()),
                );
              },
              child: Text(
                'Get Started',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              )
              )
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        controller.jumpToPage(2);
                      },
                      child: Text('Skip')),
                  Center(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: 3,
                      effect: WormEffect(activeDotColor: Colors.blue),
                      onDotClicked: (index) => controller.animateToPage(index,
                          duration: const Duration(microseconds: 500),
                          curve: Curves.easeInOut),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        controller.nextPage(
                            duration: const Duration(microseconds: 500),
                            curve: Curves.easeInOut);
                      },
                      child: Text('Next'))
                ],
              ),
            ),
    );
  }
}
