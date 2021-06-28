import 'dart:math';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:bubblez/auth/authMethods/FirebaseOperations.dart';
import 'package:bubblez/home/chatroom/chat_screen.dart';
import 'package:bubblez/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatItems {
  String image;
  String name;

  ChatItems(this.image, this.name);
}

class ChatFriendTabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<ChatItems> _chatItems = [
      ChatItems(
          Provider.of<FirebaseOperations>(context, listen: false)
              .getInitUserImage,
          'Emili Williamson'),
      ChatItems(
          Provider.of<FirebaseOperations>(context, listen: false)
              .getInitUserImage,
          'Harshu Makkar'),
      ChatItems(
          Provider.of<FirebaseOperations>(context, listen: false)
              .getInitUserImage,
          'Mrs. White'),
      ChatItems(
          Provider.of<FirebaseOperations>(context, listen: false)
              .getInitUserImage,
          'Marie Black'),
      ChatItems(
          Provider.of<FirebaseOperations>(context, listen: false)
              .getInitUserImage,
          'Emili Williamson'),
      ChatItems(
          Provider.of<FirebaseOperations>(context, listen: false)
              .getInitUserImage,
          'Emili Williamson'),
      ChatItems(
          Provider.of<FirebaseOperations>(context, listen: false)
              .getInitUserImage,
          'Emili Williamson'),
      ChatItems(
          Provider.of<FirebaseOperations>(context, listen: false)
              .getInitUserImage,
          'Emili Williamson'),
      ChatItems(
          Provider.of<FirebaseOperations>(context, listen: false)
              .getInitUserImage,
          'Emili Williamson'),
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
                        backgroundImage: NetworkImage(_chatItems[index].image),
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
                "Last Message",
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
