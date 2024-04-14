import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gojo_renthub/Myproperty/model/my_property_model.dart';

ListView carouselBuilder(MyProperty property) {
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
