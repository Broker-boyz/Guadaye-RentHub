// ignore_for_file: must_be_immutable

import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ellipsis_text/flutter_ellipsis_text.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:gojo_renthub/Myproperty/model/my_property_model.dart';
import 'package:gojo_renthub/Myproperty/repo/my_property_repo.dart';
import 'package:gojo_renthub/Profile/user_provider/user_provider.dart';
import 'package:gojo_renthub/mapService/component/map_box.dart';
import 'package:gojo_renthub/mapService/screen/panorama_view.dart';
import 'package:gojo_renthub/views/screens/bottom_navigation_pages/homepage.dart';
import 'package:gojo_renthub/views/screens/home_and%20_details_page/component/select_rating_star.dart';
import 'package:gojo_renthub/views/shared/fonts/nunito.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'dart:developer' as dev show log;
import 'package:provider/provider.dart';

class PropertyDetailPage extends StatefulWidget {
  PropertyDetailPage({super.key, this.myProperty});
  MyProperty? myProperty;
  @override
  State<PropertyDetailPage> createState() => _PropertyDetailPageState();
}

class _PropertyDetailPageState extends State<PropertyDetailPage> {
  late ScrollController _controller;
  late TextEditingController _reviewController;
  double ratingController = 3;
  BitmapDescriptor customMarker = BitmapDescriptor.defaultMarker;

  @override
  void initState() {
    int length = widget.myProperty!.rating.length;

    _controller = ScrollController();
    _reviewController = TextEditingController();
    _getIcon();
    _setFavorite();
    _calculateRating(length);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _getIcon() async {
    await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(
              bundle: DefaultAssetBundle.of(
                context,
              ),
            ),
            'assets/images/home-marker.png')
        .then(
      (icon) {
        customMarker = icon;
        setState(() {});
      },
    );
  }

  bool _isAllAmenties = false;
  bool _isFavorite = false;

  _setFavorite() {
    _isFavorite = widget.myProperty!.isFavorite;
  }

  double rating = 0;

