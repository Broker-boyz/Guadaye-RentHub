import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

class SelectLocationScreen extends StatefulWidget {
  const SelectLocationScreen({super.key});

  @override
  State<SelectLocationScreen> createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Select Location'),
        ),
        body: OpenStreetMapSearchAndPick(
            buttonColor: Colors.blue,
            buttonText: 'Set Current Location',
            onPicked: (pickedData) {
              print(pickedData.latLong.latitude);
              print(pickedData.latLong.longitude);
              print('------------elementAt(1)------------');
              print(pickedData.address['state_district'].toString().split('/ ').elementAt(1));
              print('------------elementAt(1)------------');
              final da = pickedData.address['state_district'].toString().split('/ ');
              if(da.length > 1) {
                final stringAfterSlash = da[1].trim();
              print(stringAfterSlash);
              }
              print(pickedData.address['county']);
              Navigator.pop(context, pickedData);
            }));
  }
}

