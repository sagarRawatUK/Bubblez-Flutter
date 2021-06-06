import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:bubblez/home/components/group/group_chat_screen.dart';
import 'package:bubblez/style/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'chat_helpers.dart';

class ChatItems {
  String image;
  String name;

  ChatItems(this.image, this.name);
}

class ChatGroupTabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
          margin: EdgeInsets.only(top: 5),
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chatrooms')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return ListView(
                    children: snapshot.data.docs
                        .map((DocumentSnapshot documentSnapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else
                        return ListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    GroupChatScreen(documentSnapshot)));
                          },
                          leading: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                child: FadedScaleAnimation(
                                  CircleAvatar(
                                    radius: 24,
                                    backgroundImage: NetworkImage(
                                        documentSnapshot.data()['roomavatar']),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          title: Text(
                            documentSnapshot.data()['roomname'],
                            style: TextStyle(color: black, fontSize: 14),
                          ),
                          subtitle: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('chatrooms')
                                .doc(documentSnapshot.id)
                                .collection('messages')
                                .orderBy('time', descending: true)
                                .snapshots(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              Provider.of<ChatroomHelpers>(context,
                                      listen: false)
                                  .showLastMessageTime(
                                      snapshot.data.docs.first.data()['time']);
                              return snapshot.connectionState ==
                                      ConnectionState.waiting
                                  ? Text('')
                                  : Expanded(
                                      child: Text(
                                        "${snapshot.data.docs.first.data()['username']} : ${snapshot.data.docs.first.data()['message']} ",
                                        overflow: TextOverflow.ellipsis,
                                        style:
                                            theme.textTheme.subtitle2.copyWith(
                                          color: theme.hintColor,
                                          fontSize: 11,
                                        ),
                                      ),
                                    );
                            },
                          ),
                          trailing: Text(
                            Provider.of<ChatroomHelpers>(context, listen: false)
                                    .getLatestMessageTime ??
                                "",
                            style: theme.textTheme.bodyText1
                                .copyWith(color: grey, fontSize: 9),
                          ),
                        );
                    }).toList(),
                  );
                }
              })),
    );
  }
}
