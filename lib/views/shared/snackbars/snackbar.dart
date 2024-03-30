import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:gojo_renthub/views/shared/fonts/prata.dart';

class CustomSnackBar {
  void showSnackBar(BuildContext context, String title, String content) {
    context.showFlash<bool>(
      barrierDismissible: true,
      duration: const Duration(seconds: 3),
      builder: (context, controller) => FlashBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        controller: controller,
        forwardAnimationCurve: Curves.easeInCirc,
        reverseAnimationCurve: Curves.bounceIn,
        position: FlashPosition.bottom,
        indicatorColor: Theme.of(context).colorScheme.error,
        icon: const Padding(
          padding: EdgeInsets.only(right: 15, left: 15),
          child: Icon(
            Icons.tips_and_updates_outlined,
            size: 33,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        ),
        content: Text(
          content,
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        ),
        actions: [
          TextButton(
            onPressed: () => controller.dismiss(true),
            child: Text(
              'Ok',
              style: textStylePrata(
                  12,
                  Theme.of(context).colorScheme.inversePrimary,
                  FontWeight.bold,
                  1.1),
            ),
          )
        ],
      ),
    );
  }
}
