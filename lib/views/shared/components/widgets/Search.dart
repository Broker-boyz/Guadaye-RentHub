import 'package:flutter/material.dart';

class FirstSearchBar extends StatelessWidget {
  const FirstSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Expanded(
                    child: Container(
                      decoration: const BoxDecoration(),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: 'Search',
                                hintStyle: const TextStyle(fontSize: 17),
                                suffixIcon: const Icon(
                                  Icons.search,
                                  size: 30,
                                  color: Colors.black,
                                ),
                                fillColor: Colors.lightBlue.withOpacity(0.08),
                                filled: true,
                                border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(17),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              height: 45,
                              width: 45,
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 2, 134, 196),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(14))),
                              child: const Icon(
                                Icons.tune,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
  }
}