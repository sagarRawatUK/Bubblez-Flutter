import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:bubblez/auth/authMethods/FirebaseOperations.dart';
import 'package:bubblez/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatSingleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final myAppBar = AppBar(
      titleSpacing: 0,
      elevation: 0,
      backgroundColor: white,
      title: Row(
        children: [
          Container(
            height: 45,
            margin: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: FadedScaleAnimation(
              CircleAvatar(
                backgroundImage: NetworkImage(
                  Provider.of<FirebaseOperations>(context).getInitUserImage,
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          Text(
            "kevinTaylor",
            style: theme.textTheme.headline6.copyWith(
              fontSize: 16.7,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      leading: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Icon(Icons.chevron_left),
      ),
    );
    final bHeight = mediaQuery.size.height -
        mediaQuery.padding.top -
        myAppBar.preferredSize.height;
    return Scaffold(
      backgroundColor: white,
      appBar: myAppBar,
      body: FadedSlideAnimation(
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                height: bHeight - 60,
              ),
              Container(
                height: 60,
                width: mediaQuery.size.width,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.emoji_emotions_outlined,
                      color: theme.primaryIconTheme.color,
                      size: 22,
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: mediaQuery.size.width * 0.7,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Write your message",
                          hintStyle: TextStyle(fontSize: 14),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.send,
                      color: theme.primaryColor,
                      size: 22,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                  ],
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
