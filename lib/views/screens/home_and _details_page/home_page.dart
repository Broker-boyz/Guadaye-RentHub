import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gojo_renthub/views/screens/home_and _details_page/details.dart';
import 'package:gojo_renthub/views/shared/components/models/House.dart';
import 'package:gojo_renthub/views/shared/components/widgets/RentHouseType.dart';
import 'package:gojo_renthub/views/shared/components/widgets/Search.dart';
import 'package:gojo_renthub/views/shared/components/widgets/listOfHouse.dart';
import 'package:gojo_renthub/views/shared/fonts/nunito.dart';
import 'package:gojo_renthub/views/shared/fonts/prata.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<House> houseList = [
    House(
        name: "Addis Ababa",
        houseImage: "assets/images/house.jpg",
        price: 800,
        bedroom: 12,
        bathroom: 12,
        long: 12.0,
        lat: 12.0,
        details: "2 beds 2 baths 1,200 sqft",
        type: HouseType.Apartment,
        locationName: "Piyassa"),
    House(
        name: "Addis Ababa",
        houseImage: "assets/images/house.jpg",
        price: 1200,
        bedroom: 12,
        bathroom: 12,
        long: 12.0,
        lat: 12.0,
        details: "3 beds 2 baths 1,200 sqft",
        type: HouseType.Condo,
        locationName: "Piyasa"),
    House(
        name: "Addis Ababa",
        houseImage: "assets/images/house.jpg",
        price: 1000,
        bedroom: 12,
        bathroom: 12,
        long: 12.0,
        lat: 12.0,
        details: "4 beds 1 baths 1,200 sqft",
        type: HouseType.Hotel,
        locationName: "Asko"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage('assets/images/avatar.png'),
        ),
        actions: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.black26,
            child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.notifications,
                    color: Theme.of(context).colorScheme.inversePrimary)),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const FirstSearchBar(),
            RentType(houseType: houseList),
            // const Row(
            //   children: [
            //     Text('Near from you',
            //         style:
            //             TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            //     Spacer(),
            //     Text('See more')
            //   ],
            // ),
            // ListOfHouses(houselist: houseList),
            Expanded(
              child: Container(
                child: ListView.builder(
                    itemCount: houseList.length,
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
                              Container(
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height * 0.29,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image:
                                        AssetImage(houseList[index].houseImage),
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
                                        '${houseList[index].name}, ${houseList[index].locationName}',
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
                                  Text(houseList[index].details,
                                      style: textStyleNunito(
                                          16,
                                          Colors.grey[800]!,
                                          FontWeight.w700,
                                          0)),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text('${houseList[index].price} Birr/year',
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
            )
          ],
        ),
      ),
    );
  }
}
