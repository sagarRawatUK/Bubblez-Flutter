import 'package:bubblez/services/FirebaseOperations.dart';
import 'package:bubblez/style/colors.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomepageHelpers with ChangeNotifier {
  Widget bottomNavBar(
      BuildContext context, int index, PageController pageController) {
    return BottomNavigationBar(
      selectedItemColor: blueColor,
      unselectedItemColor: whiteColor,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: index,
      iconSize: 25.0,
      onTap: (val) {
        index = val;
        pageController.jumpToPage(val);
        notifyListeners();
      },
      backgroundColor: Color(0xff040307),
      items: [
        BottomNavigationBarItem(
            icon: Icon(EvaIcons.homeOutline), label: "Home"),
        BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline), label: "Chats"),
        BottomNavigationBarItem(
            label: "Profile",
            icon: CircleAvatar(
                radius: 13.0,
                backgroundColor: blueGreyColor,
                backgroundImage: Provider.of<FirebaseOperations>(context,
                                listen: false)
                            .getInitUserImage ==
                        null
                    ? AssetImage("assets/icons/subject.png")
                    : NetworkImage(
                        Provider.of<FirebaseOperations>(context, listen: false)
                            .getInitUserImage))),
      ],
    );
  }
}
