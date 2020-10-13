import 'package:FlutterGalleryApp/res/colors.dart';
import 'package:flutter/material.dart';

class ClaimBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const claims = ['Adult', 'Harm', 'Bully', 'Spam', 'Copyright', 'Hate'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        claims.length,
        (index) => Material(
          color: AppColors.mercury,
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            // decoration: BoxDecoration(),
            child: InkWell(
              splashColor: AppColors.dodgerBlue,
              child: Text(
                claims[index].toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: Colors.blueAccent, height: 1.8),
                textAlign: TextAlign.center,
              ),
              onTap: () => Navigator.pop(context),
            ),
          ),
        ),
      ).toList(),
    );
  }
}
