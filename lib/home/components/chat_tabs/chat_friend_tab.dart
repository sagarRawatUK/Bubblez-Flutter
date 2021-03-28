import 'dart:math';
import 'dart:ui';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:bubblez/home/chat_screen.dart';
import 'package:bubblez/style/colors.dart';
import 'package:flutter/material.dart';

class ChatItems {
  String image;
  String name;

  ChatItems(this.image, this.name);
}

class ChatFriendTabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<ChatItems> _chatItems = [
      ChatItems('assets/images/Layer707.png', 'Emili Williamson'),
      ChatItems('assets/images/Layer709.png', 'Harshu Makkar'),
      ChatItems('assets/images/Layer948.png', 'Mrs. White'),
      ChatItems('assets/images/Layer884.png', 'Marie Black'),
      ChatItems('assets/images/Layer915.png', 'Emili Williamson'),
      ChatItems('assets/images/Layer946.png', 'Emili Williamson'),
      ChatItems('assets/images/Layer948.png', 'Emili Williamson'),
      ChatItems('assets/images/Layer949.png', 'Emili Williamson'),
      ChatItems('assets/images/Layer950.png', 'Emili Williamson'),
    ];
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: ListView.builder(
        itemCount: _chatItems.length,
        itemBuilder: (context, index) {
          bool _rand;
          if ((Random().nextInt(10)) % 2 == 0) {
            _rand = true;
          } else {
            _rand = false;
          }
          return Card(
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ChatSingleScreen()));
              },
              leading: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                    child: FadedScaleAnimation(
                      CircleAvatar(
                        radius: 24,
                        backgroundImage: AssetImage(_chatItems[index].image),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: _rand
                        ? Container(
                            decoration: BoxDecoration(
                              color: theme.primaryColor,
                              shape: BoxShape.circle,
                            ),
                            padding: EdgeInsets.fromLTRB(4, 0, 4, 2),
                            child: Center(
                              child: Text(
                                '${Random().nextInt(10)}',
                                style: theme.textTheme.bodyText1
                                    .copyWith(color: white, fontSize: 8),
                              ),
                            ),
                          )
                        : Container(),
                  ),
                ],
              ),
              title: Text(
                _chatItems[index].name,
                style: TextStyle(
                  color: _rand ? theme.primaryColor : black,
                  fontSize: 13.3,
                ),
              ),
              subtitle: Text(
                "yesThatWasAwesome",
                style: theme.textTheme.subtitle2.copyWith(
                  color: theme.hintColor,
                  fontSize: 10.7,
                ),
              ),
              trailing: Text(
                "2 min ago",
                style: theme.textTheme.bodyText1
                    .copyWith(color: grey, fontSize: 9.3),
              ),
            ),
          );
        },
      ),
    );
  }
}
