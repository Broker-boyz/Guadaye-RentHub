import 'package:flutter/material.dart';

class RateValue extends StatelessWidget {
  final String text;
  final double value;
  const RateValue({
    super.key,
    required this.text,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Text(
              text,
              style: TextStyle(),
            )),
        Expanded(
            flex: 11,
            child: SizedBox(
            width: MediaQuery.of(context).size.width,
              child: LinearProgressIndicator(
                value: value,
                minHeight: 12,
                backgroundColor: const Color.fromARGB(255, 247, 243, 243),
                borderRadius: BorderRadius.circular(7),
                valueColor: AlwaysStoppedAnimation(Colors.blue),
              ),
            ))
      ],
    );
  }
}
