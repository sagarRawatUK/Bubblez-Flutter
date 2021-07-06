import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:bubblez/auth/authMethods/Authentication.dart';
import 'package:bubblez/auth/authMethods/FirebaseOperations.dart';
import 'package:bubblez/home/chatroom/chat_helpers.dart';
import 'package:bubblez/style/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ChatSingleScreen extends StatefulWidget {
  final String chatId;
  ChatSingleScreen(this.chatId);

  @override
  _ChatSingleScreenState createState() => _ChatSingleScreenState();
}

class _ChatSingleScreenState extends State<ChatSingleScreen> {
  String senderUid;

  @override
  void initState() {
    Stream<DocumentSnapshot> snapshot = FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.chatId)
        .snapshots();
    senderUid = snapshot.first.toString();
    print(senderUid);
    super.initState();
  }

  final TextEditingController messageTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final myAppBar = AppBar(
      titleSpacing: 0,
      elevation: 0,
      backgroundColor: white,
      title: Row(
        children: [
          Container(
            height: 45,
            margin: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: FadedScaleAnimation(
              CircleAvatar(
                backgroundImage: NetworkImage(
                  Provider.of<FirebaseOperations>(context, listen: false)
                      .getInitUserImage,
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          Text(
            widget.chatId.toString().replaceAll("_", "").replaceAll(
                Provider.of<FirebaseOperations>(context, listen: false)
                    .getInitUserName,
                ""),
            style: theme.textTheme.headline6.copyWith(
              fontSize: 16.7,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
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
                      .collection('chats')
                      .doc(widget.chatId)
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
                            Provider.of<SingleChatHelpers>(context,
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
                                            // Text(
                                            //   Provider.of<Authentication>(
                                            //                   context,
                                            //                   listen: false)
                                            //               .getUserUid ==
                                            //           snapshot.data()['useruid']
                                            //       ? "you"
                                            //       : snapshot.data()['username'],
                                            //   overflow: TextOverflow.ellipsis,
                                            //   style: theme.textTheme.bodyText1
                                            //       .copyWith(
                                            //     fontSize: 8,
                                            //     color:
                                            //         Provider.of<Authentication>(
                                            //                         context,
                                            //                         listen:
                                            //                             false)
                                            //                     .getUserUid ==
                                            //                 snapshot.data()[
                                            //                     'useruid']
                                            //             ? white
                                            //             : theme.primaryColor,
                                            //   ),
                                            //   textAlign:
                                            //       Provider.of<Authentication>(
                                            //                       context,
                                            //                       listen: false)
                                            //                   .getUserUid ==
                                            //               snapshot
                                            //                   .data()['useruid']
                                            //           ? TextAlign.right
                                            //           : TextAlign.left,
                                            // ),
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
                                                Provider.of<SingleChatHelpers>(
                                                        context,
                                                        listen: false)
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
                        Provider.of<SingleChatHelpers>(context, listen: false)
                            .sendMessage(
                                context, widget.chatId, messageTextController);
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
