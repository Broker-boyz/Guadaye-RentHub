import 'package:flutter/material.dart';
import 'package:gojo_renthub/views/shared/fonts/metalmania.dart';
import 'package:gojo_renthub/views/shared/fonts/prata.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'About Us',
          style: textStylePrata(18,
              Theme.of(context).colorScheme.inversePrimary, FontWeight.bold, 2),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 7.0),
                child: Text(
                  'Welcome to',
                  style: textStylePrata(25, Theme.of(context).colorScheme.error,
                      FontWeight.bold, 1),
                ),
              ),
            ),
            Center(
              child: Text(
                'Ethio RentHub',
                style: textStylePrata(35, Theme.of(context).colorScheme.error,
                    FontWeight.bold, 1),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'Your premier destination for finding your next home in Ethiopia. Whether you\'re looking to rent or lease, our platform connects you with a wide range of properties to suit your needs.',
              style: textStyleMetalMania(
                  20,
                  Theme.of(context).colorScheme.inversePrimary,
                  FontWeight.normal,
                  1),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                'Developed by',
                style: textStylePrata(
                    20,
                    Theme.of(context).colorScheme.inversePrimary,
                    FontWeight.bold,
                    1),
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            Center(
              child: Text(
                'The Broker Boyz',
                style: textStylePrata(28, Theme.of(context).colorScheme.error,
                    FontWeight.bold, 1),
              ),
            ),
            const SizedBox(height: 20.0),
            // Animated bouncing arrow
            GestureDetector(
              onTap: () {
                // Implement navigation to team members page
              },
              child: Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  height: 50.0,
                  width: 50.0,
                  curve: Curves.bounceInOut,
                  child: const Icon(
                    Icons.arrow_circle_down_rounded,
                    size: 50.0,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Center(
              child: Text('Meet the Team',
                  style: textStylePrata(
                      22,
                      Theme.of(context).colorScheme.inversePrimary,
                      FontWeight.bold,
                      1)),
            ),
            const SizedBox(height: 20.0),
            // Placeholder for team members
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Replace with team member names
                  Text(
                    '1. Yihun Alemayehu',
                    style: textStyleMetalMania(
                        18,
                        Theme.of(context).colorScheme.error,
                        FontWeight.bold,
                        1),
                  ),
                  Text(
                    '2. Natnael Temesgen',
                    style: textStyleMetalMania(
                        18,
                        Theme.of(context).colorScheme.error,
                        FontWeight.bold,
                        1),
                  ),
                  Text(
                    '3. Natnael Beshane',
                    style: textStyleMetalMania(
                        18,
                        Theme.of(context).colorScheme.error,
                        FontWeight.bold,
                        1),
                  ),
                  Text(
                    '4. Yiheyis Tamir',
                    style: textStyleMetalMania(
                        18,
                        Theme.of(context).colorScheme.error,
                        FontWeight.bold,
                        1),
                  ),
                  Text(
                    '5. Natnael Keleme',
                    style: textStyleMetalMania(
                        18,
                        Theme.of(context).colorScheme.error,
                        FontWeight.bold,
                        1),
                  ),
                  Text(
                    '6. Lealem Meseeret',
                    style: textStyleMetalMania(
                        18,
                        Theme.of(context).colorScheme.error,
                        FontWeight.bold,
                        1),
                  ),
                  Text(
                    '7. Wendmagegn Tajura',
                    style: textStyleMetalMania(
                        18,
                        Theme.of(context).colorScheme.error,
                        FontWeight.bold,
                        1),
                  ),
                  Text(
                    '8. Natnael Abayneh',
                    style: textStyleMetalMania(
                        18,
                        Theme.of(context).colorScheme.error,
                        FontWeight.bold,
                        1),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40.0),
            const Center(
              child: Text(
                'Thank you for choosing Ethio RentHub!',
                style: TextStyle(
                  fontSize: 20.0,
                  fontStyle: FontStyle.italic,
                  color: Colors.blueGrey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
