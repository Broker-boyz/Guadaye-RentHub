import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gojo_renthub/controllers/theme_provider/theme_provider.dart';
import 'package:gojo_renthub/views/screens/home_and%20_details_page/home_page.dart';

import 'package:gojo_renthub/views/screens/bottom_navigation_pages/favorite_screen.dart';
import 'package:gojo_renthub/views/screens/bottom_navigation_pages/product_screen.dart';
import 'package:gojo_renthub/views/screens/bottom_navigation_pages/profile_screen.dart';
import 'package:gojo_renthub/views/screens/bottom_navigation_pages/search_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  late PageController _pageController;
  int _selectedTab = 0;
  List<Widget> pages = [
    const HomeScreen(),
    const FavoriteScreen(),
    const SearchScreen(),
    const ProfileScreen()
  ];

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  void _handleIndexChanged(int index) {
    setState(() {
      _selectedTab = index;
      _pageController.jumpToPage(index);
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
        children: [...pages],
      ),
      bottomNavigationBar: DotNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        margin: const EdgeInsets.all(0),
        marginR: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        itemPadding: const EdgeInsets.symmetric(horizontal: 16),
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
              size: 36,
            ),
          ),

          /// Likes
          DotNavigationBarItem(
            icon: const Icon(
              Icons.favorite_border,
              size: 36,
            ),
          ),

          /// Search
          DotNavigationBarItem(
            icon: const Icon(
              Icons.search,
              size: 36,
            ),
          ),
      
          /// Profile
          DotNavigationBarItem(
            icon: const Icon(
              Icons.person,
              size: 36,
            ),
          ),
        ],
      ),
    );
  }
}
