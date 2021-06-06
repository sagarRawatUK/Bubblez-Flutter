import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:bubblez/home/components/story_screen_tab_content/story_full_view.dart';
import 'package:bubblez/home/profile/my_profile_screen.dart';
import 'package:bubblez/home/userProfile/user_profile.dart';
import 'package:bubblez/style/colors.dart';
import 'package:flutter/material.dart';

class StoryFollowingTabScreen extends StatelessWidget {
  final _bHeight;

  StoryFollowingTabScreen(this._bHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: FadedSlideAnimation(
        GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            childAspectRatio: 1 / 1.77,
          ),
          itemCount: 5,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => StoryFollowingFullView()));
              },
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/bg.jpg',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: GestureDetector(
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (_) => UserProfileScreen()));
                      },
                      child: CircleAvatar(
                        backgroundImage: AssetImage(
                          'assets/plc_profile.png',
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 10,
                    child: Row(
                      children: [
                        Icon(
                          Icons.remove_red_eye,
                          size: iconSize18,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "1.2k",
                          style: TextStyle(
                              color: white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              letterSpacing: 1),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
