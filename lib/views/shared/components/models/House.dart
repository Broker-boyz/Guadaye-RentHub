import 'package:flutter/material.dart';


enum HouseType {Apartment, House, Hotel, Villa, Condominium,}
class House{ 

  House({ required this.name, required this.houseImage, required this.price, 
  required this.bedroom, required this.bathroom, required this.long, required this.lat,
   required this.details, required this.type, required this.locationName});

String name;
String houseImage;
double price;
double bedroom;
double bathroom;
double long;
double lat;
String details;
String locationName; 
final HouseType type;
Map location(){
  return {"long": long, "lat": lat};
}

}