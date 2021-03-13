import 'package:bubblez/screens/chatroom/chatroom.dart';
import 'package:bubblez/screens/feed/feed.dart';
import 'package:bubblez/screens/profile/profile.dart';
import 'package:bubblez/services/FirebaseOperations.dart';
import 'package:bubblez/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'HomepageHelpers.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final PageController homepageController = PageController();
  int pageIndex = 0;

  @override
  void initState() {
    Provider.of<FirebaseOperations>(context, listen: false)
        .initUserData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: darkColor,
        body: PageView(
          controller: homepageController,
          children: [Feed(), Chatroom(), Profile()],
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (page) {
            setState(() {
              pageIndex = page;
            });
          },
        ),
        bottomNavigationBar:
            Provider.of<HomepageHelpers>(context, listen: false)
                .bottomNavBar(context, pageIndex, homepageController));
  }
}
