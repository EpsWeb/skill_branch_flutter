import 'package:FlutterGalleryApp/res/res.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Photo extends StatelessWidget {
  Photo({Key key, this.photoLink}) : super(key: key);
//  Photo.photo(String photo) {
//    this.photoLink = photo;
//  }

  final String photoLink;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 5.0,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(17)),
        child: Container(
          color: AppColors.grayChateau,
          child: CachedNetworkImage(
            imageUrl: photoLink,
            fit: BoxFit.fill,
            errorWidget: (context, url, error) => Icon(Icons.error),
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}
