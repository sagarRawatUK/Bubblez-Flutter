import 'dart:async';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:bubblez/auth/authMethods/Authentication.dart';
import 'package:bubblez/home/components/group/group_info.dart';
import 'package:bubblez/home/components/group/group_message_helper.dart';
import 'package:bubblez/style/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:bubblez/home/components/chat_tabs/chat_helpers.dart';

class GroupChatScreen extends StatefulWidget {
  DocumentSnapshot documentSnapshot;
  GroupChatScreen(this.documentSnapshot);

  @override
  _GroupChatScreenState createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  TextEditingController messageTextController = TextEditingController();

  @override
  void initState() {
    Provider.of<GroupMessageHelpers>(context, listen: false)
        .checkIfJoined(context, widget.documentSnapshot.id,
            widget.documentSnapshot.data()['useruid'])
        .whenComplete(() async {
      if (Provider.of<GroupMessageHelpers>(context, listen: false)
              .getHasMemberJoined ==
          false) {
        Timer(
            Duration(milliseconds: 10),
            () => Provider.of<GroupMessageHelpers>(context, listen: false)
                .askToJoin(context, widget.documentSnapshot.id));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final myAppBar = AppBar(
      elevation: 0,
      backgroundColor: white,
      title: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => GroupInfoScreen(widget.documentSnapshot)));
        },
        child: Transform(
          transform: Matrix4.translationValues(-25, 0, 0),
          child: Row(
            children: [
              FadedScaleAnimation(
                Hero(
                  tag: 'roomAvatar',
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      widget.documentSnapshot.data()['roomavatar'],
                      scale: 2,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.documentSnapshot.data()['roomname'],
                    style: theme.textTheme.headline6
                        .copyWith(fontWeight: FontWeight.w500, fontSize: 16.7),
                  ),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('chatrooms')
                        .doc(widget.documentSnapshot.id)
                        .collection('members')
                        .snapshots(),
                    builder: (context, snapshot) {
                      return snapshot.connectionState == ConnectionState.waiting
                          ? Text("")
                          : Text(
                              "${snapshot.data.docs.length.toString()} members",
                              style: theme.textTheme.subtitle2.copyWith(
                                  color: theme.hintColor, fontSize: 10),
                            );
                    },
                  )
                ],
              ),
              // SizedBox(
              //   width: 10,
              // ),
              // Text(
              //   'is Typing...',
              //   style: theme.textTheme.subtitle2
              //       .copyWith(color: theme.hintColor, fontSize: 11.7),
              // )
            ],
          ),
        ),
      ),
      leading: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Icon(Icons.chevron_left),
      ),
    );
    final bHeight = mediaQuery.size.height -
        mediaQuery.padding.top -
        myAppBar.preferredSize.height;
    return Scaffold(
      backgroundColor: white,
      appBar: myAppBar,
      body: FadedSlideAnimation(
        ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(10),
              height: bHeight * 0.89,
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('chatrooms')
                      .doc(widget.documentSnapshot.id)
                      .collection('messages')
                      .orderBy('time', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else
                      return ListView(
                          reverse: true,
                          children: snapshot.data.docs
                              .map((DocumentSnapshot snapshot) {
                            Provider.of<GroupMessageHelpers>(context,
                                    listen: false)
                                .showLastMessageTime(snapshot.data()['time']);
                            var maxm = snapshot
                                .data()['message']
                                .split('\n')
                                .map((e) => e.length)
                                .toList();
                            maxm.sort();
                            return GestureDetector(
                              onLongPress: () {
                                if (Provider.of<Authentication>(context,
                                            listen: false)
                                        .getUserUid ==
                                    snapshot.data()['useruid']) {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) => Container(
                                      height: 70,
                                      color: theme.primaryColor,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (context) =>
                                              //             UpdatePostScreen(
                                              //                 snapshot)));
                                            },
                                            child: FaIcon(
                                              FontAwesomeIcons.edit,
                                              size: 20,
                                            ),
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  context: context,
                                                  builder: (context) =>
                                                      Container(
                                                    height: 40,
                                                    color: theme.primaryColor,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        GestureDetector(
                                                            onTap: () {
                                                              // Provider.of<FirebaseOperations>(
                                                              //         context,
                                                              //         listen:
                                                              //             false)
                                                              //     .deleteUserData(
                                                              //         snapshot.data()['caption'],
                                                              //         'posts')
                                                              //     .whenComplete(() {
                                                              //   Navigator.pop(
                                                              //       context);
                                                              //   Navigator.pop(
                                                              //       context);
                                                              // });
                                                            },
                                                            child: FaIcon(
                                                              FontAwesomeIcons
                                                                  .check,
                                                              size: 20,
                                                            )),
                                                        GestureDetector(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: FaIcon(
                                                            FontAwesomeIcons
                                                                .times,
                                                            size: 22,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Icon(Icons.delete)),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: Column(
                                crossAxisAlignment: Provider.of<Authentication>(
                                                context,
                                                listen: false)
                                            .getUserUid ==
                                        snapshot.data()['useruid']
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        Provider.of<Authentication>(context,
                                                        listen: false)
                                                    .getUserUid ==
                                                snapshot.data()['useruid']
                                            ? MainAxisAlignment.end
                                            : MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Provider.of<Authentication>(context,
                                                      listen: false)
                                                  .getUserUid ==
                                              snapshot.data()['useruid']
                                          ? SizedBox.shrink()
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 4),
                                              child: CircleAvatar(
                                                radius: 15,
                                                backgroundImage: NetworkImage(
                                                  snapshot.data()['userimage'],
                                                ),
                                              ),
                                            ),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(5, 4, 10, 4),
                                        padding:
                                            EdgeInsets.fromLTRB(10, 5, 10, 5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Provider.of<Authentication>(
                                                          context,
                                                          listen: false)
                                                      .getUserUid ==
                                                  snapshot.data()['useruid']
                                              ? theme.primaryColor
                                              : lightGrey,
                                        ),
                                        // width: mediaQuery.size.width * 0.7,
                                        width: maxm.last * 11.0 >=
                                                mediaQuery.size.width * 0.7
                                            ? mediaQuery.size.width * 0.7
                                            : maxm.last * 13.0,
                                        alignment: Provider.of<Authentication>(
                                                        context,
                                                        listen: false)
                                                    .getUserUid ==
                                                snapshot.data()['useruid']
                                            ? Alignment.centerRight
                                            : Alignment.centerLeft,
                                        child: Column(
                                          crossAxisAlignment:
                                              Provider.of<Authentication>(
                                                              context,
                                                              listen: false)
                                                          .getUserUid ==
                                                      snapshot.data()['useruid']
                                                  ? CrossAxisAlignment.end
                                                  : CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              Provider.of<Authentication>(
                                                              context,
                                                              listen: false)
                                                          .getUserUid ==
                                                      snapshot.data()['useruid']
                                                  ? "you"
                                                  : snapshot.data()['username'],
                                              overflow: TextOverflow.ellipsis,
                                              style: theme.textTheme.bodyText1
                                                  .copyWith(
                                                fontSize: 8,
                                                color:
                                                    Provider.of<Authentication>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .getUserUid ==
                                                            snapshot.data()[
                                                                'useruid']
                                                        ? white
                                                        : theme.primaryColor,
                                              ),
                                              textAlign:
                                                  Provider.of<Authentication>(
                                                                  context,
                                                                  listen: false)
                                                              .getUserUid ==
                                                          snapshot
                                                              .data()['useruid']
                                                      ? TextAlign.right
                                                      : TextAlign.left,
                                            ),
                                            Text(
                                              snapshot.data()['message'],
                                              style: theme.textTheme.bodyText1
                                                  .copyWith(
                                                fontSize: 13,
                                                color:
                                                    Provider.of<Authentication>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .getUserUid ==
                                                            snapshot.data()[
                                                                'useruid']
                                                        ? white
                                                        : black,
                                              ),
                                              textAlign:
                                                  Provider.of<Authentication>(
                                                                  context,
                                                                  listen: false)
                                                              .getUserUid ==
                                                          snapshot
                                                              .data()['useruid']
                                                      ? TextAlign.right
                                                      : TextAlign.left,
                                            ),
                                            Text(
                                                Provider.of<GroupMessageHelpers>(
                                                        context)
                                                    .getLastMessageTime,
                                                overflow: TextOverflow.ellipsis,
                                                style: theme.textTheme.bodyText1
                                                    .copyWith(
                                                  fontSize: 7,
                                                  color:
                                                      Provider.of<Authentication>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .getUserUid ==
                                                              snapshot.data()[
                                                                  'useruid']
                                                          ? white
                                                          : black,
                                                ),
                                                textAlign: TextAlign.right),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }).toList());
                  }),
            ),
            Container(
              height: bHeight * 0.085,
              width: mediaQuery.size.width,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.emoji_emotions_outlined,
                    color: theme.hintColor,
                    size: 20,
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: mediaQuery.size.width * 0.7,
                    child: TextField(
                      controller: messageTextController,
                      decoration: InputDecoration(
                        hintText: "Type your message",
                        hintStyle: TextStyle(
                          fontSize: 12,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      if (messageTextController.text.isNotEmpty) {
                        Provider.of<GroupMessageHelpers>(context, listen: false)
                            .sendMessage(context, widget.documentSnapshot,
                                messageTextController);
                      }
                      messageTextController.clear();
                    },
                    child: Icon(
                      Icons.send,
                      color: theme.primaryColor,
                      size: 20,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
