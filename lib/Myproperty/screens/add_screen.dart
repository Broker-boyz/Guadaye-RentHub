import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gojo_renthub/Myproperty/bloc/property_bloc.dart';
import 'package:gojo_renthub/Myproperty/model/my_property_model.dart';
import 'package:gojo_renthub/Myproperty/repo/my_property_repo.dart';
import 'package:gojo_renthub/Myproperty/screens/select_location_screen.dart';
import 'package:gojo_renthub/Myproperty/services/location_service.dart';
import 'package:gojo_renthub/views/screens/bottom_navigation_pages/confirmation_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final MyPropertyRepo _repo = MyPropertyRepo();

  final _formKey = GlobalKey<FormBuilderState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _houseRulesController = TextEditingController();
  final TextEditingController _availableDatesController =
      TextEditingController();
  String houseType = '';

  final TextEditingController _priceController = TextEditingController();

  final _typeOptions = ['Apartment', 'Villa', 'House', 'Hotel', 'Condominium'];
  bool _typeHasError = false;

  PickedData pickedData = PickedData(const LatLong(0, 0), '', {
    'county': 'Akaki Kaliti',
    'state_district':'Addis ababa / Addis Ababa' ,
  });
  final ImagePicker _picker = ImagePicker();
  final List<File> _images = [];
  bool? booleanValueOne = false;
  bool? booleanValueTwo = false;
  bool? booleanValueThree = false;
  bool? booleanValueFour = false;
  bool? booleanValueFive = false;
  bool? booleanValueSix = false;

  int integerValueOne = 0;
  int integerValueTwo = 0;
  int integerValueThree = 0;
  int integerValueFour = 0;

  String _noOfRooms = '';
  final List<String> _amenitiesController = [];

  bool imagesBoolean = false;
  bool locationBoolean = false;
  bool locationBooleanVisible = false;

  Future<void> _pickImage() async {
    var image = await _picker.pickMultiImage();
    for (var imageList in image) {
      final doKnow = File(imageList.path);
      _images.add(doKnow);
    }
    setState(() {});
  }

  void _onChanged(dynamic val) => debugPrint(val.toString());

  void __addToAmenities(
      bool? booleanValueOne,
      bool? booleanValueTwo,
      bool? booleanValueThree,
      bool? booleanValueFour,
      bool? booleanValueFive,
      bool? booleanValueSix) {
    Map<String, bool?> amenitiesMap = {
      'Wi-Fi': booleanValueOne,
      'Outdoor space': booleanValueTwo,
      'Window covering': booleanValueThree,
      'jacuzzi': booleanValueFour,
      'Wood floors': booleanValueFive,
      'off street parking': booleanValueSix,
    };
    amenitiesMap.forEach((amenity, booleanValue) {
      if (booleanValue != null && booleanValue) {
        _amenitiesController.add(amenity);
      }
    });
  }

  void _addProperty(User user, String numberRooms, List<String> amenities,
      String houseType, double latitude, double longitude, String address) {
    final name = _nameController.text;
    final description = _descriptionController.text;
    final price = int.parse(_priceController.text);
    final houseRules = _houseRulesController.text;
    final availableDates = _availableDatesController.text;

    final property = AddPropertyEvent(
      property: MyProperty(
        status: 'waiting',
        reviews: const [],
        rating: const [3.5],
        availability: true,
        imageUrl: const [],
        id: '',
        title: name,
        description: description,
        noOfRooms: numberRooms,
        price: price,
        hostId: user.uid,
        category: houseType,
        isFavorite: false,
        address: address,
        availableDates: availableDates,
        amenities: amenities,
        latitude: latitude,
        longitude: longitude,
        houseRules: houseRules,
        city: address.split(',').elementAt(0),
        subCity: address.split(', ').elementAt(1),
      ),
      userId: user.uid,
      images: _images,
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
  void initState() {
    super.initState();
    LocationService().getPosition();
    _noOfRooms =
        '$integerValueOne living rooms, $integerValueTwo bed rooms, $integerValueThree shower rooms, $integerValueFour kitchen rooms';
  }

  @override
  Widget build(BuildContext context) {
    User? user = _repo.getCurrentUser();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: FormBuilder(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Add Your Home',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          myFirstColumn(
                              context,
                              'The Name of your home',
                              'Property name',
                              'Please enter your house name',
                              _nameController),
                          myFirstColumn(
                              context,
                              'describe your house',
                              'property description',
                              'Please enter your house description',
                              _descriptionController),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text('Home Type'),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .90,
                            child: FormBuilderDropdown<String>(
                              name: 'property type',
                              isExpanded: true,
                              validator: (value) => value == null
                                  ? 'Please select your house type'
                                  : null,
                              valueTransformer: (value) => value.toString(),
                              decoration: const InputDecoration(
                                hintText: 'Choose the type of your home',
                              ),
                              items: _typeOptions
                                  .map((hType) => DropdownMenuItem(
                                      value: hType, child: Text(hType)))
                                  .toList(),
                              onChanged: (val) {
                                setState(() {
                                  _typeHasError = !(_formKey
                                      .currentState!.fields['property type']!
                                      .validate());
                                  houseType = val!;
                                  print(houseType);
                                });
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                noOfRooms(
                                  'Living Rooms',
                                  integerValueOne,
                                  () {
                                    setState(() {
                                      integerValueOne--;
                                      print(integerValueOne);
                                    });
                                  },
                                  () {
                                    setState(() {
                                      integerValueOne++;
                                      print(integerValueOne);
                                    });
                                  },
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                noOfRooms(
                                  'Bed Rooms',
                                  integerValueTwo,
                                  () {
                                    setState(() {
                                      integerValueTwo--;
                                      print(integerValueTwo);
                                    });
                                  },
                                  () {
                                    setState(() {
                                      integerValueTwo++;
                                      print(integerValueTwo);
                                    });
                                  },
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                noOfRooms(
                                  'Shower Rooms',
                                  integerValueThree,
                                  () {
                                    setState(() {
                                      integerValueThree--;
                                      print(integerValueThree);
                                    });
                                  },
                                  () {
                                    setState(() {
                                      integerValueThree++;
                                      print(integerValueThree);
                                    });
                                  },
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                noOfRooms(
                                  'Kitchen Rooms',
                                  integerValueFour,
                                  () {
                                    setState(() {
                                      integerValueFour--;
                                      print(integerValueFour);
                                    });
                                  },
                                  () {
                                    setState(() {
                                      integerValueFour++;
                                      print(integerValueFour);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 200,
                            width: MediaQuery.of(context).size.width * .90,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: FormBuilderCheckbox(
                                        checkColor: Colors.white,
                                        activeColor: Colors.black,
                                        initialValue: false,
                                        title: const Text(
                                          'I certify that I own this property or am an authorized representative of the owner',
                                          overflow: TextOverflow.clip,
                                          softWrap: true,
                                          maxLines: 2,
                                        ),
                                        name: 'agreement',
                                        onChanged: _onChanged,
                                        validator: (value) => value == false
                                            ? 'You must agree to continue'
                                            : null,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  // mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: FormBuilderCheckbox(
                                        checkColor: Colors.white,
                                        activeColor: Colors.black,
                                        initialValue: false,
                                        title: const Text(
                                          'I certify that I have landlord\'s insurance on this property',
                                          overflow: TextOverflow.clip,
                                          softWrap: true,
                                          maxLines: 2,
                                        ),
                                        name: 'agreement',
                                        onChanged: _onChanged,
                                        validator: (value) => value == false
                                            ? 'You must agree to continue'
                                            : null,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Amenities',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(10),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'WHAT AMENITIES DOES YOUR HOME HAVE',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          checkBoxRow(
                            'Wi-Fi',
                            booleanValueOne,
                            (newBool) {
                              setState(() {
                                booleanValueOne = newBool;
                              });
                            },
                          ),
                          checkBoxRow(
                            'Outdoor space',
                            booleanValueTwo,
                            (newBool) {
                              setState(() {
                                booleanValueTwo = newBool;
                              });
                            },
                          ),
                          checkBoxRow(
                            'Window covering',
                            booleanValueThree,
                            (newBool) {
                              setState(() {
                                booleanValueThree = newBool;
                              });
                            },
                          ),
                          checkBoxRow(
                            'jacuzzi',
                            booleanValueFour,
                            (newBool) {
                              setState(() {
                                booleanValueFour = newBool;
                              });
                            },
                          ),
                          checkBoxRow(
                            'Wood floors',
                            booleanValueFive,
                            (newBool) {
                              setState(() {
                                booleanValueFive = newBool;
                              });
                            },
                          ),
                          checkBoxRow(
                            'Off street parking',
                            booleanValueSix,
                            (newBool) {
                              setState(() {
                                booleanValueSix = newBool;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'House rules',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(10),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'TIME TO SET SOME GROUND RULES FOR THE RENTERS',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('House rules'),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .90,
                                child: TextField(
                                  minLines: 4,
                                  maxLines: 12,
                                  controller: _houseRulesController,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 219, 219, 219),
                                      ),
                                    ),
                                    hintText: 'describe your house rules',
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          // color: Colors.grey,
                                          ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Location',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(10),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'WHERE IS YOUR HOME?',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                  'Click on the map to select your house location'),
                              const SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  pickedData = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SelectLocationScreen(),
                                      ));
                                  setState(() {
                                    locationBooleanVisible = true;
                                  });
                                },
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * .90,
                                  child: Image.asset(
                                    'assets/images/addis_map.png',
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Visibility(
                                visible: locationBooleanVisible,
                                child: Text(
                                'Selected Address: ${pickedData.address['county']}, ${pickedData.address['state_district'].toString().split('/ ').elementAt(1)}'),
                              ),
                              Visibility(
                                  visible: locationBoolean,
                                  child: const Text(
                                    'Please select the location of your house on map',
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Pricing',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(10),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'LET US KNOW THE FAIR MARKET VALUE TODAY',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Write in the fair market price'),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .90,
                                // height: 400,
                                child: FormBuilderTextField(
                                  keyboardType: TextInputType.phone,
                                  controller: _priceController,
                                  name: 'price',
                                  validator: (value) => value == null
                                      ? 'Please enter the price of your house'
                                      : null,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 219, 219, 219),
                                      ),
                                    ),
                                    hintText:
                                        'let us know the fair market value today',
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          // color: Colors.grey,
                                          ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(10),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'LET US KNOW HOW LONG DO YOU WANT TO RENT',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('For How long do you want to rent ?'),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .90,
                                // height: 400,
                                child: FormBuilderTextField(
                                  keyboardType: TextInputType.text,
                                  controller: _availableDatesController,
                                  name: 'time period',
                                  validator: (value) => value == null
                                      ? 'Please enter the time period'
                                      : null,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 219, 219, 219),
                                      ),
                                    ),
                                    hintText:
                                        'e.g - 6 months, 2 years , 4 days',
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide(),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Photos',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .95,
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(10),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Add A few photos',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: _pickImage,
                                  child: SizedBox(
                                    height: 250,
                                    child: _images.isNotEmpty
                                        ? GridView.builder(
                                            itemCount: _images.length,
                                            physics: const ScrollPhysics(),
                                            shrinkWrap: true,
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              crossAxisSpacing: 15,
                                              mainAxisSpacing: 12,
                                            ),
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Material(
                                                  elevation: 10,
                                                  child: Card(
                                                    child: Image.file(
                                                      _images[index],
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            })
                                        : const Center(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.cloud_upload_rounded,
                                                  size: 60,
                                                ),
                                                Text(
                                                  'Choose an Image',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                Text(
                                                  'JPG, PNG, GIF',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                  ),
                                ),
                                Visibility(
                                    visible: !imagesBoolean,
                                    child: const Text(
                                      'select at least 3 images of your house in 360 degree',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    )),
                                Visibility(
                                    visible: imagesBoolean,
                                    child: const Text(
                                      'Please select at least 3 images of your house',
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        minimumSize:
                            Size(MediaQuery.of(context).size.width * .76, 0),
                        backgroundColor: Colors.blueAccent,
                      ),
                      onPressed: () {
                        __addToAmenities(
                            booleanValueOne,
                            booleanValueTwo,
                            booleanValueThree,
                            booleanValueFour,
                            booleanValueFive,
                            booleanValueSix);
                        _noOfRooms =
                            '$integerValueOne living rooms, $integerValueTwo bed rooms, $integerValueThree shower rooms, $integerValueFour kitchen rooms';
                        if (_formKey.currentState!.saveAndValidate()) {
                          if (pickedData.latLong.latitude == 0 &&
                              pickedData.latLong.longitude == 0) {
                            locationBoolean = true;
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please select the location of your house on map and select at least 3 images of your house',
                                ),
                              ),
                            );
                          } else {
                            locationBoolean = false;
                          }
                          if (_images.length < 3) {
                            imagesBoolean = true;
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please select at least 3 images of your house',
                                ),
                              ),
                            );
                          } else {
                            imagesBoolean = false;
                          }
                          print(_formKey.currentState!.value);
                          print('----------name---------- ');
                          print(_nameController.text);
                          print('----------description---------- ');
                          print(_descriptionController.text);
                          print('----------house type---------- ');
                          print(houseType);
                          print('----------number of rooms---------- ');
                          print(_noOfRooms);
                          print('----------Amenities---------- ');
                          debugPrint(_amenitiesController.toString());
                          if (imagesBoolean == false &&
                              locationBoolean == false) {
                            // _addProperty(
                            //     user!,
                            //     _noOfRooms,
                            //     _amenitiesController,
                            //     houseType,
                            //     pickedData.latLong.latitude,
                            //     pickedData.latLong.longitude,
                            //     '${pickedData.address['county']}, ${pickedData.address['state_district'].toString().split('/ ').elementAt(1)}');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CommissionConfirmationScreen(
                                  user: user!,
                                  name: _nameController.text,
                                  description: _descriptionController.text,
                                  houseRules: _houseRulesController.text,
                                  availableDates: _availableDatesController.text,
                                  images: _images,
                                  rooms: _noOfRooms,
                                  amenities: _amenitiesController,
                                  address: 
                                  '${pickedData.address['county']}, ${pickedData.address['state_district'].toString().split('/ ').elementAt(1)}',
                                  houseType: houseType,
                                  price:
                                      int.parse(_priceController.text),
                                      pickedData: pickedData,
                                ),
                              ),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Please fill all the fields',
                              ),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        'Save',
                        style: TextStyle(
                          fontSize: 23,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column myFirstColumn(BuildContext context, String title, String name,
      String errorMessage, TextEditingController myEditingController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * .90,
          child: FormBuilderTextField(
            controller: myEditingController,
            name: title,
            validator: (value) => value == null ? errorMessage : null,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 219, 219, 219),
                ),
              ),
              hintText: title,
              border: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column noOfRooms(
    String title,
    int value,
    void Function() onRemove,
    void Function() onAdd,
  ) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.black,
                  )),
              child: IconButton(
                  onPressed: onRemove,
                  icon: const Icon(
                    Icons.remove,
                    size: 15,
                  )),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              value.toString(),
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.black,
                  )),
              child: IconButton(
                  onPressed: onAdd,
                  icon: const Icon(
                    Icons.add,
                    size: 15,
                  )),
            ),
          ],
        )
      ],
    );
  }

  Row checkBoxRow(String title, bool? boolValue, Function(bool?) onChanged) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Checkbox(
          checkColor: Colors.white,
          activeColor: Colors.black,
          value: boolValue,
          onChanged: onChanged,
        ),
        Text(
          title,
          overflow: TextOverflow.clip,
          softWrap: true,
          maxLines: 2,
        )
      ],
    );
  }
}
