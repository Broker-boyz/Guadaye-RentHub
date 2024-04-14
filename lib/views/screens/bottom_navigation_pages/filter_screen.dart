import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gojo_renthub/Myproperty/repo/my_property_repo.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final MyPropertyRepo _repo = MyPropertyRepo();
  List<int> _priceRangeList = [];

  Future _priceRange() async {
    _priceRangeList = await _repo.getPriceRange();
  }

  String? selectedHouseType = '';
  final houseTypes = ['Apartment', 'Villa', 'House', 'Hotel', 'Condominium'];
  final _cityOptions = [
    'Addis ababa',
    'adama',
    'jimma',
    'arba minch',
    'dire dawa'
  ];
  final _subcityOptions = [
    'Akaki kaliti',
    'Nefas Silk',
    'Bole',
    'Kirkos',
    'Yeka',
    'Arada',
    'Gulale',
    'Kolfe Keranio',
  ];
  String _selectedCity = '';
  String _selectedSubcity = '';

  RangeValues _currentRangeValues = const RangeValues(3000, 70000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Filter',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Icon(Icons.location_city_outlined),
                      SizedBox(
                        width: 20,
                      ),
                      Text('House Type'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Container(
                              color: selectedHouseType == houseTypes[index]
                                  ? Colors.black
                                  : Colors.white,
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedHouseType = houseTypes[index];
                                      });
                                    },
                                    child: Text(
                                      houseTypes[index],
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: selectedHouseType ==
                                                houseTypes[index]
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  if (index != 4) const VerticalDivider(),
                                ],
                              ),
                            );
                          },
                        ),
                      )),
                ),
                const Divider(
                  color: Colors.grey,
                ),
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Icon(Icons.location_on_outlined),
                      SizedBox(
                        width: 20,
                      ),
                      Text('City'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 30,
                    left: 30,
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width * .90,
                    child: FormBuilderDropdown<String>(
                      name: 'City',
                      isExpanded: true,
                      valueTransformer: (value) => value.toString(),
                      decoration: const InputDecoration(
                        hintText: 'Select a City',
                      ),
                      items: _cityOptions
                          .map((hType) => DropdownMenuItem(
                              value: hType, child: Text(hType)))
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          _selectedCity = val!;
                          print(_selectedCity);
                        });
                      },
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Icon(Icons.location_on_rounded),
                      SizedBox(
                        width: 20,
                      ),
                      Text('Sub-city'),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 30, left: 30, bottom: 20),
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    width: MediaQuery.of(context).size.width * .90,
                    child: FormBuilderDropdown<String>(
                      name: 'Sub-City',
                      isExpanded: true,
                      valueTransformer: (value) => value.toString(),
                      decoration: const InputDecoration(
                        hintText: 'Select a sub-city',
                      ),
                      items: _subcityOptions
                          .map((hType) => DropdownMenuItem(
                              value: hType, child: Text(hType)))
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          _selectedSubcity = val!;
                          print(_selectedCity);
                        });
                      },
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.grey,
                ),
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Icon(Icons.attach_money_rounded),
                      SizedBox(
                        width: 20,
                      ),
                      Text('Price Range'),
                    ],
                  ),
                ),
                RangeSlider(
                  overlayColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.black),
                  activeColor: Colors.black,
                  inactiveColor: Colors.grey,
                  max: 100000,
                  min: 2000,
                  values: _currentRangeValues,
                  labels: RangeLabels(
                    _currentRangeValues.start.round().toString(),
                    _currentRangeValues.end.round().toString(),
                  ),
                  onChanged: (RangeValues values) {
                    setState(() {
                      _currentRangeValues = values;
                    });
                  },
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 17),
                        height: 60,
                        width: MediaQuery.of(context).size.width * .3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              'Minimum',
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              '${_currentRangeValues.start.round()} birr',
                              style: const TextStyle(
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Text(
                        '-',
                        style: TextStyle(
                          fontSize: 50,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 17),
                        height: 60,
                        width: MediaQuery.of(context).size.width * .3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              'Maximum',
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              '${_currentRangeValues.end.round()} birr',
                              style: const TextStyle(
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Clear all'),
                      const SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black),
                        onPressed: () {
                          Navigator.pop(context,
                              '$selectedHouseType/$_selectedCity/$_selectedSubcity/${_currentRangeValues.start.round()}-${_currentRangeValues.end.round()}');
                        },
                        child: const Text('Search'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
