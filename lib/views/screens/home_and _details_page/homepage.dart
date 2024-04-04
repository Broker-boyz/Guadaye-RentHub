import 'package:flutter/material.dart';
import 'package:gojo_renthub/views/screens/home_and _details_page/details.dart';
import 'package:gojo_renthub/views/shared/components/models/House.dart';
import 'package:gojo_renthub/views/shared/components/widgets/RentHouseType.dart';
import 'package:gojo_renthub/views/shared/components/widgets/Search.dart';
import 'package:gojo_renthub/views/shared/components/widgets/listOfHouse.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

final List<House> houseList = [
  House(name: "Addis Ababa", houseImage: "Assets/images/house.jpg", price: 12,
     bedroom: 12, bathroom: 12, long: 12.0, lat: 12.0, details: "Hello john",type: HouseType.Apartment,locationName: "Piyassa"),
      House(name: "Addis Ababa", houseImage: "Assets/images/house.jpg", price: 12,
     bedroom: 12, bathroom: 12, long: 12.0, lat: 12.0, details: "Hello john", type: HouseType.Condo, locationName: "Piyasa"),
      House(name: "Addis Ababa", houseImage: "Assets/images/house.jpg", price: 12,
     bedroom: 12, bathroom: 12, long: 12.0, lat: 12.0, details: "Hello john", type: HouseType.Hotel, locationName: "Asko"), 
     ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Addis"),
        
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.notifications))
        ],
      ),



      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const FirstSearchBar(),
            
             RentType(houseType: houseList),
           
            const Row(
              children: [
                Text('Near from you',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)), 
              Spacer(), 
              Text('See more')
              ],
            ),
            ListOfHouses(houselist: houseList),
            
            
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Container(
                  child: ListView.builder(
                      itemCount: houseList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 2),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 100,
                                    width: 110,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(
                                        houseList[index].houseImage,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Orchad house",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                    Text("Birr 25000/year", style: TextStyle(color: Colors.blue)),
                                    Row(
                                      children: [
                                        Icon(Icons.king_bed),
                                        Text("6 bedroom"),
                                        SizedBox(width: 20,),
                                        Icon(Icons.bathtub),
                                        Text("4 bathroom") 
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}



