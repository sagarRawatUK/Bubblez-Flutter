import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:bubblez/home/components/chat_tabs/chat_friend_tab.dart';
import 'package:bubblez/home/components/chat_tabs/chat_group_tab_screen.dart';
import 'package:flutter/material.dart';

class ChatScreenTabbarView extends StatelessWidget {
  final TabController _tabController;

  ChatScreenTabbarView(this._tabController);

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: _tabController,
      children: [
        FadedSlideAnimation(
          ChatFriendTabScreen(),
          beginOffset: Offset(0, 0.3),
          endOffset: Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
        ),
        FadedSlideAnimation(
          ChatGroupTabScreen(),
          beginOffset: Offset(0, 0.3),
          endOffset: Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
        ),
      ],
    );
  }
}
