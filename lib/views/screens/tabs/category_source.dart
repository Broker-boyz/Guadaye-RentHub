import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:gojo_renthub/Myproperty/model/my_property_model.dart';
import 'package:gojo_renthub/Myproperty/repo/my_property_repo.dart';
import 'package:gojo_renthub/views/screens/home_and%20_details_page/property_detail_page.dart';
import 'package:gojo_renthub/views/screens/home_and%20_details_page/component/select_rating_star.dart';
import 'package:gojo_renthub/views/screens/home_and%20_details_page/component/select_rating_star.dart';
import 'package:gojo_renthub/views/screens/shimmer_efffects/home_screen_shimmer_effect.dart';
import 'package:gojo_renthub/views/screens/tabs/bloc/favorite_bloc.dart';
import 'package:gojo_renthub/views/screens/tabs/bloc/favorite_bloc.dart';
import 'package:gojo_renthub/views/shared/fonts/nunito.dart';
import 'dart:developer' as dev show log;

class CategorySource extends StatefulWidget {
  const CategorySource({super.key, required this.categoryString});
  final String categoryString;

  @override
  State<CategorySource> createState() => _CategorySourceState();
}

class _CategorySourceState extends State<CategorySource> {
  User user = FirebaseAuth.instance.currentUser!;
  final MyPropertyRepo _repo = MyPropertyRepo();
  late Future<List<MyProperty>> myProperty;
  double rating = 0;

  @override
  void initState() {
    myProperty = _repo.loadMyProperties(widget.categoryString);

    super.initState();
  }

  _calculateRating(MyProperty property, int length) {
    rating = property.rating.reduce((a, b) => a + b) / length;
  }

  List<bool> isFavorites = [];
  createFav(int j) {
    for (int i = 0; i < j; i++) {
      isFavorites.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MyProperty>>(
      future: _repo.loadMyProperties(widget.categoryString),
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
          snapshot.data!.shuffle();

          createFav(snapshot.data!.length + 1);
          return SizedBox(
            child: ListView.builder(
                itemCount: snapshot.data!.length + 1,
                cacheExtent: snapshot.data!.length.toDouble(),
                itemBuilder: (context, index) {
                  final property = index < snapshot.data!.length
                      ? snapshot.data![index]
                      : null;
                  isFavorites[index] = property?.isFavorite ?? false;
                  dev.log(isFavorites[index].toString());
                  return index < snapshot.data!.length
                      ? BlocBuilder<FavoriteBloc, FavoriteState>(
                          builder: (context, state) {
                            _calculateRating(property!, property.rating.length);
                            return Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: MediaQuery.of(context).size.height * 0.4,
                              margin: const EdgeInsets.only(top: 20),
                              decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      offset: const Offset(2, 2),
                                      blurRadius: 5.0,
                                      spreadRadius: 0.0,
                                    )
                                  ]),
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
                                            MediaQuery.of(context).size.height *
                                                0.29,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                              property.imageUrl[0],
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
                                          onPressed: () async {
                                            isFavorites[index] =
                                                !isFavorites[index];
                                            context.read<FavoriteBloc>().add(
                                                FavoriteUpdate(
                                                    isFavorite:
                                                        isFavorites[index]));

                                            _repo.updateItem(property.id,
                                                isFavorites[index]);

                                            if (isFavorites[index]) {
                                              MyPropertyRepo().addFavorites(
                                                  property: property);
                                            } else {
                                              MyPropertyRepo().removeFavorites(
                                                  property: property);
                                            }
                                          },
                                          icon: isFavorites[index]
                                              ? const Icon(
                                                  Icons.favorite_rounded,
                                                  color: Colors.pinkAccent)
                                              : const Icon(
                                                  Icons.favorite_border),
                                        ),
                                      ),
                                    )
                                  ]),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0, right: 10),
                                              child: Row(
                                                children: [
                                                  ratingStarSelection(rating),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    rating.toStringAsFixed(1),
                                                    style: textStyleNunito(
                                                        20,
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .inversePrimary,
                                                        FontWeight.w900,
                                                        0),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        Text(
                                            '${property.noOfRooms.split(',').elementAt(0)}  ${property.noOfRooms.split(', ').elementAt(1)} ${property.noOfRooms.split(', ').elementAt(2)}',
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
                            );
                          },
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
}
