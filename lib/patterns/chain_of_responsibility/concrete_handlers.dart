import 'dart:developer';
import 'package:design_patterns/patterns/chain_of_responsibility/handler.dart';
import 'package:flutter/material.dart';

/// [ButtonInteractionHandler] is a concrete handler.
final class ButtonInteractionHandler extends InteractionHandler {
  @override
  void handleInteraction(String interactionType, BuildContext context) {
    if (interactionType == 'buttonClick') {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            title: Text("Button Clicked"),
            content: Text("Button interaction handled."),
          );
        },
      );
    } else if (nextHandler != null) {
      nextHandler!.handleInteraction(interactionType, context);
    } else {
      super.handleUnrecognizedInteraction(interactionType, context);
    }
  }
}

/// [FormInteractionHandler] is a concrete handler.
final class FormInteractionHandler extends InteractionHandler {
  @override
  void handleInteraction(String interactionType, BuildContext context) {
    if (interactionType == 'formSubmit') {
      // Form submit logic
      log("Form submitted.");
    } else if (nextHandler != null) {
      nextHandler!.handleInteraction(interactionType, context);
    } else {
      super.handleUnrecognizedInteraction(interactionType, context);
    }
  }
}
