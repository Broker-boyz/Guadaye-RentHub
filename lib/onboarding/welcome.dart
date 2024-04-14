import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gojo_renthub/onboarding/welcome_bloc.dart';
import 'package:gojo_renthub/onboarding/welcome_event.dart';
import 'package:gojo_renthub/onboarding/welcome_state.dart';
import 'package:gojo_renthub/views/screens/auth/authpage.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  int pageNumber = 0;
  PageController pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        body: Container(
          width: 375.w,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              PageView(
                controller: pageController,
                onPageChanged: (value) {
                  pageNumber = value;
                },
                children: [
                  _page(
                      1,
                      context,
                      'Next',
                      'Unlock your next rental adventure with Guadaye RentHub',
                      'Embark on a journey to find your ideal rental living space',
                      'assets/onboarding/2.jpg'),
                  _page(
                      2,
                      context,
                      'Next',
                      'Discover your dream home for rent',
                      'Explore a world of rental possibilities in the palm of your hand',
                      'assets/onboarding/1.jpg'),
                  _page(
                      3,
                      context,
                      'Get Started',
                      'Find your perfect rental match',
                      'Experience hassle-free home searching and renting like never before',
                      'assets/onboarding/3.jpg'),
                ],
              ),
              Positioned(
                bottom: 30.h,
                child: DotsIndicator(
                  position: pageNumber,
                  dotsCount: 3,
                  mainAxisAlignment: MainAxisAlignment.center,
                  decorator: DotsDecorator(
                    color: Colors.grey,
                    activeColor: Colors.blue,
                    size: const Size.square(8.0),
                    activeSize: const Size(10, 8),
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _page(int index, BuildContext context, String buttonName, String title,
      String subtitle, String imagePath) {
    return Column(
      children: [
        SizedBox(height: 20.h),
        SizedBox(
          height: 300.h,
          width: double.infinity,
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 15.h),
        Container(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 24.sp,
            ),
          ),
        ),
        SizedBox(height: 15.h),
        Container(
          width: 375.w,
          padding: EdgeInsets.only(right: 30.2, left: 30.w),
          child: Text(
            subtitle,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 16.sp),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (index < 3) {
              pageController.animateToPage(index,
                  duration: const Duration(seconds: 2),
                  curve: Curves.decelerate);
            } else {
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => const MyHomePage(),
              //   ),
              // );
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AuthPage(),
                  ),
                  (route) => false);
            }
          },
          child: Container(
            margin: EdgeInsets.only(top: 100.h),
            width: 325.w,
            height: 50.h,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(15.w),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  offset: const Offset(0, 1),
                  blurRadius: 2,
                  spreadRadius: 1,
                )
              ],
            ),
            child: Center(
              child: Text(
                buttonName,
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
