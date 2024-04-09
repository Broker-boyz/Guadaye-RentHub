import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gojo_renthub/Myproperty/model/my_property_model.dart';
import 'package:gojo_renthub/views/shared/fonts/nunito.dart';
import 'package:shimmer/shimmer.dart';

class SearchScreenShimmerEffect extends StatefulWidget {
  const SearchScreenShimmerEffect({super.key,});

  @override
  State<SearchScreenShimmerEffect> createState() =>
      _SearchScreenShimmerEffectState();
}

class _SearchScreenShimmerEffectState extends State<SearchScreenShimmerEffect> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
          child: Container(
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
                }),
          ),
        );
      
  }
}