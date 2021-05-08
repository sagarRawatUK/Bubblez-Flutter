import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:bubblez/home/profile/my_profile_screen.dart';
import 'package:bubblez/home/userProfile/user_profile.dart';
import 'package:bubblez/style/colors.dart';
import 'package:flutter/material.dart';

class StoryFollowingFullView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: FadedSlideAnimation(
        Container(
          width: mediaQuery.size.width,
          height: mediaQuery.size.height,
          color: white,
          child: Stack(
            alignment: Alignment.center,
            overflow: Overflow.clip,
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/images/Layer1774.png',
                fit: BoxFit.fitHeight,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.remove_red_eye,
                          color: white,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "1.2k",
                          style:
                              theme.textTheme.bodyText1.copyWith(color: white),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          color: white,
                        ),
                        SizedBox(width: 10),
                        Text(
                          '287',
                          style:
                              theme.textTheme.bodyText1.copyWith(color: white),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.favorite_border,
                          color: white,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "8.2k",
                          style:
                              theme.textTheme.bodyText1.copyWith(color: white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 70),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    RotatedBox(
                      quarterTurns: 1,
                      child: Icon(
                        Icons.chevron_left,
                        size: 24,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Swipe up to see Next",
                      style: theme.textTheme.bodyText1
                          .copyWith(color: white, fontSize: 13),
                    ),
                  ],
                ),
              ),
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
                top: 20,
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
                        backgroundImage: AssetImage(
                            'assets/images/profile_pics/Layer1804.png'),
                      ),
                    ),
                  ),
                  title: Text(
                    'James Taylor',
                    style: theme.textTheme.subtitle2.copyWith(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                  subtitle: Text(
                    "today",
                    style: theme.textTheme.subtitle2.copyWith(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
