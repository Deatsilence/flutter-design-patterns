import 'dart:developer';

import 'package:flutter/material.dart';

/// [CustomButton] is the abstract class for the template method pattern
abstract class CustomButton extends StatelessWidget {
  const CustomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          // Common styling
          backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
        ),
        child: buildButtonContent(),
      ),
    );
  }

  Widget buildButtonContent(); // Abstract method to be implemented by subclasses

  void onPressed() {
    log("Button Pressed");
  }
}
