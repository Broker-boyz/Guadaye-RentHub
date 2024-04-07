import 'package:flutter/material.dart';
import 'package:gojo_renthub/views/screens/shimmer_efffects/home_screen_shimmer_effect.dart';
import 'package:gojo_renthub/views/shared/components/widgets/search_screen_search_bar.dart';
import 'package:shimmer/shimmer.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Row(
      //     children: [
      //       Expanded(
      //         child: TextField(
      //           decoration: const InputDecoration(
      //             hintText: 'Search...',
      //           ),
      //           onChanged: (value) {},
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 8, right: 8, bottom: 8),
          child: Column(
            children: [
              const SearchScreenSearchBar(),
              
              
            ],
          ),
        ),
      ),
    );
  }
}
