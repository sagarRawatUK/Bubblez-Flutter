import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:bubblez/home/components/group/group_chat_screen.dart';
import 'package:bubblez/style/colors.dart';
import 'package:flutter/material.dart';

class GroupInfoEditScren extends StatelessWidget {
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
      title: Text(
        "Group Info",
        style: theme.textTheme.headline6,
      ),
    );
    final bheight = mediaQuery.size.height -
        mediaQuery.padding.top -
        myAppBar.preferredSize.height;
    return Scaffold(
      backgroundColor: white,
      appBar: myAppBar,
      body: FadedSlideAnimation(
        Container(
          width: mediaQuery.size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: lightGrey,
                    style: BorderStyle.solid,
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Icon(
                    Icons.camera_alt,
                    size: 40,
                    color: grey,
                  ),
                ),
              ),
              Container(
                child: Container(
                  alignment: Alignment.center,
                  width: 130,
                  margin: EdgeInsets.only(top: 30),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Add Group Name",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Divider(
                color: lightGrey,
                thickness: 2,
              ),
              Container(
                alignment: Alignment.center,
                width: 170,
                height: 100,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Add a Discription",
                    border: InputBorder.none,
                  ),
                ),
              ),
              Expanded(
                child: Container(color: lightGrey),
              ),
              Container(
                color: lightGrey,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => GroupChatScreen()));
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: theme.primaryColor,
                    ),
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "Create Group",
                      style: theme.textTheme.button,
                      textAlign: TextAlign.center,
                    ),
                  ),
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
