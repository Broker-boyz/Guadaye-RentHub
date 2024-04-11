import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gojo_renthub/Myproperty/screens/add_screen.dart';
import 'package:gojo_renthub/mapService/screen/permissio_screen.dart';
import 'package:gojo_renthub/views/screens/bottom_navigation_pages/profile.dart';
import 'package:gojo_renthub/views/screens/home_and%20_details_page/home_page.dart';

import 'package:gojo_renthub/views/screens/bottom_navigation_pages/favorite_screen.dart';
import 'package:gojo_renthub/views/screens/bottom_navigation_pages/search_screen.dart';

class HomePage extends StatefulWidget {
  final String accountType;
  const HomePage({super.key, required this.accountType});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController pageController = PageController();
  final user = FirebaseAuth.instance.currentUser!;
  late PageController _pageController;
  int _selectedTab = 0;
  // List<Widget> pages = [
  // HomeScreen(pageController: _pageController),
  //   const FavoriteScreen(),
  //   const AddScreen(),
  //   const SearchScreen(),
  //   const ProfileScreen()
  // ];

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
    print('-----------------Account Type----------------');
    print(widget.accountType);
  }

  void _handleIndexChanged(int index) {
    setState(() {
      _selectedTab = index;
      _pageController.jumpToPage(index);
      print('-----------------Account Type----------------');
    print(widget.accountType);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: (value) => setState(() {
            _selectedTab = value;
          }),
          children: [
            HomeScreen(pageController: _pageController),
            const FavoriteScreen(),
            if(widget.accountType == 'Landlord')  const AddScreen(),
            const SearchScreen(),
            const ProfileScreen(),
          ],
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat, // Adjust as needed
        floatingActionButton: _selectedTab == 0
            ? TextButton.icon(
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.primary,
                  backgroundColor: Theme.of(context)
                      .colorScheme
                      .inversePrimary
                      .withOpacity(.7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Get.to(() => const MapPermissionPage(),
                      transition: Transition.fadeIn,
                      duration: const Duration(seconds: 1));
                },
                icon: const Icon(Icons.map),
                label: const Text('Maps'),
              )
            : const SizedBox(),
        bottomNavigationBar: SizedBox(
          height: 60,
          child: DotNavigationBar(
            backgroundColor: Theme.of(context).colorScheme.background,
            margin: const EdgeInsets.all(0),
            marginR: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            itemPadding: const EdgeInsets.symmetric(horizontal: 20),
            currentIndex: _selectedTab,
            onTap: (index) => _handleIndexChanged(index),
            selectedItemColor: Theme.of(context).colorScheme.inversePrimary,
            unselectedItemColor: const Color(0xFF9e9e9c),
            enableFloatingNavBar: false,
            dotIndicatorColor: Theme.of(context).colorScheme.background,
            items: [
              /// Home
              DotNavigationBarItem(
                icon: const Icon(
                  Icons.home_filled,
                  size: 30,
                ),
              ),

              /// Likes
              DotNavigationBarItem(
                icon: const Icon(
                  Icons.favorite_border,
                  size: 30,
                ),
              ),

              /// Add
              if(widget.accountType == 'Landlord') 
                DotNavigationBarItem(
                  icon: const Icon(
                    Icons.add,
                    size: 30,
                  ),
                ),
                // :DotNavigationBarItem(
                //   icon: const Icon(
                //     Icons.remove,
                //     size: 4,
                //   ),
                // ),

              /// Search
              DotNavigationBarItem(
                icon: const Icon(
                  Icons.search,
                  size: 30,
                ),
              ),

              /// Profile
              DotNavigationBarItem(
                icon: const Icon(
                  Icons.person,
                  size: 30,
                ),
              ),
            ],
          ),
        ));
  }
}
