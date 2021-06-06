import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:bubblez/auth/authMethods/Authentication.dart';
import 'package:bubblez/auth/authMethods/FirebaseOperations.dart';

import 'package:bubblez/home/components/story_screen_tab_content/story_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'story_helper.dart';

class UploadStoryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: Colors.white,
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
                            Provider.of<StoryHelpers>(context).storyImage)),
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
                    onPressed: () async {
                      Provider.of<StoryHelpers>(context, listen: false)
                          .uploadStoryImage(context);

                      if (Provider.of<StoryHelpers>(context, listen: false)
                              .getStoryImageUrl !=
                          null) {
                        await FirebaseFirestore.instance
                            .collection('stories')
                            .doc(Provider.of<Authentication>(context,
                                    listen: false)
                                .getUserUid)
                            .set({
                          'image':
                              Provider.of<StoryHelpers>(context, listen: false)
                                  .getStoryImageUrl,
                          'username': Provider.of<FirebaseOperations>(context,
                                  listen: false)
                              .getInitUserName,
                          'userimage': Provider.of<FirebaseOperations>(context,
                                  listen: false)
                              .getInitUserImage,
                          'time': Timestamp.now(),
                          'useruid': Provider.of<Authentication>(context,
                                  listen: false)
                              .getUserUid
                        }).whenComplete(() {
                          // Navigator.pushReplacement(
                          //     context,
                          //     PageTransition(
                          //         child: Homepage(),
                          //         type: PageTransitionType
                          //             .bottomToTop));
                        });
                      }
                      Navigator.pop(context);
                      Navigator.pop(context);
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
