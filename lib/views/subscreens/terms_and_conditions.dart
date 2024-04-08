import 'package:flutter/material.dart';
import 'package:gojo_renthub/views/shared/fonts/prata.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

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
          'Terms and Conditions',
          style: textStylePrata(18,
              Theme.of(context).colorScheme.inversePrimary, FontWeight.bold, 1),
        ),
        centerTitle: true,
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Property Owners',
                style: textStylePrata(
                    15,
                    Theme.of(context).colorScheme.inversePrimary,
                    FontWeight.bold,
                    1),
              ),
              const SizedBox(height: 15),
              ListTile(
                leading: Text(
                  '1',
                  style: textStylePrata(
                      12,
                      Theme.of(context).colorScheme.inversePrimary,
                      FontWeight.bold,
                      1),
                ),
                title: Text(
                  'By listing a property on our platform, you agree to provide accurate and up-to-date information about the property, including its amenities, location, and availability.',
                  style: textStylePrata(
                      12,
                      Theme.of(context).colorScheme.inversePrimary,
                      FontWeight.bold,
                      1),
                ),
              ),
              const SizedBox(height: 15),
              ListTile(
                leading: Text(
                  '2',
                  style: textStylePrata(
                      12,
                      Theme.of(context).colorScheme.inversePrimary,
                      FontWeight.bold,
                      1),
                ),
                title: Text(
                  'You agree to respond promptly to inquiries from potential tenants and to communicate openly and honestly throughout the rental process.',
                  style: textStylePrata(
                      12,
                      Theme.of(context).colorScheme.inversePrimary,
                      FontWeight.bold,
                      1),
                ),
              ),
              const SizedBox(height: 15),
              ListTile(
                leading: Text(
                  '3',
                  style: textStylePrata(
                      12,
                      Theme.of(context).colorScheme.inversePrimary,
                      FontWeight.bold,
                      1),
                ),
                title: Text(
                  'You acknowledge that you are solely responsible for setting rental prices, terms, and conditions for your property, and that any disputes with tenants will be resolved directly between you and the tenant.',
                  style: textStylePrata(
                      12,
                      Theme.of(context).colorScheme.inversePrimary,
                      FontWeight.bold,
                      1),
                ),
              ),
              const SizedBox(height: 15),
              ListTile(
                leading: Text(
                  '4',
                  style: textStylePrata(
                      12,
                      Theme.of(context).colorScheme.inversePrimary,
                      FontWeight.bold,
                      1),
                ),
                title: Text(
                  'You understand that our platform may charge a subscription or listing fee for property owners, and you agree to pay any applicable fees in a timely manner.',
                  style: textStylePrata(
                      12,
                      Theme.of(context).colorScheme.inversePrimary,
                      FontWeight.bold,
                      1),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Tenants',
                style: textStylePrata(
                    15,
                    Theme.of(context).colorScheme.inversePrimary,
                    FontWeight.bold,
                    1),
              ),
              const SizedBox(height: 15),
              ListTile(
                leading: Text(
                  '1',
                  style: textStylePrata(
                      12,
                      Theme.of(context).colorScheme.inversePrimary,
                      FontWeight.bold,
                      1),
                ),
                title: Text(
                  'By using our platform to search for rental properties, you agree to abide by the terms and conditions set forth by property owners, including rental prices, lease agreements, and property rules.',
                  style: textStylePrata(
                      12,
                      Theme.of(context).colorScheme.inversePrimary,
                      FontWeight.bold,
                      1),
                ),
              ),
              const SizedBox(height: 15),
              ListTile(
                leading: Text(
                  '2',
                  style: textStylePrata(
                      12,
                      Theme.of(context).colorScheme.inversePrimary,
                      FontWeight.bold,
                      1),
                ),
                title: Text(
                  'You acknowledge that any agreements made between you and a property owner are binding and that failure to comply with these agreements may result in penalties or legal action.',
                  style: textStylePrata(
                      12,
                      Theme.of(context).colorScheme.inversePrimary,
                      FontWeight.bold,
                      1),
                ),
              ),
              const SizedBox(height: 15),
              ListTile(
                leading: Text(
                  '3',
                  style: textStylePrata(
                      12,
                      Theme.of(context).colorScheme.inversePrimary,
                      FontWeight.bold,
                      1),
                ),
                title: Text(
                  'You agree to treat rental properties with respect and to adhere to any rules or regulations set forth by property owners, including those regarding noise, cleanliness, and property maintenance.',
                  style: textStylePrata(
                      12,
                      Theme.of(context).colorScheme.inversePrimary,
                      FontWeight.bold,
                      1),
                ),
              ),
              const SizedBox(height: 15),
              ListTile(
                leading: Text(
                  '4',
                  style: textStylePrata(
                      12,
                      Theme.of(context).colorScheme.inversePrimary,
                      FontWeight.bold,
                      1),
                ),
                title: Text(
                  'You understand that our platform may collect personal information from you for the purpose of facilitating rental transactions, and you consent to the use of this information in accordance with our privacy policy.',
                  style: textStylePrata(
                      12,
                      Theme.of(context).colorScheme.inversePrimary,
                      FontWeight.bold,
                      1),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'General Rules',
                style: textStylePrata(
                    15,
                    Theme.of(context).colorScheme.inversePrimary,
                    FontWeight.bold,
                    1),
              ),
              const SizedBox(height: 15),
              ListTile(
                leading: Text(
                  '1',
                  style: textStylePrata(
                      12,
                      Theme.of(context).colorScheme.inversePrimary,
                      FontWeight.bold,
                      1),
                ),
                title: Text(
                  'Both landowners and tenants agree to conduct themselves in a professional and respectful manner at all times when using our platform.',
                  style: textStylePrata(
                      12,
                      Theme.of(context).colorScheme.inversePrimary,
                      FontWeight.bold,
                      1),
                ),
              ),
              const SizedBox(height: 15),
              ListTile(
                leading: Text(
                  '2',
                  style: textStylePrata(
                      12,
                      Theme.of(context).colorScheme.inversePrimary,
                      FontWeight.bold,
                      1),
                ),
                title: Text(
                  'Any disputes or disagreements between landowners and tenants should be addressed promptly and amicably, with the goal of reaching a fair resolution for all parties involved.',
                  style: textStylePrata(
                      12,
                      Theme.of(context).colorScheme.inversePrimary,
                      FontWeight.bold,
                      1),
                ),
              ),
              const SizedBox(height: 15),
              ListTile(
                leading: Text(
                  '3',
                  style: textStylePrata(
                      12,
                      Theme.of(context).colorScheme.inversePrimary,
                      FontWeight.bold,
                      1),
                ),
                title: Text(
                  'Our platform reserves the right to suspend or terminate accounts of users who violate our terms and conditions or engage in fraudulent or abusive behavior.',
                  style: textStylePrata(
                      12,
                      Theme.of(context).colorScheme.inversePrimary,
                      FontWeight.bold,
                      1),
                ),
              ),
              const SizedBox(height: 15),
              ListTile(
                leading: Text(
                  '4',
                  style: textStylePrata(
                      12,
                      Theme.of(context).colorScheme.inversePrimary,
                      FontWeight.bold,
                      1),
                ),
                title: Text(
                  'Users are responsible for reviewing and understanding our terms and conditions, as well as any updates or changes that may occur over time. Continued use of our platform constitutes acceptance of these terms.',
                  style: textStylePrata(
                      12,
                      Theme.of(context).colorScheme.inversePrimary,
                      FontWeight.bold,
                      1),
                ),
              ),
              const SizedBox(height: 15),
              ListTile(
                leading: Text(
                  '5',
                  style: textStylePrata(
                      12,
                      Theme.of(context).colorScheme.inversePrimary,
                      FontWeight.bold,
                      1),
                ),
                title: Text(
                  ' After tenants and landowners reach agreements and complete transactions through our platform, any disputes or concerns that arise thereafter shall be resolved directly between the parties involved. Our application serves as a facilitator for rental transactions and is not responsible for mediating or arbitrating disputes between users. It is the responsibility of tenants and landowners to communicate openly and address any issues that may arise in a timely and respectful manner.',
                  style: textStylePrata(
                      12,
                      Theme.of(context).colorScheme.inversePrimary,
                      FontWeight.bold,
                      1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
