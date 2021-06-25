import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:bubblez/home/components/story_screen_tab_content/story_helper.dart';

import 'package:bubblez/style/colors.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StoryFollowingFullView extends StatefulWidget {
  final item;
  StoryFollowingFullView(this.item);

  @override
  _StoryFollowingFullViewState createState() => _StoryFollowingFullViewState();
}

class _StoryFollowingFullViewState extends State<StoryFollowingFullView> {
  @override
  void initState() {
    Provider.of<StoryHelpers>(context, listen: false)
        .storyTimePosted(widget.item['time']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: FadedSlideAnimation(
        SafeArea(
          child: Container(
            width: mediaQuery.size.width,
            height: mediaQuery.size.height,
            color: white,
            child: Stack(
              alignment: Alignment.center,
              fit: StackFit.expand,
              children: [
                Image.network(
                  widget.item["image"],
                  fit: BoxFit.contain,
                ),
                // Container(
                //   margin: EdgeInsets.only(bottom: 20),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                //     crossAxisAlignment: CrossAxisAlignment.end,
                //     children: [
                //       Row(
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         children: [
                //           Icon(
                //             Icons.remove_red_eye,
                //             color: Colors.white,
                //           ),
                //           SizedBox(width: 10),
                //           Text(
                //             "1.2k",
                //             style: theme.textTheme.bodyText1
                //                 .copyWith(color: Colors.white),
                //           ),
                //         ],
                //       ),
                //       Row(
                //         children: [
                //           Icon(
                //             Icons.chat_bubble_outline,
                //             color: Colors.white,
                //           ),
                //           SizedBox(width: 10),
                //           Text(
                //             '287',
                //             style: theme.textTheme.bodyText1
                //                 .copyWith(color: Colors.white),
                //           ),
                //         ],
                //       ),
                //       Row(
                //         children: [
                //           Icon(
                //             Icons.favorite_border,
                //             color: Colors.white,
                //           ),
                //           SizedBox(width: 10),
                //           Text(
                //             "8.2k",
                //             style: theme.textTheme.bodyText1
                //                 .copyWith(color: Colors.white),
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
                // Container(
                //   margin: EdgeInsets.only(bottom: 70),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     crossAxisAlignment: CrossAxisAlignment.end,
                //     children: [
                //       RotatedBox(
                //         quarterTurns: 1,
                //         child: Icon(
                //           Icons.chevron_left,
                //           size: 24,
                //         ),
                //       ),
                //       SizedBox(
                //         width: 10,
                //       ),
                //       Text(
                //         "Swipe up to see Next",
                //         style: theme.textTheme.bodyText1
                //             .copyWith(color: Colors.white, fontSize: 13),
                //       ),
                //     ],
                //   ),
                // ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black26,
                        Colors.transparent,
                        Colors.black26
                      ],
                    ),
                  ),
                ),
                PositionedDirectional(
                  top: 0,
                  start: 0,
                  end: 0,
                  // margin: EdgeInsets.only(top: mediaQuery.padding.top),
                  child: ListTile(
                    leading: GestureDetector(
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (_) => UserProfileScreen()));
                      },
                      child: FadedScaleAnimation(
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage(widget.item['userimage']),
                        ),
                      ),
                    ),
                    title: Text(
                      widget.item['username'],
                      style: theme.textTheme.subtitle2.copyWith(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                    subtitle: Text(
                      Provider.of<StoryHelpers>(context, listen: false)
                          .getStoryTime,
                      style: theme.textTheme.subtitle2.copyWith(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularCountDownTimer(
                            isTimerTextShown: false,
                            onComplete: () {
                              Navigator.pop(context);
                            },
                            strokeWidth: 4,
                            width: 22,
                            height: 22,
                            duration: 10,
                            fillColor: primaryColor.withOpacity(0.7),
                            ringColor: Colors.transparent),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
