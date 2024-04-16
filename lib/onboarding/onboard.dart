import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gojo_renthub/views/screens/auth/authpage.dart';
import 'package:gojo_renthub/views/screens/login_and_register_pages/login_or_register_page.dart';
import 'package:gojo_renthub/views/shared/fonts/nunito.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({super.key});

  @override
  State<OnBoard> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  double percentage = 0.33;
  List<Color> listOfColors = [
    Colors.teal,
    Colors.teal,
    // const Color.fromARGB(255, 98, 50, 182),

    // const Color.fromARGB(255, 182, 114, 26),
    Colors.blueAccent,
    Colors.blueAccent
    // const Color.fromARGB(255, 85, 7, 63)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
                flex: 5,
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (value) {
                    if (value >= _currentPage) {
                      setState(() {
                        percentage += 0.25;
                        _currentPage = value;
                      });
                    } else {
                      setState(() {
                        percentage -= 0.25;
                        _currentPage = value;
                      });
                    }
                  },
                  children: [
                    _buildPage(
                        imagePath: 'assets/onboarding/home2.jpg',
                        title:
                            'Unlock your next rental adventure with Guadaye RentHub',
                        description:
                            'Embark on a journey to find your ideal rental living space',
                        bgColor: listOfColors[_currentPage]),
                    _buildPage(
                        imagePath: 'assets/onboarding/222.jpg',
                        title: 'Find your perfect rental match',
                        description:
                            'Experience hassle-free home searching and renting like never before',
                        bgColor: listOfColors[_currentPage]),
                    _buildPage(
                      imagePath: 'assets/onboarding/1.jpg',
                      title: 'Discover your dream home for rent',
                      description:
                          'Explore a world of rental possibilities in the palm of your hand',
                      bgColor: listOfColors[_currentPage],
                    ),
                    _buildPage(
                      imagePath: 'assets/onboarding/3.jpg',
                      title: 'Let us help you find your dream home for rent',
                      description: '',
                      bgColor: listOfColors[_currentPage],
                    ),
                  ],
                )),
            Expanded(
                child: Container(
              color: listOfColors[_currentPage],
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SmoothPageIndicator(
                            controller: _pageController,
                            count: 4,
                            effect: const ExpandingDotsEffect(
                                activeDotColor: Colors.pink,
                                radius: 10,
                                dotHeight: 10,
                                dotWidth: 10),
                            onDotClicked: (index) {}),
                        TextButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const LoginOrRegisterPage(),
                                  ),
                                  (route) => false);
                            },
                            child: Text(
                              'Skip',
                              style: textStyleNunito(
                                  20, Colors.white, FontWeight.w400, 0.24),
                            )),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_currentPage < 3) {
                          _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease);
                        } else {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginOrRegisterPage(),
                              ),
                              (route) => false);
                        }
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            height: 55,
                            width: 55,
                            child: CircularProgressIndicator(
                              value: percentage,
                              backgroundColor:
                                  const Color.fromARGB(97, 146, 144, 144),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                  Colors.white),
                            ),
                          ),
                          CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: listOfColors[_currentPage],
                                size: 20,
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(
      {required String imagePath,
      required String title,
      required String description,
      required Color bgColor}) {
    return SafeArea(
      child: Container(
        color: bgColor,
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: textStyleNunito(
                        28, Colors.white, FontWeight.w900, 0.24),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    description,
                    style: textStyleNunito(
                        20, Colors.white, FontWeight.w400, 0.24),
                  ),
                  const SizedBox(height: 50),
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.34,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage(
                            imagePath,
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
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
