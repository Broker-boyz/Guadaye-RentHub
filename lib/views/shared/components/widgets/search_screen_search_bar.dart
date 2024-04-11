import 'package:flutter/material.dart';
import 'package:gojo_renthub/views/screens/bottom_navigation_pages/filter_screen.dart';

class SearchScreenSearchBar extends StatelessWidget {
  final Function(String) onChanged;
  final Function(String) onFilterResultChanged;
   SearchScreenSearchBar({
    super.key, required this.onFilterResultChanged, required this.onChanged,
  });

  String filterResult = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Container(
        decoration: const BoxDecoration(),
        child: Row(
          children: [
            Expanded(
              child: Material(
                elevation: 5,
                // borderRadius: const BorderRadius.all(Radius.circular(27)),
                shape: RoundedRectangleBorder(
                    side: BorderSide.none,
                    borderRadius: BorderRadius.circular(17)),
                child: TextFormField(
                  onChanged: (value) {
                    onChanged(value);
                  },
                  onTap: () {},
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    hintStyle:
                        const TextStyle(fontSize: 17, color: Colors.black),
                    suffixIcon: const Icon(
                      Icons.search,
                      size: 30,
                      color: Colors.black,
                    ),
                    fillColor: Colors.white60.withOpacity(0.08),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(17),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            InkWell(
              onTap: () async{
                filterResult = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FilterScreen(),
                    ));
                onFilterResultChanged(filterResult);
              },
              child: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    borderRadius: const BorderRadius.all(Radius.circular(14))),
                child: const Icon(
                  Icons.tune_rounded,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
