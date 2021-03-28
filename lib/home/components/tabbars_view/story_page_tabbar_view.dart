import 'package:bubblez/home/components/story_screen_tab_content/story_following_tab.dart';
import 'package:flutter/material.dart';

class StoryScreenTabbarView extends StatelessWidget {
  final TabController _tabController;
  final _bHeight;

  StoryScreenTabbarView(this._tabController, this._bHeight);

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: _tabController,
      children: [
        StoryFollowingTabScreen(_bHeight),
        StoryFollowingTabScreen(_bHeight),
        StoryFollowingTabScreen(_bHeight),
        StoryFollowingTabScreen(_bHeight),
        StoryFollowingTabScreen(_bHeight),
      ],
    );
  }
}
