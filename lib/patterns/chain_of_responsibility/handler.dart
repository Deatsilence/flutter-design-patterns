import 'dart:developer';

import 'package:flutter/material.dart';

/// [CommandHandler] is the abstract class for all the handlers.
abstract class InteractionHandler {
  InteractionHandler? nextHandler;

  void handleInteraction(String interactionType, BuildContext context) {
    if (nextHandler != null) {
      nextHandler!.handleInteraction(interactionType, context);
    } else {
      handleUnrecognizedInteraction(interactionType, context);
    }
  }

  void setNextHandler(InteractionHandler handler) {
    nextHandler = handler;
  }

  void handleUnrecognizedInteraction(String interactionType, BuildContext context) {
    log("Unrecognized interaction: $interactionType");
    // can show a dialog here
  }
}
