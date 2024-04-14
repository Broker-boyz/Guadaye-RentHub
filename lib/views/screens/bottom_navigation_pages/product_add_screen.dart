// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gojo_renthub/Myproperty/bloc/property_bloc.dart';
import 'package:gojo_renthub/Myproperty/model/my_property_model.dart';
import 'package:gojo_renthub/views/screens/auth/authpage.dart';
import 'package:gojo_renthub/views/shared/fonts/nunito.dart';

import 'package:gojo_renthub/views/shared/fonts/orbitron.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

class ProductAddScreen extends StatefulWidget {
  User user;
  String name;
  String description;
  String houseType;
  String rooms;
  List<String> amenities;
  String houseRules;
  String address;
  int price;
  String availableDates;
  List<File> images;
  PickedData pickedData;
  ProductAddScreen({
    Key? key,
    required this.user,
    required this.name,
    required this.description,
    required this.houseType,
    required this.rooms,
    required this.amenities,
    required this.houseRules,
    required this.address,
    required this.price,
    required this.availableDates,
    required this.images,
    required this.pickedData,
  }) : super(key: key);

  @override
  State<ProductAddScreen> createState() => _ProductAddScreenState();
}

class _ProductAddScreenState extends State<ProductAddScreen> {
  void _addProperty() {
    final property = AddPropertyEvent(
      property: MyProperty(
        status: 'waiting',
        reviews: const [],
        rating: const [3.4],
        availability: true,
        imageUrl: const [],
        id: '',
        title: widget.name,
        description: widget.description,
        noOfRooms: widget.rooms,
        price: widget.price,
        hostId: widget.user.uid,
        category: widget.houseType,
        address: widget.address,
        availableDates: widget.availableDates,
        amenities: widget.amenities,
        latitude: widget.pickedData.latLong.latitude,
        longitude: widget.pickedData.latLong.longitude,
        houseRules: widget.houseRules,
        city: widget.address.split(',').elementAt(0),
        subCity: widget.address.split(', ').elementAt(1),
        isFavorite: false,
      ),
      userId: widget.user.uid,
      images: widget.images,
    );
    context.read<PropertyBloc>().add(property);
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => CommissionConfirmationScreen(
    //           propertyValue: property.property.price),
    //     ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Successful',
            style: textStyleNunito(
                20,
                Theme.of(context).colorScheme.inversePrimary,
                FontWeight.w900,
                0)),
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<PropertyBloc, PropertyState>(
          listener: (context, state) {
            if (state is PropertyLoaded) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Property Added Successfully'),
                ),
              );
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const AuthPage(),
                ),
                (route) => false,
              );
            }
          },
          builder: (context, state) {
            if (state is PropertyLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      color: Colors.grey[200],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          propertyConfirmation(
                              context, 'Owner: ', widget.user.email.toString()),
                          propertyConfirmation(
                              context, 'Property Address: ', widget.address),
                          propertyConfirmation(
                              context, 'Rooms: ', widget.rooms),
                          propertyConfirmation(
                              context, 'House Type: ', widget.houseType),
                          propertyConfirmation(context, 'Amenities: ',
                              widget.amenities[0].toString()),
                          propertyConfirmation(
                              context, 'Price: ', '${widget.price} ETB'),
                        ],
                      )),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      LineAwesomeIcons.info_circle,
                      size: 20,
                      color: Colors.lightBlue,
                    ),
                    label: Text(
                        'To list your property, a commission fee of 4% will be charged upon successful listing of your property.',
                        style: textStyleNunito(
                            16,
                            Theme.of(context).colorScheme.inversePrimary,
                            FontWeight.w400,
                            0)),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      Text(
                        'You have successfully paid your Estimated Commission:',
                        style: textStyleNunito(
                            18,
                            Theme.of(context).colorScheme.inversePrimary,
                            FontWeight.w900,
                            0),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'ETB ${widget.price * 0.04}',
                        style: textStyleNunito(
                            18,
                            Theme.of(context).colorScheme.inversePrimary,
                            FontWeight.w900,
                            0),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    'Now you can proceed to list your property. By clicking on the Proceed button.',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(height: 40.0),
                  GestureDetector(
                    onTap: () {
                      _addProperty();
                    },
                    child: Container(
                      width: 250,
                      padding: const EdgeInsets.all(15),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueAccent,
                          )
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Proceed',
                          style: textStyleOrbitron(
                              14,
                              Theme.of(context).colorScheme.primary,
                              FontWeight.bold,
                              1),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Row propertyConfirmation(
      BuildContext context, String title, String description) {
    return Row(
      children: [
        Text(title,
            overflow: TextOverflow.ellipsis,
            style: textStyleNunito(
                18,
                Theme.of(context).colorScheme.inversePrimary,
                FontWeight.w700,
                0)),
        const SizedBox(
          width: 10,
        ),
        Text(description,
            style: textStyleNunito(
                17,
                Theme.of(context).colorScheme.inversePrimary,
                FontWeight.w400,
                0)),
      ],
    );
  }
}
