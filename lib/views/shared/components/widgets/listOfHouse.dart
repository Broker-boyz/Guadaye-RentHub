import 'package:flutter/material.dart';
import 'package:gojo_renthub/views/shared/components/models/House.dart';
import 'package:gojo_renthub/views/screens/home_and _details_page/details.dart'; 

class ListOfHouses extends StatefulWidget {
  ListOfHouses({super.key, required this.houselist});

  List<House> houselist;

  @override
  State<ListOfHouses> createState() => _ListOfHousesState();
}

class _ListOfHousesState extends State<ListOfHouses> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        
          scrollDirection: Axis.horizontal,
          itemCount: widget.houselist.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: 210,
                decoration: const BoxDecoration(),
                child: Column(
                  children: [
                    InkWell(
                      child: Stack(children: [
                        Container(
                          height: 250,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: AssetImage(
                                      '${widget.houselist[index].houseImage}'),
                                  fit: BoxFit.cover),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.6),
                                    blurRadius: 4.0,
                                    offset: const Offset(0, 10)),
                              ]),
                        ),
                        Positioned(
                            bottom: 10,
                            left: 10,
                            child: Container(
                              child: Column(
                                children: [
                                  Text(
                                    "${widget.houselist[index].name}",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                          fontSize: 25,
                                    ),
                                  ),
                                  Text("${widget.houselist[index].name}")
                                ],
                              ),
                            ))
                      ]),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Details(
                                    house: widget.houselist[index],
                                  )),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
