import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gojo_renthub/Myproperty/model/my_property_model.dart';
import 'package:gojo_renthub/Myproperty/repo/my_property_repo.dart';
import 'package:gojo_renthub/views/screens/home_and%20_details_page/property_detail_page.dart';
import 'package:gojo_renthub/views/screens/review/user_review_card.dart';
import 'package:gojo_renthub/views/shared/fonts/nunito.dart';
import 'package:modern_form_line_awesome_icons/modern_form_line_awesome_icons.dart';

class ReviewsPage extends StatefulWidget {
  const ReviewsPage({super.key, required this.property});
  final MyProperty property;

  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  late TextEditingController _reviewController;

  @override
  void initState() {
    _reviewController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Reviews',
          style: textStyleNunito(20,
              Theme.of(context).colorScheme.inversePrimary, FontWeight.w900, 0),
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 10),
        child: reviewCardBuilder(widget.property, Axis.vertical),
      ),
      bottomNavigationBar: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.07,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.3,
                child: TextField(
                  controller: _reviewController,
                  style: textStyleNunito(
                      16,
                      Theme.of(context).colorScheme.inversePrimary,
                      FontWeight.w700,
                      0),
                  decoration: InputDecoration(
                      prefixIcon: const Icon(LineAwesomeIcons.comment),
                      hintText: 'Mention your thought here (optional)',
                      hintStyle: textStyleNunito(
                          14, Colors.grey[400]!, FontWeight.w700, 0),
                      fillColor: Theme.of(context).colorScheme.primaryContainer,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[200]!),
                      )),
                ),
              ),
              IconButton(
                onPressed: () {
                  MyProperty updatedProperty = widget.property.copyWith(
                      rating: [
                        ...widget.property.rating,
                        3.0
                      ],
                      reviews: [
                        ...widget.property.reviews,
                        _reviewController.text
                      ]);

                  MyPropertyRepo().updateproperty(property: updatedProperty);
                  MyPropertyRepo().addReview(
                      property: updatedProperty,
                      review: _reviewController.text,
                      rating: 3.0);
   
                  setState(() {});
                },
                icon: const Icon(Icons.send),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
