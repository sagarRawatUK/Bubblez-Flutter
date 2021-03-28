import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:bubblez/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
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
                      height: 70,
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
                              backgroundImage:
                                  AssetImage('assets/images/Layer710.png'),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('3224', style: theme.textTheme.headline6),
                              Text(
                                "following",
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
                      "emiliWilliamson",
                      style: theme.textTheme.headline6,
                    ),
                    Text(
                      "iamemiliwilliamson",
                      style: theme.textTheme.subtitle2.copyWith(
                        color: theme.hintColor,
                        fontSize: 12,
                      ),
                    ),
                    Spacer(),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: constraints.maxWidth * 0.35,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: theme.primaryColor,
                                      style: BorderStyle.solid,
                                      width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                  color: white),
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: Text(
                                "message",
                                style: theme.textTheme.subtitle2.copyWith(
                                  color: theme.primaryColor,
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          GestureDetector(
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
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: Text(
                                'Follow Now',
                                textAlign: TextAlign.center,
                                style: theme.textTheme.subtitle2.copyWith(
                                  color: theme.scaffoldBackgroundColor,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      indicatorColor: theme.primaryColor,
                      indicatorSize: TabBarIndicatorSize.label,
                      tabs: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "posts",
                            style: theme.textTheme.bodyText1,
                          ),
                        ),
                        Text(
                          "stories",
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
                            leading: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => UserProfileScreen()));
                              },
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/Layer710.png'),
                              ),
                            ),
                            title: Text(
                              "emiliWilliamson",
                              style: theme.textTheme.subtitle2.copyWith(
                                fontSize: 13.3,
                              ),
                            ),
                            subtitle: Text(
                              "today",
                              style: theme.textTheme.subtitle2.copyWith(
                                color: theme.hintColor,
                                fontSize: 10.7,
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Image.asset(
                                  'assets/Icons/ic_share.png',
                                  scale: 3,
                                ),
                                SizedBox(width: 10),
                                Icon(
                                  Icons.bookmark_border,
                                  size: 18,
                                ),
                                SizedBox(width: 10),
                                Icon(
                                  Icons.more_vert,
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset('assets/images/Layer709.png'),
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
                                      size: 18.3,
                                    ),
                                    SizedBox(width: 7),
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
                                      size: 18.3,
                                    ),
                                    SizedBox(width: 7),
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
                                      size: 18.3,
                                    ),
                                    SizedBox(width: 7),
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
                                      Icons.favorite_border,
                                      color: grey,
                                      size: 18.3,
                                    ),
                                    SizedBox(width: 7),
                                    Text(
                                      "2.8k",
                                      style: TextStyle(
                                          color: grey,
                                          fontSize: 11.7,
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
