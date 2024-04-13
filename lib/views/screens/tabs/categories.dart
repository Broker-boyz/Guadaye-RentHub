import 'package:flutter/material.dart';
import 'package:gojo_renthub/views/screens/tabs/category_source.dart';

class Apartment extends StatefulWidget {
  const Apartment({super.key});

  @override
  State<Apartment> createState() => _ApartmentState();
}

class _ApartmentState extends State<Apartment> {
  @override
  Widget build(BuildContext context) {
    return const CategorySource(categoryString: 'Apartment');
  }
}

class Houses extends StatefulWidget {
  const Houses({super.key});

  @override
  State<Houses> createState() => _HousesState();
}

class _HousesState extends State<Houses> {
  @override
  Widget build(BuildContext context) {
    return const CategorySource(categoryString: 'House');
  }
}

class Villas extends StatefulWidget {
  const Villas({super.key});

  @override
  State<Villas> createState() => _VillasState();
}

class _VillasState extends State<Villas> {
  @override
  Widget build(BuildContext context) {
    return const CategorySource(categoryString: 'Villa');
  }
}

class Hotel extends StatefulWidget {
  const Hotel({super.key});

  @override
  State<Hotel> createState() => _HotelState();
}

class _HotelState extends State<Hotel> {
  @override
  Widget build(BuildContext context) {
    return const CategorySource(categoryString: 'Hotel');
  }
}

class Condominium extends StatefulWidget {
  const Condominium({super.key});

  @override
  State<Condominium> createState() => _CondominiumState();
}

class _CondominiumState extends State<Condominium> {
  @override
  Widget build(BuildContext context) {
    return const CategorySource(categoryString: 'Condominuim');
  }
}