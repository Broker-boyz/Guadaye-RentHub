import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class BuildPage extends StatelessWidget {
  final Color color;
  final String url;
  final String title;
  final String subtitle;
  const BuildPage(
      {super.key,
      required this.color,
      required this.url,
      required this.title,
      required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Column(
        children: [
          Lottie.asset(url),
           const SizedBox(height: 24),
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
           const SizedBox(height: 64),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Text(
              subtitle,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
