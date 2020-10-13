import 'package:FlutterGalleryApp/screens/home.dart';
import 'package:FlutterGalleryApp/screens/photo_screen.dart';
import 'package:FlutterGalleryApp/res/res.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show TargetPlatform;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Theme.of(context).copyWith(textTheme: buildAppTextTheme()),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Home(Connectivity().onConnectivityChanged),
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == '/fullScreenImage') {
          final args = settings.arguments as FullScreenImageArguments;
          final route = FullScreenImage(
            photo: args.photo,
            altDescription: args.altDescription,
            userPhoto: args.userPhoto,
            userName: args.userName,
            heroTag: args.heroTag,
            name: args.name,
            key: key,
          );
          if (Theme.of(context).platform == TargetPlatform.android) {
            return MaterialPageRoute(builder: (context) => route);
          } else if (Theme.of(context).platform == TargetPlatform.iOS) {
            return CupertinoPageRoute(builder: (context) => route);
          }
        }
        return null;
      },
    );
  }
}
