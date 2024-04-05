import 'package:flutter/material.dart';

class ContractPage extends StatelessWidget {
  const ContractPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rental Contract'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildCard(
              title: 'Property Details',
              children: [
                const Text('Address: 123 Main St, City, State, Zip Code'),
                const Text('Type: Apartment'),
                const Text('Bedrooms: 2'),
                const Text('Bathrooms: 1'),
                const Text('Amenities: Parking, Laundry Facilities'),
              ],
            ),
            _buildCard(
              title: 'Rental Terms',
              children: [
                Text('Start Date: 01/01/2024'),
                Text('End Date: 12/31/2024'),
                Text('Monthly Rent: \$1000'),
                Text('Payment Due Date: 1st of each month'),
                Text('Security Deposit: \$1000'),
              ],
            ),
            _buildCard(
              title: 'Tenant Responsibilities',
              children: [
                Text('Maintain property in good condition'),
                Text('Adhere to noise restrictions'),
                Text('No subleasing without landlord approval'),
              ],
            ),
            // Add more cards for other sections...
            _buildCard(
              title: 'Contact Information',
              children: [
                Text('Landlord: John Doe'),
                Text('Phone: 123-456-7890'),
                Text('Email: john.doe@example.com'),
                Text('Tenant: Jane Smith'),
                Text('Phone: 987-654-3210'),
                Text('Email: jane.smith@example.com'),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Action to sign the contract
              },
              child: Text('Sign Contract'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({required String title, required List<Widget> children}) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            ...children,
          ],
        ),
      ),
    );
  }
}
