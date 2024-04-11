import 'package:chapa_unofficial/chapa_unofficial.dart';
import 'package:flutter/material.dart';

class CommissionConfirmationScreen extends StatefulWidget {
  final int propertyValue;
  CommissionConfirmationScreen({required this.propertyValue});

  @override
  State<CommissionConfirmationScreen> createState() => _CommissionConfirmationScreenState();
}

class _CommissionConfirmationScreenState extends State<CommissionConfirmationScreen> {
 // Property rental value
  final double commissionRate = 0.04; 
  double finalTotal = 0.0;
  String message = '';

  Future<void> pay() async {
    String txRef = TxRefRandomGenerator.generate(prefix: 'The-Broker-boyz');
    await Chapa.getInstance.startPayment(
      context: context,
      onInAppPaymentSuccess: (successMsg) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Payment successful')));
        message = 'successful';
      },
      onInAppPaymentError: (errorMsg) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('An Error has occurred')));
        message = 'error';
      },
      amount: finalTotal.toString(),
      currency: 'ETB',
      txRef: txRef,
    );
  }


  @override
  Widget build(BuildContext context) {
    double commissionAmount = widget.propertyValue * commissionRate;
    finalTotal = commissionAmount;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Commission Confirmation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'To list your property, a commission fee of 4% will be charged upon successful listing of your property.',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Estimated Commission:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
             Text(
              'ETB $commissionAmount',
              style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),
            TextButton(
              onPressed: () {
                
              },
              child: const Text(
                'View Terms and Conditions',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            const SizedBox(height: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () async{
                    await pay();
                  },
                  child: const Text('Accept and Proceed'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); 
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Note: Commission fee will only be charged upon successful rental agreement.',
              style: TextStyle(fontSize: 12.0),
            ),
          ],
        ),
      ),
    );
  }
}

