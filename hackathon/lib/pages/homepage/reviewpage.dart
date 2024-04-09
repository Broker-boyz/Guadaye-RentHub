import 'package:flutter/material.dart';
import 'package:hackathon/pages/homepage/overallrate.dart';
import 'package:hackathon/pages/homepage/ratebarindicator.dart';
import 'package:hackathon/pages/homepage/splashscreen.dart';
import 'package:hackathon/pages/homepage/userreviewcard.dart';
import 'package:hackathon/pages/homepage/addreview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Reviews extends StatefulWidget {
  const Reviews({super.key});

  @override
  State<Reviews> createState() => _ReviewsState();
}



class _ReviewsState extends State<Reviews> {
  int totalReviewers = 0;
   double averageRate = 0.0;
  @override
  void initState() {
    super.initState();
    fetchTotalReviewers();
     fetchAverageRate();
  }

  
  Future<void> fetchTotalReviewers() async {
    Set<String> reviewerNames = Set<String>();

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('reviews').get();

    querySnapshot.docs.forEach((doc) {
      var data = doc.data() as Map<String,
          dynamic>?; 

      if (data != null) {
        reviewerNames.add(data['reviewer']['name']);

        List<dynamic>? replies = data['replies'];
        if (replies != null) {
          for (var reply in replies) {
            var replier = reply['replier'] as Map<String,
                dynamic>?; 
            if (replier != null) {
              reviewerNames.add(replier['name']);
            }
          }
        }
      }
    });

    setState(() {
      totalReviewers = reviewerNames.length;
    });
  }

  Future<void> fetchAverageRate() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('reviews').get();

    double totalRate = 0;
    int numberOfReviews = querySnapshot.docs.length;

    if (numberOfReviews > 0) {
      querySnapshot.docs.forEach((doc) {
        var data = doc.data() as Map<String, dynamic>?;

        if (data != null) {
          totalRate += (data['rate'] as Map<String, dynamic>?)?['value'] ?? 0;
        }
      });

      setState(() {
        averageRate = totalRate / numberOfReviews;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SplashScreen(),
              ));
            },
            child: Icon(Icons.arrow_back)),
        title: Text(
          'Review',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 250,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 248, 245, 245),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ratings and reviews are verified and are from people who use the same type of device that you use.',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    OverallRating(),
                    RateBarIndicator(
                      initialRate:averageRate,
                    ),
                    Text(
                      '$totalReviewers Reviewers',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddReview(
                        initialRate: 0,
                      ),
                    ));
                  },
                  child: Text(
                    'Add your Review',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              UserReviewCard(
                isReplyVisible: false,
                
              ),
              const SizedBox(
                height: 16,
              ),
              // UserReviewCard(isReplyVisible: false,),
              // const SizedBox(
              //   height: 16,
              // ),
              // UserReviewCard(isReplyVisible: false,),
              // const SizedBox(
              //   height: 16,
              // ),
              // UserReviewCard(isReplyVisible: false,),
              // const SizedBox(
              //   height: 16,
              // ),
              // UserReviewCard(isReplyVisible: false,),
            ],
          ),
        ),
      ),
    );
  }
}
