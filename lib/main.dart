import 'package:FlutterGalleryApp/res/res.dart';
import 'package:flutter/rendering.dart';

import 'app.dart';
import 'package:flutter/material.dart';

void main() {
  // debugPaintBaselinesEnabled = true;
  runApp(MyApp());
}

class ConnectivityOverlay {
  static final ConnectivityOverlay _singleton = ConnectivityOverlay._internal();

  factory ConnectivityOverlay() {
    return _singleton;
  }

  ConnectivityOverlay._internal();

  static OverlayEntry overlayEntry;

  void showOverlay(BuildContext context, Widget child) {
    print('showOverlay');
    OverlayState overlayState = Overlay.of(context);

    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
        top: MediaQuery.of(context).viewInsets.top + 50,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: AppColors.mercury,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: child,
              ),
            ),
          ),
        ),
      );
    });
    overlayState.insert(overlayEntry);
  }

  void removeOverlay(BuildContext context) {
    print('removeOverlay');
    if (overlayEntry != null) {
      overlayEntry.remove();
    }
  }
}
