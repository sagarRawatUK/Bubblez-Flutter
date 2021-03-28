import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:bubblez/home/comments.dart';
import 'package:bubblez/home/my_profile_screen.dart';
import 'package:bubblez/home/user_profile.dart';
import 'package:bubblez/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FollowingItems {
  String image;
  String name;

  FollowingItems(this.image, this.name);
}

class HomeFollowingTabScreen extends StatelessWidget {
  final bHeight;

  HomeFollowingTabScreen({this.bHeight});

  @override
  Widget build(BuildContext context) {
    List<FollowingItems> _followingItems = [
      FollowingItems('assets/images/Layer707.png', 'Emili Williamson'),
      FollowingItems('assets/images/Layer709.png', 'Harshu Makkar'),
      FollowingItems('assets/images/Layer948.png', 'Mrs. White'),
      FollowingItems('assets/images/Layer884.png', 'Marie Black'),
      FollowingItems('assets/images/Layer915.png', 'Emili Williamson'),
      FollowingItems('assets/images/Layer946.png', 'Emili Williamson'),
      FollowingItems('assets/images/Layer948.png', 'Emili Williamson'),
      FollowingItems('assets/images/Layer949.png', 'Emili Williamson'),
      FollowingItems('assets/images/Layer950.png', 'Emili Williamson'),
    ];

    final theme = Theme.of(context);
    return Container(
      height: bHeight,
      color: lightGrey,
      child: FadedSlideAnimation(
        ListView.builder(
          itemCount: _followingItems.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CommentScreen()));
              },
              child: Card(
                elevation: 0,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.all(0),
                        leading: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => UserProfileScreen()));
                          },
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage(_followingItems[index].image),
                          ),
                        ),
                        title: Text(
                          _followingItems[index].name,
                          style: theme.textTheme.bodyText1
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          "today",
                          style: theme.textTheme.bodyText1
                              .copyWith(color: textGrey, fontSize: 11),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset(
                              'assets/Icons/ic_share.png',
                              scale: 3,
                            ),
                            SizedBox(width: 20),
                            Icon(
                              Icons.bookmark_border,
                              size: 18,
                              color: grey,
                            ),
                            SizedBox(width: 20),
                            Icon(
                              Icons.more_vert,
                              size: 18,
                              color: grey,
                            ),
                          ],
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(_followingItems[index].image),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.remove_red_eye,
                                  size: 18,
                                  color: grey,
                                ),
                                SizedBox(width: 8.5),
                                Text(
                                  "1.2k",
                                  style: TextStyle(
                                      color: grey,
                                      fontSize: 12,
                                      letterSpacing: 1),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                FaIcon(
                                  Icons.repeat_rounded,
                                  color: grey,
                                  size: 18,
                                ),
                                SizedBox(width: 8.5),
                                Text(
                                  '287',
                                  style: TextStyle(
                                      color: grey,
                                      fontSize: 12,
                                      letterSpacing: 0.5),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.chat_bubble_outline,
                                  color: grey,
                                  size: 18,
                                ),
                                SizedBox(width: 8.5),
                                Text(
                                  '287',
                                  style: TextStyle(
                                      color: grey,
                                      fontSize: 12,
                                      letterSpacing: 0.5),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.favorite_border,
                                  color: grey,
                                  size: 18,
                                ),
                                SizedBox(width: 8.5),
                                Text(
                                  "8.2k",
                                  style: TextStyle(
                                      color: grey,
                                      fontSize: 12,
                                      letterSpacing: 1),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
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
