import 'package:FlutterGalleryApp/res/colors.dart';
import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/screens/feed_screen.dart';
import 'package:FlutterGalleryApp/widgets/like_button.dart';
import 'package:FlutterGalleryApp/widgets/photo.dart';
import 'package:FlutterGalleryApp/widgets/user_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FullScreenImage extends StatefulWidget {
  final String photo;
  final String altDescription;
  final Key key;
  final String userName;
  final String name;

  FullScreenImage(
      {this.photo, this.altDescription, this.userName, this.name, this.key})

      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FullScreenImageState();
  }
}

class _FullScreenImageState extends State<FullScreenImage> {
  String photo;
  String altDescription;
  String userName;
  String name;

  @override
  void initState() {
    super.initState();
    this.name = widget.name != null ? widget.name : '';
    this.userName = widget.userName != null ? widget.userName : '';
    this.altDescription = widget.altDescription != null ? widget.altDescription : '';
    this.photo = widget.photo != null ? widget.photo : '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Photo',
            style: TextStyle(
              color: AppColors.black,
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.back,
            color: AppColors.manatee,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Photo(
          photoLink: kFlutterDash,
        ),
        _buildDescription(),
        _buildUserInfo(),
        _buildBottom(),
      ],
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
      child: Text(
        altDescription,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: AppStyles.h3,
      ),
    );
  }

  Widget _buildUserInfo() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          UserAvatar('https://skill-branch.ru/img/speakers/Adechenko.jpg'),
          SizedBox(
            width: 7,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildText(name: 'Daniel Epel'),
              _buildText(nickName: 'danielepel'),
            ],
          ),
        ],
      ),
    );
  }

  Text _buildText({String name, String nickName}) {
    if (name != null) {
      return Text(
        name,
        style: AppStyles.h1Black,
      );
    }
    return Text(
      '@' + nickName,
      style: AppStyles.h5Black.copyWith(color: AppColors.manatee),
    );
  }

  Widget _buildBottom() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        LikeButton(10, false),
        _buildButton('Save'),
        _buildButton('Visit'),
      ],
    );
  }

  // todo
  Widget _buildButton(String text) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        print('Presss');
      },
      child: Container(
        child: Center(child: Text(text, style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w600),)),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
        decoration: BoxDecoration(
          color: AppColors.dodgerBlue,
          borderRadius: BorderRadius.circular(7),
        ),
      ),
    );
  }
}
