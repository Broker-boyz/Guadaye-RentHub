import 'package:flutter/material.dart';
import 'package:gojo_renthub/Myproperty/model/my_property_model.dart';
import 'package:gojo_renthub/Myproperty/repo/my_property_repo.dart';
import 'package:gojo_renthub/views/screens/shimmer_efffects/search_screen_shimmer_effect.dart';
import 'package:gojo_renthub/views/shared/fonts/nunito.dart';

final MyPropertyRepo _repo = MyPropertyRepo();

FutureBuilder<List<MyProperty>> filteredSearchSource(String propertyType,
      String city, String subCity, List<int> priceRange) {
  return FutureBuilder(
    future: _repo.loadFilteredProperties(propertyType, city, subCity, priceRange),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const SearchScreenShimmerEffect();
      } else if (snapshot.hasError) {
        return Center(
          child: Text(
            snapshot.error.toString(),
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        );
      } else if (snapshot.hasData) {
        print('snapshot has data ${snapshot.data}');
        final propertyy = snapshot.data;
        return Expanded(
          child: Container(
            child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final _property = snapshot.data![index];
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.4,
                    margin: const EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(children: [
                          Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.29,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(_property.imageUrl[0]),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 12,
                            right: 10,
                            child: CircleAvatar(
                              backgroundColor: Colors.black26,
                              radius: 20,
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.favorite_border)),
                            ),
                          )
                        ]),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    _property.address,
                                    style: textStyleNunito(
                                        20,
                                        Theme.of(context)
                                            .colorScheme
                                            .inversePrimary,
                                        FontWeight.w900,
                                        0),
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.star_half_outlined,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                              Text(
                                  _property.noOfRooms.split(',').elementAt(0),
                                  style: textStyleNunito(16,
                                      Colors.grey[800]!, FontWeight.w700, 0)),
                              const SizedBox(
                                height: 5,
                              ),
                              Text('${_property.price} Birr/year',
                                  style: textStyleNunito(
                                      16,
                                      Theme.of(context)
                                          .colorScheme
                                          .inversePrimary,
                                      FontWeight.w900,
                                      0)),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }),
          ),
        );
      
      } else {
        return const Center(
          child: Text(
            'IDK what happened to you...',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        );
      }
    },
  );
}