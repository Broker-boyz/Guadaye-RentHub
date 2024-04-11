import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:gojo_renthub/Myproperty/model/my_property_model.dart';
import 'package:gojo_renthub/Myproperty/repo/my_property_repo.dart';
import 'package:gojo_renthub/views/screens/home_and%20_details_page/property_detail_page.dart';
import 'package:gojo_renthub/views/screens/shimmer_efffects/home_screen_shimmer_effect.dart';
import 'package:gojo_renthub/views/shared/fonts/nunito.dart';

final MyPropertyRepo _repo = MyPropertyRepo();

FutureBuilder<List<MyProperty>> categorySource(String categoryString) {
  return FutureBuilder(
    future: _repo.loadMyProperties(categoryString),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return HomeScreenShimmerEffect(snapshot: snapshot);
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
        // print('snapshot has data ${snapshot.data}');
        // final propertyy = snapshot.data;
        return SizedBox(
          child: ListView.builder(
              itemCount: snapshot.data!.length + 1,
              itemBuilder: (context, index) {
                final property = index < snapshot.data!.length
                    ? snapshot.data![index]
                    : null;
                return index < snapshot.data!.length
                    ? Container(
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
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => PropertyDetailPage(
                                        myProperty: property,
                                      ));
                                },
                                child: Container(
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height * 0.29,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                        property!.imageUrl[0],
                                      ),
                                      fit: BoxFit.fill,
                                    ),
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
                                        property.address,
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
                                      property.noOfRooms
                                          .split(',')
                                          .elementAt(0),
                                      style: textStyleNunito(
                                          16,
                                          Colors.grey[800]!,
                                          FontWeight.w700,
                                          0)),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text('${property.price} ETB, Month',
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
                      )
                    : SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.29,
                      );
              }),
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
