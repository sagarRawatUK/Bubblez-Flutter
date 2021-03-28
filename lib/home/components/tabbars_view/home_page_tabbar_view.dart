import 'package:bubblez/home/components/home_screen_tab_content/home_following_screen.dart';
import 'package:flutter/material.dart';

class HomeScreenTabbarView extends StatelessWidget {
  final TabController _tabController;
  double bHeight;

  HomeScreenTabbarView(this._tabController, this.bHeight);

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: _tabController,
      children: [
        HomeFollowingTabScreen(bHeight: bHeight),
        HomeFollowingTabScreen(bHeight: bHeight),
        HomeFollowingTabScreen(bHeight: bHeight),
        HomeFollowingTabScreen(bHeight: bHeight),
        HomeFollowingTabScreen(bHeight: bHeight),
      ],
    );
  }
}
