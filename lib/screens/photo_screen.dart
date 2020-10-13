import 'package:FlutterGalleryApp/res/colors.dart';
import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/screens/feed_screen.dart';
import 'package:FlutterGalleryApp/widgets/claim_bottom_sheet.dart';
import 'package:FlutterGalleryApp/widgets/like_button.dart';
import 'package:FlutterGalleryApp/widgets/photo.dart';
import 'package:FlutterGalleryApp/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';

class FullScreenImageArguments {
  final String photo;
  final String altDescription;
  final String name;
  final String userName;
  final String userPhoto;
  final String heroTag;
  final Key key;

  FullScreenImageArguments(
      {this.photo,
      this.altDescription,
      this.name,
      this.userName,
      this.userPhoto,
      this.heroTag,
      this.key});
}

class FullScreenImage extends StatefulWidget {
  FullScreenImage(
      {this.photo = '',
      this.altDescription = '',
      this.name = '',
      this.userName = '',
      Key key,
      this.heroTag = '',
      this.userPhoto = ''})
      : super(key: key);

  final String photo;
  final String altDescription;
  final String name;
  final String userName;
  final String userPhoto;
  final String heroTag;

  @override
  State<StatefulWidget> createState() {
    return FullScreenImageState();
  }
}

class FullScreenImageState extends State<FullScreenImage>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this);

    _playAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _playAnimation() async {
    try {
      await _controller.forward().orCancel;

      //  await _controller.reverse().orCancel;
    } on TickerCanceled {
      //анимация была отменена, тк была уничтожена
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.heroTag);

    return Scaffold(
      appBar: _buildAppBar(context),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Hero(
              // прилетающая картика с др страницы
              tag: widget.heroTag,
              child: Photo(
                photoLink: widget.photo,
              ),
            ),
            Padding(
              //описание под картинкой
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                widget.altDescription,
                maxLines: 3,
                style: AppStyles.h3.copyWith(color: AppColors.grayChateau),
                overflow: TextOverflow.ellipsis,
              ),
            ),

            StaggerAnimation(
              animationController: _controller,
              name: widget.name,
              userName: widget.userName,
              userPhoto: widget.userPhoto,
            ), // аватарка, имя, username анимация прозрачности

            Row(
              // строка с кнопками лайков и Text @ Visit
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                LikeButton(10, true), // кнопка с лайками
                SizedBox(width: 12),
                GestureDetector(
                    //behavior: HitTestBehavior.opaque,
                    onTap: () {
                      OverlayState overlayState = Overlay.of(context);

                      OverlayEntry entry = OverlayEntry(builder: (context) {
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
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 16),
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  decoration: BoxDecoration(
                                    color: AppColors.mercury,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text('Skillbranch'),
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                      overlayState.insert(entry);
                    },
                    child: _buildButton('Text')),
                SizedBox(width: 12),
                GestureDetector(
                  //behavior: HitTestBehavior.opaque,
                  onTap: () {
                    TextStyle textStyleContent = Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: AppColors.black);
                    TextStyle textStyleTitle = Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(color: AppColors.black);
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text(
                                "Downloading photos",
                                style: textStyleTitle,
                              ),
                              content: Text(
                                "Are you sure you want to upload a photo?",
                                style: textStyleContent,
                              ),
                              actions: <Widget>[
                                FlatButton(
                                    onPressed: () {
                                      GallerySaver.saveImage(widget.photo)
                                          .then((bool success) {
                                        Navigator.of(context).pop();
                                      });
                                    },
                                    child: Text('Download')),
                                FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Close')),
                              ],
                            ));
                  },
                  child: _buildButton('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _download() {
    GallerySaver.saveImage(widget.photo).then((bool success) {
      print(success.toString());
      Navigator.of(context).pop();
    });
  }
}

Widget _buildAppBar(context) {
  return AppBar(
    centerTitle: true,
    title: Text(
      'Photo',
      style: AppStyles.h2Black,
    ),
    actions: [
      IconButton(
        icon: Icon(Icons.more_vert),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(child: ClaimBottomSheet());
                // return Container(
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     mainAxisSize: MainAxisSize.min,
                //     children: List.generate(10, (index) => FlutterLogo()),
                //   ),
                // );
              });
        },
      )
    ],
    // leading: IconButton(
    //     icon: const Icon(CupertinoIcons.back),
    //     onPressed: () {
    //       Navigator.pop(context);
    //     }),
  );
}

Widget _buildButton(String text) {
  //кнопки
  return Container(
    width: 105,
    height: 36,
    alignment: Alignment.center,
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    // margin: EdgeInsets.all(12),
    decoration: BoxDecoration(
      shape: BoxShape.rectangle,
      color: AppColors.dodgerBlue,
      borderRadius: BorderRadius.all(Radius.circular(7)),
    ),

    child: Text(
      text,
      style: AppStyles.h4.copyWith(color: AppColors.white),
    ),
  );
}

class StaggerAnimation extends StatelessWidget {
  final Animation<double> opacityUserAvatar;
  final Animation<double> opacityText;
  final Animation<double> animationController;

  final String name;
  final String userName;
  final String userPhoto;

  StaggerAnimation(
      {Key key,
      this.animationController,
      this.name,
      this.userName,
      this.userPhoto})
      : opacityUserAvatar = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: animationController,
            curve: Interval(0.0, 0.5, curve: Curves.ease),
          ),
        ),
        opacityText = Tween<double>(begin: 0, end: 1.0).animate(
          CurvedAnimation(
            parent: animationController,
            curve: Interval(0.5, 1.0, curve: Curves.ease),
          ),
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildPhotoMetaData,
      animation: animationController,
    );
  }

  Widget _buildPhotoMetaData(BuildContext context, Widget child) {
    // ghjdthrf pyfxtybq

    // double a, b, c, d;
    //   a = animationController.value;
    //   b = opacityUserAvatar.value;
    //   print('$a - OpacityUserAvatar $b');
    //  c = animationController.value;
    // d = opacityText.value;
    //print('$c - opacityText $d');
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              FadeTransition(
                opacity: opacityUserAvatar,
                child: UserAvatar(userPhoto),
              ),
              SizedBox(width: 6),
              FadeTransition(
                opacity: opacityText,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(name, style: AppStyles.h1Black),
                    Text('@$userName',
                        style: AppStyles.h5Black
                            .copyWith(color: AppColors.manatee)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
