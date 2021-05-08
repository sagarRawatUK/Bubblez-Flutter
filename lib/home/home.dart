import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:bubblez/auth/authMethods/FirebaseOperations.dart';
import 'package:bubblez/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'components/chat_tabs/chat_floating_action_button.dart';
import 'components/custom_drawer.dart';
import 'components/home_screen_tab_content/home_floatin_action_button.dart';
import 'components/tabbars_view/chat_page_tabbar_view.dart';
import 'components/tabbars_view/home_page_tabbar_view.dart';
import 'components/tabbars_view/notification_page_tabbar_view.dart';
import 'components/tabbars_view/story_page_tabbar_view.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  bool isLoading;
  TabController _tabController;
  int _tabbarselectedIndex;
  int _bottombarIndex;
  int _tabLengthContoller;
  PersistentBottomSheetController _bottomSheetController;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    Provider.of<FirebaseOperations>(context, listen: false)
        .initUserData(context);
    super.initState();
    _tabbarselectedIndex = 1;
    _bottombarIndex = 0;
    _tabLengthContoller = 5;
  }

  @override
  Widget build(BuildContext context) {
    _tabController = TabController(
      length: _tabLengthContoller,
      vsync: this,
      initialIndex: _tabbarselectedIndex,
    );
    _tabController.addListener(() {
      setState(() {
        _tabbarselectedIndex = _tabController.index;
      });
    });
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final List<TabBar> _tabbarListAsPerBottomBar = [
      TabBar(
        isScrollable: true,
        controller: _tabController,
        indicatorColor: theme.primaryColor,
        indicatorSize: TabBarIndicatorSize.label,
        tabs: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.search,
                color: _tabbarselectedIndex == 0 ? theme.primaryColor : black),
          ),
          Text(
            "Following",
            style: TextStyle(
              color: _tabbarselectedIndex == 1 ? theme.primaryColor : black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Trending",
            style: TextStyle(
              color: _tabbarselectedIndex == 2 ? theme.primaryColor : black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Style",
            style: TextStyle(
              color: _tabbarselectedIndex == 3 ? theme.primaryColor : black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Travel",
            style: TextStyle(
              color: _tabbarselectedIndex == 4 ? theme.primaryColor : black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      TabBar(
        isScrollable: true,
        controller: _tabController,
        indicatorColor: theme.primaryColor,
        indicatorSize: TabBarIndicatorSize.label,
        tabs: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.search,
                color: _tabbarselectedIndex == 0 ? theme.primaryColor : black),
          ),
          Text(
            "Following",
            style: TextStyle(
              color: _tabbarselectedIndex == 1 ? theme.primaryColor : black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Trending",
            style: TextStyle(
              color: _tabbarselectedIndex == 2 ? theme.primaryColor : black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Style",
            style: TextStyle(
              color: _tabbarselectedIndex == 3 ? theme.primaryColor : black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Travel",
            style: TextStyle(
              color: _tabbarselectedIndex == 4 ? theme.primaryColor : black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      TabBar(
        isScrollable: true,
        controller: _tabController,
        indicatorColor: theme.primaryColor,
        indicatorSize: TabBarIndicatorSize.label,
        tabs: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "All",
              style: TextStyle(
                color: _tabbarselectedIndex == 0 ? theme.primaryColor : black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            "Likes",
            style: TextStyle(
              color: _tabbarselectedIndex == 1 ? theme.primaryColor : black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Comments",
            style: TextStyle(
              color: _tabbarselectedIndex == 2 ? theme.primaryColor : black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Repost",
            style: TextStyle(
              color: _tabbarselectedIndex == 3 ? theme.primaryColor : black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      TabBar(
        isScrollable: true,
        controller: _tabController,
        indicatorColor: theme.primaryColor,
        indicatorSize: TabBarIndicatorSize.label,
        tabs: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Friends",
              style: TextStyle(
                color: _tabbarselectedIndex == 0 ? theme.primaryColor : black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            "Groups",
            style: TextStyle(
              color: _tabbarselectedIndex == 1 ? theme.primaryColor : black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ];
    final myAppBar = AppBar(
      backgroundColor: white,
      automaticallyImplyLeading: false,
      title: _bottombarIndex == 0
          ? Container(
              alignment: Alignment.center,
              width: mediaQuery.size.width - 250,
              child: FadedScaleAnimation(Text(
                "Bubblez",
                style: TextStyle(color: Colors.black),
              )),
            )
          : _bottombarIndex == 1
              ? Text(
                  "Stories",
                  style: theme.textTheme.headline6.copyWith(fontSize: 24),
                )
              : _bottombarIndex == 2
                  ? Text(
                      "Notifications",
                      style: theme.textTheme.headline6.copyWith(fontSize: 24),
                    )
                  : Text(
                      "Chats",
                      style: theme.textTheme.headline6.copyWith(fontSize: 24),
                    ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: GestureDetector(
            onTap: () {
              _scaffoldKey.currentState.openEndDrawer();
            },
            child: FadedScaleAnimation(
              Provider.of<FirebaseOperations>(context).getInitUserImage == null
                  ? CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage("assets/plc_profile.png"),
                    )
                  : CircleAvatar(
                      backgroundImage: NetworkImage(
                          Provider.of<FirebaseOperations>(context,
                                  listen: false)
                              .getInitUserImage),
                      radius: 20,
                    ),
            ),
          ),
        ),
      ],
      bottom: _tabbarListAsPerBottomBar[_bottombarIndex],
    );
    final _bHeight = mediaQuery.size.height -
        mediaQuery.padding.top -
        myAppBar.preferredSize.height;
    final List<Widget> _bottomBarContentList = [
      HomeScreenTabbarView(_tabController, _bHeight),
      StoryScreenTabbarView(_tabController, _bHeight),
      NotificationScreenTabbarView(_tabController),
      ChatScreenTabbarView(_tabController),
    ];
    return Scaffold(
      key: _scaffoldKey,
      appBar: myAppBar,
      endDrawer: MyDrawer(),
      body: _bottomBarContentList[_bottombarIndex],
      floatingActionButton: _bottombarIndex == 0 || _bottombarIndex == 1
          ? CustomHomeFloatingActionButton(_updateBottomSheetInstance)
          : _bottombarIndex == 3
              ? FadedScaleAnimation(
                  CustomChatFloatingActionButton(_tabbarselectedIndex))
              : Container(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          if (index <= 1) {
            setState(() {
              _tabbarselectedIndex = 1;
              _tabLengthContoller = 5;
              _bottombarIndex = index;
            });
          } else if (index == 2) {
            setState(() {
              _tabbarselectedIndex = 0;
              _tabLengthContoller = 4;
              _bottombarIndex = index;
            });
          } else if (index == 3) {
            setState(() {
              _tabbarselectedIndex = 0;
              _tabLengthContoller = 2;
              _bottombarIndex = index;
            });
          }
          if (_bottomSheetController != null) {
            _bottomSheetController.close();
          }
        },
        type: BottomNavigationBarType.fixed,
        currentIndex: _bottombarIndex,
        selectedIconTheme: IconThemeData(
          color: theme.primaryColor,
        ),
        unselectedIconTheme: IconThemeData(
          color: grey,
        ),
        selectedLabelStyle: TextStyle(fontSize: 0),
        unselectedLabelStyle: TextStyle(fontSize: 0),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.video,
              size: 20,
            ),
            label: 'Video',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Noti',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.comments,
              size: 20,
            ),
            label: 'Chat',
          ),
        ],
      ),
    );
  }

  _updateBottomSheetInstance(_instance) {
    _bottomSheetController = _instance;
  }
}
