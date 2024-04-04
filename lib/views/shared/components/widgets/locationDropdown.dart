import 'package:flutter/material.dart';


class LocationDropdown extends StatefulWidget {
  @override
  _LocationDropdownState createState() => _LocationDropdownState();
}

class _LocationDropdownState extends State<LocationDropdown> {
  String _selectedLocation = 'Jakarta';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Location: ',
            style: TextStyle(color: Colors.white),
          ),
        ),
        DropdownButton<String>(
          value: _selectedLocation,
          onChanged: (String? newValue) {
            setState(() {
              _selectedLocation = newValue!;
            });
          },
          items: <String>['Jakarta', 'New York', 'London', 'Paris']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}