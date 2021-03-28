import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:bubblez/style/colors.dart';
import 'package:flutter/material.dart';

class MyProfileScreen extends StatefulWidget {
  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final myAppBar = AppBar(
      backgroundColor: white,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.chevron_left),
      ),
      elevation: 0,
    );
    final bheight = mediaQuery.size.height -
        mediaQuery.padding.top -
        myAppBar.preferredSize.height;
    return Scaffold(
      backgroundColor: white,
      appBar: myAppBar,
      body: FadedSlideAnimation(
        Column(
          children: [
            Container(
              color: white,
              height: bheight * 0.4,
              child: LayoutBuilder(
                builder: (context, constraints) => Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('9784', style: theme.textTheme.headline6),
                              Text(
                                'Followers',
                                style: theme.textTheme.subtitle2.copyWith(
                                  color: theme.hintColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          FadedScaleAnimation(
                            CircleAvatar(
                              radius: 40,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('3224', style: theme.textTheme.headline6),
                              Text(
                                "Following",
                                style: theme.textTheme.subtitle2.copyWith(
                                  color: theme.hintColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Mia",
                      style: theme.textTheme.headline6,
                    ),
                    Text(
                      "iamemiliwilliamson",
                      style: theme.textTheme.subtitle2.copyWith(
                        color: theme.hintColor,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: constraints.maxWidth * 0.35,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: theme.primaryColor,
                                  style: BorderStyle.solid,
                                  width: 1),
                              borderRadius: BorderRadius.circular(10),
                              color: theme.primaryColor),
                          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: Text(
                            "Edit Profile",
                            textAlign: TextAlign.center,
                            style: theme.textTheme.subtitle2.copyWith(
                              color: theme.scaffoldBackgroundColor,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      indicatorColor: theme.primaryColor,
                      indicatorSize: TabBarIndicatorSize.label,
                      tabs: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Posts",
                            style: theme.textTheme.bodyText1,
                          ),
                        ),
                        Text(
                          "Stories",
                          style: theme.textTheme.bodyText1,
                        ),
                        Text(
                          "Saved",
                          style: theme.textTheme.bodyText1,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // TabBarView(
            //   controller: _tabController,
            //   children: [
            Container(
              height: bheight * 0.6,
              child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 0,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.all(0),
                            leading: CircleAvatar(),
                            title: Text(
                              "Mia",
                              style: theme.textTheme.subtitle2.copyWith(
                                fontSize: 13.3,
                              ),
                            ),
                            subtitle: Text(
                              "today",
                              style: theme.textTheme.subtitle2.copyWith(
                                color: theme.hintColor,
                                fontSize: 11.7,
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(Icons.share),
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
                            child: Container(),
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
                                      color: grey,
                                      size: 18.2,
                                    ),
                                    SizedBox(width: 8.5),
                                    Text(
                                      "1.2k",
                                      style: TextStyle(
                                          color: grey,
                                          fontSize: 11.7,
                                          letterSpacing: 1),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    FaIcon(
                                      Icons.repeat_rounded,
                                      color: grey,
                                      size: 18.2,
                                    ),
                                    SizedBox(width: 8.5),
                                    Text(
                                      '287',
                                      style: TextStyle(
                                          color: grey,
                                          fontSize: 11.7,
                                          letterSpacing: 0.5),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.chat_bubble_outline,
                                      color: grey,
                                      size: 18.2,
                                    ),
                                    SizedBox(width: 8.5),
                                    Text(
                                      '287',
                                      style: TextStyle(
                                          color: grey,
                                          letterSpacing: 0.5,
                                          fontSize: 11.7),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.favorite_border,
                                      color: grey,
                                      size: 18.2,
                                    ),
                                    SizedBox(width: 8.5),
                                    Text(
                                      "8.2k",
                                      style: TextStyle(
                                          color: grey,
                                          letterSpacing: 1,
                                          fontSize: 11.7),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            //   Container(),
            // ],
            // ),
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
