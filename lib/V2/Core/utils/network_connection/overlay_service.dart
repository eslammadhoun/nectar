import 'package:flutter/material.dart';
import 'package:nectar/V2/Core/helpers/app_navigator.dart';
import 'package:nectar/V2/Core/utils/network_connection/no_internet_popup.dart';

class OverlayService {
  static OverlayEntry? _overlayEntry;

  static void show() {
    if (_overlayEntry != null) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final overlayState = navigatorKey.currentState?.overlay;

      if (overlayState == null || _overlayEntry != null) return;

      _overlayEntry = OverlayEntry(builder: (_) => const NoInternetPopup());
      overlayState.insert(_overlayEntry!);
    });
  }

  static void hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
