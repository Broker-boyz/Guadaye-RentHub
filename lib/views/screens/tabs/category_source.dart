import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:gojo_renthub/Myproperty/model/my_property_model.dart';
import 'package:gojo_renthub/Myproperty/repo/my_property_repo.dart';
import 'package:gojo_renthub/views/screens/home_and%20_details_page/property_detail_page.dart';
import 'package:gojo_renthub/views/screens/shimmer_efffects/home_screen_shimmer_effect.dart';
import 'package:gojo_renthub/views/shared/fonts/nunito.dart';
import 'package:shimmer/shimmer.dart';

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
        return Expanded(
          child: Container(
            child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final property = snapshot.data![index];
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
                          CachedNetworkImage(
                            imageUrl:
                                'https://plus.unsplash.com/premium_photo-1661962841993-99a07c27c9f4?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aG91c2V8ZW58MHx8MHx8fDA%3D',
                            imageBuilder: (context, imageProvider) => Container(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.29,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                    colorFilter: const ColorFilter.mode(
                                        Colors.red, BlendMode.colorBurn)),
                              ),
                            ),
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => PropertyDetailPage(
                                    myProperty: property,
                                  ));
                            },
                            child: Container(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.29,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(property.imageUrl[0]),
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
                              Text(property.noOfRooms.split(',').elementAt(0),
                                  style: textStyleNunito(16, Colors.grey[800]!,
                                      FontWeight.w700, 0)),
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
                  );

                  // return Card(
                  //   elevation: 0,
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(
                  //         vertical: 5, horizontal: 2),
                  //     child: Row(
                  //       children: [
                  //         Padding(
                  //           padding: const EdgeInsets.all(8.0),
                  //           child: SizedBox(
                  //             height: 100,
                  //             width: 110,
                  //             child: ClipRRect(
                  //               borderRadius: BorderRadius.circular(20),
                  //               child: Image.asset(
                  //                 houseList[index].houseImage,
                  //                 fit: BoxFit.cover,
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //         const Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text("Orchad house",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                  //             Text("Birr 25000/year", style: TextStyle(color: Colors.blue)),
                  //             Row(
                  //               children: [
                  //                 Icon(Icons.king_bed),
                  //                 Text("6 bedroom"),
                  //                 SizedBox(width: 20,),
                  //                 Icon(Icons.bathtub),
                  //                 Text("4 bathroom")
                  //               ],
                  //             )
                  //           ],
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // );
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

Expanded newMethod(AsyncSnapshot<List<MyProperty>> snapshot) {
  return Expanded(
    child: Container(
      child: ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final property = snapshot.data![index];
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
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade400,
                    highlightColor: Colors.grey.shade100,
                    enabled: true,
                    child: Stack(children: [
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.29,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.white,
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
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey.shade400,
                          highlightColor: Colors.grey.shade100,
                          enabled: true,
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * .7,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  color: Colors.white,
                                ),
                                child: Text(
                                  property.address,
                                  style: textStyleNunito(
                                      20,
                                      Theme.of(context)
                                          .colorScheme
                                          .inversePrimary,
                                      FontWeight.w900,
                                      0),
                                ),
                              ),
                              const Spacer(),
                              Shimmer.fromColors(
                                baseColor: Colors.grey.shade400,
                                highlightColor: Colors.grey.shade100,
                                enabled: true,
                                child: Container(
                                  width: MediaQuery.of(context).size.width * .2,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color: Colors.white,
                                  ),
                                  child: const Icon(
                                    Icons.star_half_outlined,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Shimmer.fromColors(
                          baseColor: Colors.grey.shade400,
                          highlightColor: Colors.grey.shade100,
                          enabled: true,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: Colors.white,
                            ),
                            child: Text(
                              property.address,
                              style: textStyleNunito(
                                  20,
                                  Theme.of(context).colorScheme.inversePrimary,
                                  FontWeight.w900,
                                  0),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Shimmer.fromColors(
                          baseColor: Colors.grey.shade400,
                          highlightColor: Colors.grey.shade100,
                          enabled: true,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: Colors.white,
                            ),
                            child: Text(
                              property.address,
                              style: textStyleNunito(
                                  20,
                                  Theme.of(context).colorScheme.inversePrimary,
                                  FontWeight.w900,
                                  0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );

            // return Card(
            //   elevation: 0,
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(
            //         vertical: 5, horizontal: 2),
            //     child: Row(
            //       children: [
            //         Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: SizedBox(
            //             height: 100,
            //             width: 110,
            //             child: ClipRRect(
            //               borderRadius: BorderRadius.circular(20),
            //               child: Image.asset(
            //                 houseList[index].houseImage,
            //                 fit: BoxFit.cover,
            //               ),
            //             ),
            //           ),
            //         ),
            //         const Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text("Orchad house",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
            //             Text("Birr 25000/year", style: TextStyle(color: Colors.blue)),
            //             Row(
            //               children: [
            //                 Icon(Icons.king_bed),
            //                 Text("6 bedroom"),
            //                 SizedBox(width: 20,),
            //                 Icon(Icons.bathtub),
            //                 Text("4 bathroom")
            //               ],
            //             )
            //           ],
            //         )
            //       ],
            //     ),
            //   ),
            // );
          }),
    ),
  );
}
