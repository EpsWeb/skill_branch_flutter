import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/screens/photo_screen.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';
import 'package:flutter/material.dart';

const String kFlutterDash =
    'https://flutter.dev/assets/404/dash_nest-c64796b59b65042a2b40fae5764c13b7477a592db79eaf04c86298dcb75b78ea.png';

class FeedScreen extends StatefulWidget {
  FeedScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FeedScreenState();
  }
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                _buildItem(index),
                Divider(
                  thickness: 2.0,
                  color: AppColors.mercury,
                ),
              ],
            );
          }),
    );
  }

  Widget _buildItem(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          child: Hero(
            tag: 'hero-full-screen-page-$index',
            child: Photo(
              photoLink: kFlutterDash,
            ),
          ),
          onTap: () {
            Navigator.pushNamed(context, '/fullScreenImage',
                arguments: FullScreenImageArguments(
                  heroTag: 'hero-full-screen-page-$index',
                  photo: kFlutterDash,
                  name: 'Daniel Epel',
                  userName: 'danielepel',
                  userPhoto:
                      'https://skill-branch.ru/img/speakers/Adechenko.jpg',
                  altDescription:
                      'Beatiful girl in a yellow dress with a flower on her head in the summer in the forest Beatiful girl in a yellow dress with a flower on her head in the summer in the forest Beatiful girl in a yellow dress with a flower on her head in the summer in the forest Beatiful girl in a yellow dress with a flower on her head in the summer in the forest Beatiful girl in a yellow dress with a flower on her head in the summer in the forest',
                ));
          },
        ),
        _buildPhotoMeta(),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text(
            'This is Flutter dash I love it!',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: AppStyles.h3.copyWith(
              color: AppColors.manatee,
            ),
          ),
        ),
      ],
    );
  }

  _buildPhotoMeta() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              UserAvatar('https://skill-branch.ru/img/speakers/Adechenko.jpg'),
              SizedBox(
                width: 6,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Daniel Epel',
                    style: AppStyles.h2Black,
                  ),
                  Text(
                    '@danielepel',
                    style: AppStyles.h5Black.copyWith(color: AppColors.manatee),
                  ),
                ],
              )
            ],
          ),
          LikeButton(10, true),
        ],
      ),
    );
  }
}
