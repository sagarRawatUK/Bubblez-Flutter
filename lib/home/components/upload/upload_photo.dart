import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:bubblez/home/components/post/create_post.dart';
import 'package:bubblez/home/components/postOperations/uploadPost.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class UploadPhotoTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      child: FadedSlideAnimation(
        Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) => Container(
                        height: constraints.maxHeight,
                        child: Image.file(
                            Provider.of<UploadPost>(context).uploadPostImage)),
                  ),
                ],
              ),
            ),
            Container(
              height: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RawMaterialButton(
                    onPressed: () {
                      Provider.of<UploadPost>(context, listen: false)
                          .uploadPostImageToFirebase();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CreatePostScreen()));
                    },
                    fillColor: theme.primaryColor,
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(15),
                    child: FaIcon(
                      FontAwesomeIcons.check,
                      size: 25,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
