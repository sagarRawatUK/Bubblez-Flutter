import 'package:bubblez/home/components/notification_tab_content/notification_all_tab.dart';
import 'package:flutter/material.dart';

class NotificationScreenTabbarView extends StatelessWidget {
  final TabController _tabController;

  NotificationScreenTabbarView(this._tabController);

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: _tabController,
      children: [
        NotificationAllTabScreen(),
        NotificationAllTabScreen(),
        NotificationAllTabScreen(),
        NotificationAllTabScreen(),
      ],
    );
  }
}
