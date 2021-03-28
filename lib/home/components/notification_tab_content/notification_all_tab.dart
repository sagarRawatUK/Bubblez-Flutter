import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:bubblez/home/my_profile_screen.dart';
import 'package:bubblez/home/user_profile.dart';
import 'package:bubblez/style/colors.dart';
import 'package:flutter/material.dart';

class NotificationAllTabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: white,
      child: FadedSlideAnimation(
        ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                contentPadding: EdgeInsets.only(left: 16, right: 10),
                leading: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => UserProfileScreen()));
                  },
                  child: FadedScaleAnimation(
                    CircleAvatar(
                      radius: 22,
                      backgroundImage: AssetImage(
                          'assets/images/profile_pics/Layer1804.png'),
                    ),
                  ),
                ),
                // title: Text('Kevin Taylor Liked your post'),
                title: RichText(
                  text: TextSpan(
                    style: theme.textTheme.subtitle1.copyWith(
                      letterSpacing: 0.5,
                    ),
                    children: [
                      TextSpan(
                          text: "Kevin",
                          style:
                              theme.textTheme.subtitle2.copyWith(fontSize: 12)),
                      TextSpan(
                          text: ' ' + 'Liked' + ' ',
                          style: TextStyle(
                              color: theme.primaryColor, fontSize: 12)),
                      TextSpan(
                          text: "Your Post",
                          style: theme.textTheme.subtitle2.copyWith(
                            fontSize: 12,
                          )),
                    ],
                  ),
                ),
                subtitle: Text(
                  "today",
                  style: theme.textTheme.subtitle2.copyWith(
                    fontSize: 9,
                    color: theme.hintColor,
                  ),
                ),
                trailing: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: Image.asset(
                      'assets/images/Layer709.png',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
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
