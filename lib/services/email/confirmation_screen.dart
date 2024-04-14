// import 'package:chapa_unofficial/chapa_unofficial.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gojo_renthub/views/shared/fonts/nunito.dart';
import 'package:gojo_renthub/views/subscreens/terms_and_conditions.dart';
import 'package:modern_form_line_awesome_icons/modern_form_line_awesome_icons.dart';

class CommissionConfirmationScreen extends StatefulWidget {
  User user;
  String rooms;
  List<String> amenities;
  String address;
  String houseType;
  final int propertyValue;
  CommissionConfirmationScreen(
      {super.key,
      required this.user,
      required this.rooms,
      required this.amenities,
      required this.address,
      required this.houseType,
      required this.propertyValue});

  @override
  State<CommissionConfirmationScreen> createState() =>
      _CommissionConfirmationScreenState();
}

class _CommissionConfirmationScreenState
    extends State<CommissionConfirmationScreen> {
  // Property rental value
  final double commissionRate = 0.04;
  double finalTotal = 0.0;
  String message = '';

  // Future<void> pay() async {
  //   String txRef = TxRefRandomGenerator.generate(prefix: 'The-Broker-boyz');
  //   await Chapa.getInstance.startPayment(
  //     context: context,
  //     onInAppPaymentSuccess: (successMsg) {
  //       ScaffoldMessenger.of(context)
  //           .showSnackBar(const SnackBar(content: Text('Payment successful')));
  //       message = 'successful';
  //     },
  //     onInAppPaymentError: (errorMsg) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(content: Text('An Error has occurred')));
  //       message = 'error';
  //     },
  //     amount: finalTotal.toString(),
  //     currency: 'ETB',
  //     txRef: txRef,
  //   );
  // }
  bool isAgreeWithTermAndPolicy = false;
  @override
  Widget build(BuildContext context) {
    double commissionAmount = widget.propertyValue * commissionRate;
    finalTotal = commissionAmount;
    return Scaffold(
      appBar: AppBar(
        title: Text('Property Confirmation',
            style: textStyleNunito(
                20,
                Theme.of(context).colorScheme.inversePrimary,
                FontWeight.w900,
                0)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('All data which describes your property',
                  style: textStyleNunito(
                      18,
                      Theme.of(context).colorScheme.inversePrimary,
                      FontWeight.w700,
                      0)),
              Text('If something wrong don\'t be hesitate to correct',
                  style: textStyleNunito(
                      16,
                      Theme.of(context).colorScheme.inversePrimary,
                      FontWeight.w400,
                      0)),
              Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  color: Colors.grey[200],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      propertyConfirmation(
                          context, 'Owner: ', widget.user.email.toString()),
                      propertyConfirmation(
                          context, 'Property Address: ', widget.address),
                      propertyConfirmation(context, 'Rooms: ', widget.rooms),
                      propertyConfirmation(
                          context, 'House Type: ', widget.houseType),
                      propertyConfirmation(
                          context, 'Amenities: ', widget.amenities.toString()),
                      propertyConfirmation(
                          context, 'Price: ', '${widget.propertyValue} ETB'),
                    ],
                  )),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(
                  LineAwesomeIcons.info_circle,
                  size: 20,
                  color: Colors.lightBlue,
                ),
                label: Text(
                    'To list your property, a commission fee of 4% will be charged upon successful listing of your property.',
                    style: textStyleNunito(
                        16,
                        Theme.of(context).colorScheme.inversePrimary,
                        FontWeight.w400,
                        0)),
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  Text(
                    'Estimated Commission:',
                    style: textStyleNunito(
                        18,
                        Theme.of(context).colorScheme.inversePrimary,
                        FontWeight.w900,
                        0),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'ETB $commissionAmount',
                    style: textStyleNunito(
                        18,
                        Theme.of(context).colorScheme.inversePrimary,
                        FontWeight.w900,
                        0),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  Checkbox.adaptive(
                      activeColor: Theme.of(context).colorScheme.inversePrimary,
                      value: isAgreeWithTermAndPolicy,
                      onChanged: ((value) => setState(() {
                            isAgreeWithTermAndPolicy = value ?? false;
                          }))),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const TermsAndConditionsPage()));
                    },
                    child: const Text(
                      'View Terms and Conditions',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: isAgreeWithTermAndPolicy
                        ? Colors.lightBlueAccent
                        : Colors.grey[400],
                    onPressed: () async {
                      // await pay();
                      isAgreeWithTermAndPolicy
                          ? 'do something'
                          : ScaffoldMessenger.of(context).showMaterialBanner(
                              MaterialBanner(
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                  forceActionsBelow: true,
                                  animation: const AlwaysStoppedAnimation(12),
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, top: 15),
                                  content: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                      child: Text(
                                        'Please First Agree On Our Terms and Conditions',
                                        style: textStyleNunito(
                                            16,
                                            Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            FontWeight.w900,
                                            0),
                                      ),
                                    ),
                                  ),
                                  actions: [
                                  TextButton(
                                      onPressed: () {
                                        ScaffoldMessenger.of(context)
                                            .hideCurrentMaterialBanner();
                                        isAgreeWithTermAndPolicy = true;
                                        setState(() {});
                                      },
                                      child: const Text(
                                        'Agree',
                                        style: TextStyle(
                                            color: Colors.lightBlueAccent,
                                            fontSize: 18),
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        ScaffoldMessenger.of(context)
                                            .hideCurrentMaterialBanner();
                                      },
                                      child: const Text(
                                        'Dismiss',
                                        style: TextStyle(
                                            color: Colors.lightBlueAccent,
                                            fontSize: 18),
                                      ))
                                ]));
                    },
                    child: Text(
                      'Accept and Proceed',
                      style: textStyleNunito(
                          18,
                          Theme.of(context).colorScheme.primary,
                          FontWeight.w900,
                          0),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancel',
                      style: textStyleNunito(
                          18, Colors.redAccent, FontWeight.w900, 0),
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
      ),
    );
  }

  Row propertyConfirmation(
      BuildContext context, String title, String description) {
    return Row(
      children: [
        Text(title,
            style: textStyleNunito(
                18,
                Theme.of(context).colorScheme.inversePrimary,
                FontWeight.w700,
                0)),
        const SizedBox(
          width: 10,
        ),
        Text(description,
            style: textStyleNunito(
                17,
                Theme.of(context).colorScheme.inversePrimary,
                FontWeight.w400,
                0)),
      ],
    );
  }
}
