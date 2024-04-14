// ignore_for_file: avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gojo_renthub/Myproperty/model/my_property_model.dart';
import 'package:gojo_renthub/Myproperty/repo/my_property_repo.dart';
import 'package:gojo_renthub/views/screens/home_and%20_details_page/property_detail_page.dart';
import 'package:gojo_renthub/views/shared/fonts/nunito.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(
            'Favorite Products',
            style: textStyleNunito(
                20,
                Theme.of(context).colorScheme.inversePrimary,
                FontWeight.w900,
                0),
          ),
        ),
        body: FutureBuilder<List<MyProperty>>(
            future: MyPropertyRepo().loadingFavorites(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: LoadingAnimationWidget.dotsTriangle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      size: 50),
                );
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
                if (snapshot.data!.isEmpty) {
                  return Center(
                    child: Text("No Favorite itemes, please add some",
                        style: textStyleNunito(
                            16, Colors.grey[700]!, FontWeight.w900, 0)),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    MyProperty myFavorites = snapshot.data![index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 10),
                      child: Dismissible(
                        dragStartBehavior: DragStartBehavior.down,
                        key: ValueKey<String>(myFavorites.id),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          MyPropertyRepo().updateItem(myFavorites.id, false);
                          MyPropertyRepo()
                              .removeFavorites(property: myFavorites);
                        },
                        background: Container(
                          padding: const EdgeInsets.only(right: 20),
                          color: Colors.red,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.delete_forever,
                                color: Colors.white,
                                size: 40,
                              ),
                              SizedBox(
                                width: 10,
                              )
                            ],
                          ),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => PropertyDetailPage(
                                  myProperty: myFavorites,
                                ));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.height * 0.18,
                            padding: EdgeInsets.zero,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.background,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    offset: const Offset(5, 5),
                                    blurRadius: 10.0,
                                    spreadRadius: 0.0,
                                  )
                                ]),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height: MediaQuery.of(context).size.height,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                        myFavorites.imageUrl[0],
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 10),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          TextButton.icon(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.location_on,
                                                color: Colors.grey[800]!,
                                              ),
                                              label: Text(
                                                myFavorites.address
                                                    .split(',')
                                                    .elementAt(0),
                                                style: textStyleNunito(
                                                        20,
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .inversePrimary,
                                                        FontWeight.w900,
                                                        0)
                                                    .copyWith(
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                              )),
                                          Text(
                                              " ${myFavorites.noOfRooms.split(',').elementAt(0)}\n ${myFavorites.noOfRooms.split(', ').elementAt(1)}\n ${myFavorites.noOfRooms.split(', ').elementAt(2)}",
                                              style: textStyleNunito(
                                                  16,
                                                  Colors.grey[800]!,
                                                  FontWeight.w700,
                                                  0)),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                      Text('${myFavorites.price} ETB, Month',
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
                          ),
                        ),
                      ),
                    );
                  },
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
            }));
  }
}