  _calculateRating(length) {
    
    rating = widget.myProperty!.rating.reduce((a, b) => a + b) / length;
    

  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final MyPropertyRepo _repo = MyPropertyRepo();

  @override
  Widget build(BuildContext context) {
    User? user = _repo.getCurrentUser();
   MyProperty? property = widget.myProperty;
    return PopScope(
      canPop: false,
      onPopInvoked: (value) {
        dev.log(value.toString());
        showReview();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.29,
                padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      property!.imageUrl[0],
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.black38,
                      radius: 20,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                            // Get.to(() => const HomePage(),
                            //     transition: Transition.fadeIn,
                            //     duration: const Duration(milliseconds: 500));
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_new_outlined,
                            color: Colors.white,
                            size: 20,
                          )),
                    ),
                    const Spacer(),
                    CircleAvatar(
                      backgroundColor: Colors.black26,
                      radius: 20,
                      child: IconButton(
                        onPressed: () {
                          _isFavorite = !_isFavorite;

                          MyPropertyRepo().updateItem(property.id, _isFavorite);
                          _isFavorite
                              ? MyPropertyRepo()
                                  .addFavorites(property: property)
                              : MyPropertyRepo()
                                  .removeFavorites(property: property);
                          setState(() {});
                        },
                        icon: _isFavorite
                            ? const Icon(Icons.favorite_rounded,
                                color: Colors.pinkAccent)
                            : const Icon(Icons.favorite_border),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.black26,
                      radius: 20,
                      child: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Panorama(
                                          panoImages: property.imageUrl,
                                        )));
                          },
                          icon: const Icon(
                            Icons.view_in_ar_outlined,
                            color: Colors.lightBlueAccent,
                            size: 20,
                          )),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, left: 15, right: 15, bottom: 10),
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
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
                              Text(
                                  property.noOfRooms.split(',').elementAt(0) +
                                      property.noOfRooms
                                          .split(',')
                                          .elementAt(1),
                                  style: textStyleNunito(16, Colors.grey[800]!,
                                      FontWeight.w700, 0)),
                            ],
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              ratingStarSelection(rating),
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
                              Text(
                                ' / 5',
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
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'About This Home',
                              style: textStyleNunito(
                                  20,
                                  Theme.of(context).colorScheme.inversePrimary,
                                  FontWeight.w900,
                                  0),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            EllipsisText(
                              text: property.description,
                              ellipsis: '... Show More',
                              style: textStyleNunito(
                                  16,
                                  Theme.of(context).colorScheme.inversePrimary,
                                  FontWeight.w600,
                                  0),
                              maxLines: 3,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 20, left: 20, bottom: 10),
                        child: Divider(
                          color: Colors.grey[400],
                        ),
                      ),
                      SizedBox(
                        height: 150,
                        child: _builder(property),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'What This Home Offers',
                              style: textStyleNunito(
                                  18,
                                  Theme.of(context).colorScheme.inversePrimary,
                                  FontWeight.w900,
                                  0),
                            ),
                            SizedBox(
                              height: _isAllAmenties
                                  ? property.amenities.length * 42
                                  : MediaQuery.of(context).size.width * .22,
                              child: GridView.builder(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                controller: _controller,
                                padding: const EdgeInsets.only(top: 0),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 2,
                                  crossAxisSpacing: 2,
                                  mainAxisExtent: 40,
                                ),
                                itemCount: property.reviews.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: 40,
                                    width: 60,
                                    padding: const EdgeInsets.only(right: 40),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                              Icons.hotel_class_outlined),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            property.reviews[index],
                                            style: textStyleNunito(
                                                16,
                                                Theme.of(context)
                                                    .colorScheme
                                                    .inversePrimary,
                                                FontWeight.w700,
                                                0),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8))),
                                onPressed: () {
                                  setState(() {
                                    _isAllAmenties = !_isAllAmenties;
                                  });
                                },
                                child: Text(
                                  _isAllAmenties
                                      ? 'Show Less'
                                      : 'Show All Amenties',
                                  style: textStyleNunito(
                                      16,
                                      Theme.of(context)
                                          .colorScheme
                                          .inversePrimary,
                                      FontWeight.w700,
                                      0),
                                ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 20, left: 20, bottom: 10),
                        child: Divider(
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Where It Found',
                              style: textStyleNunito(
                                  18,
                                  Theme.of(context).colorScheme.inversePrimary,
                                  FontWeight.w900,
                                  0),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            MapBox(
                              ccustomMarker: customMarker,
                              latLng:
                                  LatLng(property.latitude, property.longitude),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 20, left: 20, bottom: 10),
                        child: Divider(
                          color: Colors.grey[400],
                        ),
                      ),
                      Text(
                        'Things To Know',
                        style: textStyleNunito(
                            20,
                            Theme.of(context).colorScheme.inversePrimary,
                            FontWeight.w900,
                            0),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'House Rule',
                              style: textStyleNunito(
                                  20,
                                  Theme.of(context).colorScheme.inversePrimary,
                                  FontWeight.w900,
                                  0),
                            ),
                            Text(
                              property.houseRules,
                              style: textStyleNunito(
                                  16,
                                  Theme.of(context).colorScheme.inversePrimary,
                                  FontWeight.w700,
                                  0),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.07,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Text.rich(
                          textAlign: TextAlign.start,
                          TextSpan(children: [
                            TextSpan(
                              text: '${property.price}ETB',
                              style: textStyleNunito(
                                  16,
                                  Theme.of(context).colorScheme.inversePrimary,
                                  FontWeight.w900,
                                  0),
                            ),
                            TextSpan(
                              text: ', Month',
                              style: textStyleNunito(
                                  16,
                                  Theme.of(context).colorScheme.inversePrimary,
                                  FontWeight.w700,
                                  0),
                            )
                          ])),
                      Text.rich(TextSpan(
                          text: 'Availablity:',
                          style: textStyleNunito(
                              16,
                              Theme.of(context).colorScheme.inversePrimary,
                              FontWeight.w700,
                              0),
                          children: [
                            TextSpan(
                              text: property.availability
                                  ? ' Available'
                                  : ' Reserved',
                              style: textStyleNunito(
                                  16,
                                  Theme.of(context).colorScheme.inversePrimary,
                                  FontWeight.w900,
                                  0),
                            )
                          ]))
                    ],
                  ),
                ),
                FutureBuilder(
                future: _repo.getUserRole(user: user!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData) {
                    final accountType = snapshot.data;
                    if (accountType == 'Tenant') {
                      return Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: MaterialButton(
                            minWidth: MediaQuery.of(context).size.width * .3,
                            height: MediaQuery.of(context).size.width * .1,
                            elevation: 0,
                            color: Colors.black,
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            onPressed: () {
                            Provider.of<UserProvider>(context, listen: false)
                                .isEmailVerified(context, property.hostId);
                          },
                            child: const Text('Rent Now',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 18)),
                          ),
                      );
                    }
                  } else {
                    return const Center(
                      child: Text('Error has occurred'),
                    );
                  }
                  return Container();
                },
                )
              ],
            )),
      ),
    );
  }

  ListView _builder(MyProperty property) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemCount: property.imageUrl.length,
      itemExtent: 250,
      itemBuilder: ((context, index) {
        return GestureDetector(
          onTap: (() {
            showDialog(
              context: context,
              barrierColor: Colors.black54,
              builder: (BuildContext context) {
                return BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: AlertDialog(
                    backgroundColor: Colors.transparent,
                    surfaceTintColor: Colors.transparent,
                    insetPadding: EdgeInsets.zero,
                    content: Container(
                      height: MediaQuery.of(context).size.height / 4,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(
                              property.imageUrl[0],
                            ),
                            fit: BoxFit.fill),
                      ),
                    ),
                  ),
                );
              },
            );
          }),
          child: Container(
            height: 90,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      property.imageUrl[0],
                    ),
                    fit: BoxFit.fill)),
          ),
        );
      }),
    );
  }

  void showReview() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: Center(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Please Give rating about home service',
                      style: textStyleNunito(
                          20,
                          Theme.of(context).colorScheme.inversePrimary,
                          FontWeight.w900,
                          0)),
                  const SizedBox(
                    height: 20,
                  ),
                  RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    glowColor: Colors.yellow,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) =>
                        const Icon(Icons.star, color: Colors.amber),
                    onRatingUpdate: (rating) {
                      ratingController = rating;
                      print(rating);
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Please write some reviews',
                          style: textStyleNunito(
                              16,
                              Theme.of(context).colorScheme.inversePrimary,
                              FontWeight.w900,
                              0)),
                      const SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: _reviewController,
                        style: textStyleNunito(
                            16, Colors.grey[400]!, FontWeight.w700, 0),
                        decoration: InputDecoration(
                            prefixIcon: const Icon(LineAwesomeIcons.comment),
                            hintText: 'Mention your thought here (optional)',
                            hintStyle: textStyleNunito(
                                16, Colors.grey[400]!, FontWeight.w700, 0),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[200]!),
                            )),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.inversePrimary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            onPressed: () {
                              MyProperty property = widget.myProperty!.copyWith(
                                  rating: [
                                    ...widget.myProperty!.rating,
                                    ratingController
                                  ],
                                  reviews: [
                                    ...widget.myProperty!.reviews,
                                    _reviewController.text
                                  ]);
                              print(property);
                              MyPropertyRepo()
                                  .updateproperty(property: property);
                              MyPropertyRepo().addReview(
                                  property: property,
                                  review: _reviewController.text,
                                  rating: ratingController);
                              _calculateRating(property.rating.length);
                              Navigator.of(context).pop();
                              setState(() {});
                            },
                            child: Text('Submit',
                                style: textStyleNunito(
                                    16,
                                    Theme.of(context).colorScheme.primary,
                                    FontWeight.w900,
                                    0)),
                          ),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              // Get.to(() => const HomePage(),
                              //     transition: Transition.fadeIn,
                              //     duration: const Duration(milliseconds: 500));
                            },
                            child: Text('Cancel',
                                style: textStyleNunito(
                                    16,
                                    Theme.of(context)
                                        .colorScheme
                                        .inversePrimary,
                                    FontWeight.w900,
                                    0)),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}

