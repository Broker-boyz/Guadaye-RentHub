import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Products'),
      ),
      body: const Center(
        child: Text('List of favorite products'),
      ),
    );
  }
}
