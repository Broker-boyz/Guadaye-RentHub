import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gojo_renthub/Myproperty/model/my_property_model.dart';
import 'package:gojo_renthub/views/shared/fonts/nunito.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreenShimmerEffect extends StatefulWidget {
  final AsyncSnapshot<List<MyProperty>> snapshot;
  const HomeScreenShimmerEffect({super.key, required this.snapshot});

  @override
  State<HomeScreenShimmerEffect> createState() =>
      _HomeScreenShimmerEffectState();
}

class _HomeScreenShimmerEffectState extends State<HomeScreenShimmerEffect> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            // final _property = widget.snapshot.data![index];
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
                                width: MediaQuery.of(context).size.width* .7,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(12.0),
                                  color: Colors.white,
                                ),
                                child: Text(
                                  '_property.address',
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
                                  width:
                                      MediaQuery.of(context).size.width *
                                          .2,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(12.0),
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
                        const SizedBox(height: 5,),
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
                              '_property.address',
                              style: textStyleNunito(
                                  20,
                                  Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
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
                              '_property.address',
                              style: textStyleNunito(
                                  20,
                                  Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
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
    );
      
  }
}

Shimmer newShimmerEffect() {
  return Shimmer.fromColors(
    baseColor: Colors.red,
    highlightColor: Colors.grey.shade100,
    enabled: true,
    period: const Duration(seconds: 30),
    child: SizedBox(
      width: 300,
      height: 300,
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
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
                  Shimmer.fromColors(
                    baseColor: Colors.blue,
                    highlightColor: Colors.grey.shade100,
                    enabled: true,
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.29,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        // image: DecorationImage(
                        //   image: NetworkImage(_property.imageUrl[0]),
                        //   fit: BoxFit.fill,
                        // ),
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
                          SizedBox(
                            height: 30,
                            width: double.infinity,
                            child: Text(
                              '_property.address',
                              style: textStyleNunito(
                                  20,
                                  Theme.of(context).colorScheme.inversePrimary,
                                  FontWeight.w900,
                                  0),
                            ),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.star_half_outlined,
                            color: Colors.black,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                        width: double.infinity,
                        child: Text(
                          '_property.address',
                          style: textStyleNunito(
                              20,
                              Theme.of(context).colorScheme.inversePrimary,
                              FontWeight.w900,
                              0),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: 30,
                        width: double.infinity,
                        child: Text(
                          '_property.address',
                          style: textStyleNunito(
                              20,
                              Theme.of(context).colorScheme.inversePrimary,
                              FontWeight.w900,
                              0),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    ),
  );
}

// return Shimmer.fromColors(
//           baseColor: Colors.red,
//           highlightColor: Colors.grey.shade100,
//           enabled: true,
//           child: Expanded(
//             child: Container(
//               child: ListView.builder(
//                   itemCount: snapshot.data!.length,
//                   itemBuilder: (context, index) {
//                     final _property = snapshot.data![index];
//                     return Container(
//                       width: MediaQuery.of(context).size.width * 0.9,
//                       height: MediaQuery.of(context).size.height * 0.4,
//                       margin: const EdgeInsets.only(top: 20),
//                       decoration: BoxDecoration(
//                         color: Theme.of(context).colorScheme.background,
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Stack(children: [
//                             Container(
//                               width: double.infinity,
//                               height: MediaQuery.of(context).size.height * 0.29,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 image: DecorationImage(
//                                   image: NetworkImage(_property.imageUrl[0]),
//                                   fit: BoxFit.fill,
//                                 ),
//                               ),
//                             ),
//                             Positioned(
//                               top: 12,
//                               right: 10,
//                               child: CircleAvatar(
//                                 backgroundColor: Colors.black26,
//                                 radius: 20,
//                                 child: IconButton(
//                                     onPressed: () {},
//                                     icon: const Icon(Icons.favorite_border)),
//                               ),
//                             )
//                           ]),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(left: 8.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Text(
//                                       _property.address,
//                                       style: textStyleNunito(
//                                           20,
//                                           Theme.of(context)
//                                               .colorScheme
//                                               .inversePrimary,
//                                           FontWeight.w900,
//                                           0),
//                                     ),
//                                     const Spacer(),
//                                     const Icon(
//                                       Icons.star_half_outlined,
//                                       color: Colors.black,
//                                     )
//                                   ],
//                                 ),
//                                 Text(
//                                     _property.noOfRooms.split(',').elementAt(0),
//                                     style: textStyleNunito(16,
//                                         Colors.grey[800]!, FontWeight.w700, 0)),
//                                 const SizedBox(
//                                   height: 5,
//                                 ),
//                                 Text('${_property.price} Birr/year',
//                                     style: textStyleNunito(
//                                         16,
//                                         Theme.of(context)
//                                             .colorScheme
//                                             .inversePrimary,
//                                         FontWeight.w900,
//                                         0)),
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                     );

//                     // return Card(
//                     //   elevation: 0,
//                     //   child: Padding(
//                     //     padding: const EdgeInsets.symmetric(
//                     //         vertical: 5, horizontal: 2),
//                     //     child: Row(
//                     //       children: [
//                     //         Padding(
//                     //           padding: const EdgeInsets.all(8.0),
//                     //           child: SizedBox(
//                     //             height: 100,
//                     //             width: 110,
//                     //             child: ClipRRect(
//                     //               borderRadius: BorderRadius.circular(20),
//                     //               child: Image.asset(
//                     //                 houseList[index].houseImage,
//                     //                 fit: BoxFit.cover,
//                     //               ),
//                     //             ),
//                     //           ),
//                     //         ),
//                     //         const Column(
//                     //           crossAxisAlignment: CrossAxisAlignment.start,
//                     //           children: [
//                     //             Text("Orchad house",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
//                     //             Text("Birr 25000/year", style: TextStyle(color: Colors.blue)),
//                     //             Row(
//                     //               children: [
//                     //                 Icon(Icons.king_bed),
//                     //                 Text("6 bedroom"),
//                     //                 SizedBox(width: 20,),
//                     //                 Icon(Icons.bathtub),
//                     //                 Text("4 bathroom")
//                     //               ],
//                     //             )
//                     //           ],
//                     //         )
//                     //       ],
//                     //     ),
//                     //   ),
//                     // );
//                   }),
//             ),
//           ),
//         );
