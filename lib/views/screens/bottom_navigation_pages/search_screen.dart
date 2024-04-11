import 'package:flutter/material.dart';
import 'package:gojo_renthub/views/screens/bottom_navigation_pages/filtered_search_source.dart';
import 'package:gojo_renthub/views/screens/shimmer_efffects/search_screen_shimmer_effect.dart';
import 'package:gojo_renthub/views/shared/components/widgets/search_screen_search_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String filterResult = '';
  List<String> filterResultList = [];
  void _handleFilterResultChanged(String newFilterResult) {
    setState(() {
      filterResult = newFilterResult;
      if(filterResultList.isNotEmpty){
        filterResultList.clear();
      }
      for(var i = 0; i < filterResult.split('/').length; i++) {
          filterResultList.add(filterResult.split('/').elementAt(i));
      }
      print(filterResult);
      print(filterResultList);
    });
  }

  String searchResult = '';

  void _handleOnChange(String searchQuery){
    setState(() {
      searchResult = searchQuery;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 8, right: 8, bottom: 8),
          child: Column(
            children: [
              SearchScreenSearchBar(
                onFilterResultChanged: _handleFilterResultChanged,
                onChanged: _handleOnChange,
              ),
              if(searchResult == '' && filterResult == '')
               const SearchScreenShimmerEffect(),
              if(filterResult == '' && searchResult != '')
              filteredSearchSource('', '', searchResult, [2000, 100000]),
              if(filterResult.isNotEmpty)
              filteredSearchSource(filterResultList[0], filterResultList[1], filterResultList[2] , [int.parse(filterResultList[3].split('-').elementAt(0)),int.parse(filterResultList[3].split('-').elementAt(1))]),
            ],
          ),
        ),
      ),
    );
  }
}
