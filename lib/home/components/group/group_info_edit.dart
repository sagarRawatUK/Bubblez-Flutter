import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:bubblez/auth/authMethods/Authentication.dart';
import 'package:bubblez/auth/authMethods/FirebaseOperations.dart';
import 'package:bubblez/home/components/chat_tabs/chat_helpers.dart';
import 'package:bubblez/style/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'create_group_add_member.dart';

class GroupInfoEditScren extends StatelessWidget {
  TextEditingController _groupNameController = TextEditingController();
  TextEditingController _groupDescController = TextEditingController();

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
      body: Stack(
        children: [
          FadedSlideAnimation(
            Container(
              width: mediaQuery.size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Provider.of<ChatroomHelpers>(context, listen: true)
                              .chatroomAvatarFile !=
                          null
                      ? CircleAvatar(
                          radius: 80.0,
                          backgroundImage: FileImage(
                              Provider.of<ChatroomHelpers>(context,
                                      listen: false)
                                  .chatroomAvatarFile))
                      : GestureDetector(
                          onTap: () {
                            Provider.of<ChatroomHelpers>(context, listen: false)
                                .selectChatroomAvatarOptionsSheet(context);
                          },
                          child: Container(
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
                        ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.center,
                    // width: 130,
                    margin: EdgeInsets.only(top: 30),
                    child: TextField(
                      controller: _groupNameController,
                      decoration: InputDecoration(
                        hintText: "Add Group Name",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Divider(
                    color: lightGrey,
                    thickness: 2,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),

                    alignment: Alignment.center,
                    // width: 170,
                    // height: 70,
                    child: TextField(
                      maxLines: 5,
                      controller: _groupDescController,
                      decoration: InputDecoration(
                        hintText: "Add a Discription",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  // Expanded(
                  //   child: Container(color: lightGrey),
                  // ),
                ],
              ),
            ),
            beginOffset: Offset(0, 0.3),
            endOffset: Offset(0, 0),
            slideCurve: Curves.linearToEaseOut,
          ),
          Container(
            alignment: Alignment.bottomCenter,
            // color: lightGrey,
            child: GestureDetector(
              onTap: () {
                Provider.of<FirebaseOperations>(context, listen: false)
                    .submitChatroomData(_groupNameController.text, {
                  'roomavatar':
                      Provider.of<ChatroomHelpers>(context, listen: false)
                          .chatroomAvatarUrl,
                  'time': Timestamp.now(),
                  'roomname': _groupNameController.text,
                  'roomdescription': _groupDescController.text,
                  'username':
                      Provider.of<FirebaseOperations>(context, listen: false)
                          .initUserName,
                  'useremail':
                      Provider.of<FirebaseOperations>(context, listen: false)
                          .initUserEmail,
                  'useruid': Provider.of<Authentication>(context, listen: false)
                      .getUserUid,
                });
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => ChatCreateGroupAddMemberScreen(
                        _groupNameController.text)));
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
    );
  }
}
