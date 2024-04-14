import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gojo_renthub/Myproperty/model/my_property_model.dart';
import 'package:gojo_renthub/Myproperty/model/review_model.dart';
import 'package:gojo_renthub/Myproperty/repo/my_property_repo.dart';
import 'package:gojo_renthub/views/shared/fonts/nunito.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

FutureBuilder<List<Review>> reviewCardBuilder(
    MyProperty property, Axis scrollDirection) {
  return FutureBuilder(
      future: MyPropertyRepo().loadingReviews(property),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: LoadingAnimationWidget.dotsTriangle(
                color: Theme.of(context).colorScheme.inversePrimary, size: 50),
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
              child: Text("No Review is Found",
                  style: textStyleNunito(
                      16, Colors.grey[700]!, FontWeight.w900, 0)),
            );
          }
          snapshot.data!.reversed;
          return ListView.builder(
            scrollDirection: scrollDirection,
            physics: const BouncingScrollPhysics(),
            itemCount: snapshot.data!.length,
            itemBuilder: ((context, index) {
              final review = snapshot.data![index];
              Map<String, dynamic> reviewer = {};
              MyPropertyRepo()
                  .findOneUser(review.userId)
                  .then((value) => reviewer = value);
              bool hasUrl =
                  reviewer['image-path'].toString() == '' ? false : true;
              print('####################################3');
              print(reviewer['image-path'].toString());
              return GestureDetector(
                child: Container(
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.width * 0.9,
                    margin: const EdgeInsets.only(right: 8, top: 8),
                    padding: const EdgeInsets.only(
                        top: 8, bottom: 8, left: 10, right: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).colorScheme.primaryContainer),
                    child: Column(children: [
                      Row(
                        children: [
                          Row(
                            children: [
                              hasUrl
                                  ? CircleAvatar(
                                      radius: 20,
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                              reviewer['image-path']
                                                  .toString()))
                                  : const CircleAvatar(
                                      radius: 20,
                                      backgroundImage: AssetImage(
                                          'assets/images/avatar.png'),
                                    ),
                              const SizedBox(
                                width: 8,
                              ),
                              Column(
                                children: [
                                  Text(
                                    reviewer['full-name'] ?? 'Anonymous',
                                    style: textStyleNunito(
                                        16,
                                        Theme.of(context)
                                            .colorScheme
                                            .inversePrimary,
                                        FontWeight.w700,
                                        0),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    timeago.format(review.date),
                                    style: textStyleNunito(
                                        16, Colors.grey, FontWeight.w700, 0),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                          RatingBar.builder(
                              maxRating: 5,
                              ignoreGestures: true,
                              initialRating: review.rating,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 25,
                              itemBuilder: (context, _) =>
                                  const Icon(Icons.star, color: Colors.amber),
                              onRatingUpdate: (rating) {}),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            review.rating.toString(),
                            style: textStyleNunito(
                                18,
                                Theme.of(context).colorScheme.inversePrimary,
                                FontWeight.w700,
                                0),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Text(
                        review.review,
                        style: textStyleNunito(
                            16,
                            Theme.of(context).colorScheme.inversePrimary,
                            FontWeight.w700,
                            0),
                      ),
                    ])),
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
      }));
}
