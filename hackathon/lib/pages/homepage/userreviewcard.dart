import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackathon/pages/homepage/ratebarindicator.dart';
import 'package:readmore/readmore.dart';
import 'package:hackathon/pages/homepage/review_data_model.dart';

class UserReviewCard extends StatefulWidget {
   bool isReplyVisible;

  UserReviewCard({
    Key? key,
    required this.isReplyVisible,
  }) : super(key: key);

  @override
  State<UserReviewCard> createState() => _UserReviewCardState();
}

class _UserReviewCardState extends State<UserReviewCard> {
  TextEditingController replyController =TextEditingController();
  late List<Review> reviews = [];

  @override
  void initState() {
    super.initState();
    fetchReviews().then((fetchedReviews) {
      setState(() {
        reviews = fetchedReviews;
      });
    });
  }

  Future<List<Review>> fetchReviews() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('reviews').get();

    List<Review> reviews = [];

    querySnapshot.docs.forEach((doc) {
      var data = doc.data() as Map<String, dynamic>?;

      if (data != null) {
        Review review = Review(
          description: data['description'],
          rate: Rate(value: data['rate']['value']),
          reviewer: Reviewer(
            profile: data['reviewer']['profile'],
            name: data['reviewer']['name'],
          ),
          replies: (data['replies'] as List<dynamic>).map((replyData) {
            return Reply.fromJson(replyData);
          }).toList(),
          date: DateTime.parse(data['date']), id: 'id',
        );

        reviews.add(review);
      }
    });

    return reviews;
  }

  Future<void> addReply(String reviewId, Reply reply) async {
    await FirebaseFirestore.instance
        .collection('reviews')
        .doc(reviewId)
        .update({
      'replies': FieldValue.arrayUnion([
        reply.toJson(),
      ])
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        Review review = reviews[index];
        Reply reply = review.replies.isNotEmpty
            ? review.replies[0]
            : Reply(
                content: '',
                replier: Reviewer(profile: '', name: ''),
                date: DateTime.now());
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(
                        '${review.reviewer.profile}',
                      ),
                      radius: 30,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      '${review.reviewer.name}',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.more_vert))
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                RateBarIndicator(
                  initialRate: 4,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  '${review.date}',
                  style: TextStyle(),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Column(
              children: [
                ReadMoreText(
                  '${review.description}',
                  trimLines: 2,
                  trimMode: TrimMode.Line,
                  trimExpandedText: 'show less',
                  trimCollapsedText: 'show more',
                  moreStyle: const TextStyle(fontWeight: FontWeight.bold),
                  lessStyle: const TextStyle(fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.isReplyVisible = !widget.isReplyVisible;
                    });
                  },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      widget.isReplyVisible ? 'cancel reply' : 'reply',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                if (widget.isReplyVisible)
                  Column(
                    children: [
                      TextField(
                        controller: replyController,
                        decoration: InputDecoration(
                          hintText: 'Reply to this review',
                          //border: OutlineInputBorder(),
                        ),
                        
                        onSubmitted: (replyContent) async {
                          Reply newReply = Reply(
                            content: replyContent,
                            replier: Reviewer(
                                profile: 'url_to_profile_image',
                                name: 'Your Name'),
                            date: DateTime.now(),
                          );
                          await addReply(review.id, newReply);
                          setState(() {
                            widget.isReplyVisible = false;
                          });
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              Reply newReply = Reply(
                                content: replyController.text,
                                replier: Reviewer(
                                    profile: 'url_to_profile_image',  //users profile and name capture from registration how ? Idon't know
                                    name: 'Your Name'
                                    ),
                                date: DateTime.now(),
                              );
                              await addReply(review.id, newReply);
                              setState(() {
                                widget.isReplyVisible = false;
                              });
                            },
                            child: Text('Reply'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                widget.isReplyVisible = false;
                              });
                            },
                            child: Text('Cancel'),
                          ),
                        ],
                      ),
                    ],
                  ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 177, 175, 175),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.all(6),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(
                            ' ${reply.replier.profile}',
                          ),
                          radius: 30,
                        ),
                        Text(
                          '${reply.replier.name}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${reply.date}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ReadMoreText(
                      '${reply.content}',
                      trimLines: 1,
                      trimMode: TrimMode.Line,
                      trimExpandedText: 'show less',
                      trimCollapsedText: 'show more',
                      moreStyle:
                          const TextStyle(fontWeight: FontWeight.bold),
                      lessStyle:
                          const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}