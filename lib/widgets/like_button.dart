import 'package:FlutterGalleryApp/res/res.dart';
import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  final int likeCount;
  final bool isLiked;

  LikeButton(this.likeCount, this.isLiked, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LikeButtonState();
  }
}

class _LikeButtonState extends State<LikeButton> {
  bool isLiked;
  int likeCount;

  @override
  void initState() {
    super.initState();
    isLiked = widget.isLiked;
    likeCount = widget.likeCount;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          likeCount = isLiked ? likeCount - 1 : likeCount + 1;
          isLiked = !isLiked;
        });
      },
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(isLiked ? AppIcons.like_fill : AppIcons.like),
              SizedBox(
                width: 4.21,
              ),
              Text(
                likeCount.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF000000),
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto',
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  height: 17 / 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
