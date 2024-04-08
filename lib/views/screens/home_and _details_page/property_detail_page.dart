import 'package:flutter/material.dart';
import 'package:gojo_renthub/Myproperty/model/my_property_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PropertyDetailPage extends StatefulWidget {
  PropertyDetailPage({super.key, this.myProperty});
  MyProperty? myProperty;
  @override
  State<PropertyDetailPage> createState() => _PropertyDetailPageState();
}

class _PropertyDetailPageState extends State<PropertyDetailPage> {
  late ScrollController controller;

  BitmapDescriptor customMarker = BitmapDescriptor.defaultMarker;

  @override
  void initState() {
    controller = ScrollController();
    _getIcon();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void _getIcon() async {
    await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(
              bundle: DefaultAssetBundle.of(
                context,
              ),
            ),
            'assets/markers/home-marker.png')
        .then(
      (icon) {
        customMarker = icon;
        setState(() {});
      },
    );
  }

  bool _isAllAmenties = false;

  @override
  Widget build(BuildContext context) {
    MyProperty? property = widget.myProperty;
    return Scaffold(
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
                image:  DecorationImage(
                  image: NetworkImage(property!.imageUrl[0]),
                  fit: BoxFit.fill,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.black38,
                    radius: 18,
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_back_ios_new_outlined,
                          color: Colors.white,
                          size: 20,
                        )),
                  ),
                  const Spacer(),
                  CircleAvatar(
                    backgroundColor: Colors.black26,
                    radius: 18,
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                          size: 20,
                        )),
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
                                        panoImages: panoImagesPaths,
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
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          children: [
                            Text(
                              'Addis Ababa, Bole',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800),
                            ),
                            Text(
                              '2 beds hot bathroom',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        TextButton.icon(
                          onPressed: () {
                            print('show review');
                          },
                          label: const Text(
                            'reviews',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                decorationThickness: 2,
                                decoration: TextDecoration.underline),
                          ),
                          icon: const Icon(Icons.star_half_outlined,
                              color: Colors.amber),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'About This Home',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          EllipsisText(
                            text:
                                'A modern, minimalist loft apartment in the heart of the city, boasting panoramic views of the bustling cityscape. Exposed brick walls and sleek concrete floors create an industrial vibe, softened by plush throws and warm lighting. A private balcony offers a tranquil escape from the urban energy.',
                            ellipsis: '...Show More',
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.grey[500]),
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
                      child: _builder(),
                    ),
                    const SizedBox(
                      height: 10,
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
                          const Text(
                            'What This Home Offers',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: _isAllAmenties
                                ? 10 * 42
                                : MediaQuery.of(context).size.width * .32,
                            child: GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              controller: controller,
                              padding: const EdgeInsets.only(top: 0),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 2,
                                crossAxisSpacing: 2,
                                mainAxisExtent: 40,
                              ),
                              itemCount: 20,
                              itemBuilder: (context, index) {
                                return Container(
                                  height: 40,
                                  width: 60,
                                  padding: const EdgeInsets.only(right: 40),
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  child: const Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.hot_tub),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text("Hot Bath")
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
                                      borderRadius: BorderRadius.circular(8))),
                              onPressed: () {
                                setState(() {
                                  _isAllAmenties = !_isAllAmenties;
                                });
                              },
                              child: Text(
                                  _isAllAmenties
                                      ? 'Show Less'
                                      : 'Show All Amenties',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)))
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
                          const Text(
                            'Where It Found',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          MapBox(customMarker: customMarker)
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
                    const Text(
                      'Things To Know',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'House Rule',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .15,
                            child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                controller: controller,
                                padding: const EdgeInsets.only(top: 0),
                                shrinkWrap: true,
                                itemCount: 4,
                                itemBuilder: (context, index) {
                                  return Text('2 Guest Maximum',
                                      style:
                                          TextStyle(color: Colors.grey[500]));
                                }),
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
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Text.rich(
                        textAlign: TextAlign.start,
                        TextSpan(children: [
                          TextSpan(
                              text: '1200ETB',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700)),
                          TextSpan(
                              text: ', Month',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400))
                        ])),
                    Text.rich(TextSpan(
                        text: 'Availablity:',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w700),
                        children: [
                          TextSpan(
                              text: 'Available',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700))
                        ]))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.width * .3,
                  height: MediaQuery.of(context).size.width * .1,
                  elevation: 0,
                  color: Colors.black,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: () {},
                  child: const Text('Rent Now',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 18)),
                ),
              )
            ],
          )),
    );
  }

  ListView _builder() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemCount: panoImagesPaths.length,
      itemExtent: 300,
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
                      height: MediaQuery.of(context).size.height / 3,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                            image: AssetImage(panoImagesPaths[index]),
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
                    image: AssetImage(panoImagesPaths[index]),
                    fit: BoxFit.fill)),
          ),
        );
      }),
    );
  }
}
