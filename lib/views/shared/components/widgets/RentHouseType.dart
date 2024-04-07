import 'package:flutter/material.dart';
import 'package:gojo_renthub/views/shared/components/models/House.dart';


class RentType extends StatefulWidget {
   RentType({super.key, required this.houseType, required this.categoryString});

  List<House> houseType;
  String categoryString = '';

  @override
  State<RentType> createState() => _RentTypeState();
}

class _RentTypeState extends State<RentType> {
  int? _selectedButtonIndex;
 
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ListView.builder(
        
          scrollDirection: Axis.horizontal,
          itemCount: HouseType.values.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              
                onPressed: () {
                  setState(() {
            _selectedButtonIndex = index;
            widget.categoryString = HouseType.values[index].name;
                  });
                },
                style: ButtonStyle(
              elevation: const MaterialStatePropertyAll(0),
              minimumSize: MaterialStateProperty.all(const Size(50, 50)),
                   
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0), 
                ),
                              ),
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
               if (_selectedButtonIndex == index) {
                    return Colors.black;
                  }
                  return const Color.fromARGB(255, 230, 228, 228);
            },
                  ),
                  foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (_selectedButtonIndex == index) {
                    return Colors.white;
                  }
                  return const Color.fromARGB(255, 138, 137, 137);
            },
                  ),
                ),
            child: Text(HouseType.values[index].name),
              ),
          ),
        ),
    );
  }
}
