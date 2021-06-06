import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:bubblez/auth/authMethods/Authentication.dart';
import 'package:bubblez/auth/authMethods/FirebaseOperations.dart';
import 'package:bubblez/home/comments.dart';
import 'package:bubblez/home/components/post/editPost.dart';
import 'package:bubblez/home/components/postOperations/postFunctions.dart';
import 'package:bubblez/home/userProfile/user_profile.dart';
import 'package:bubblez/style/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomeFollowingTabScreen extends StatelessWidget {
  final bHeight;

  HomeFollowingTabScreen({this.bHeight});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: bHeight,
      color: lightGrey,
      child: FadedSlideAnimation(
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('posts')
                .orderBy('time', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(child: CircularProgressIndicator());
              else {
                return ListView(
                  children: snapshot.data.docs.map((DocumentSnapshot snapshot) {
                    Provider.of<PostFunctions>(context, listen: false)
                        .showTimeAgo(snapshot.data()['time']);

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
                                  if (snapshot.data()['useruid'] !=
                                      Provider.of<Authentication>(context,
                                              listen: false)
                                          .getUserUid) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) => UserProfileScreen(
                                                snapshot.data()['useruid'])));
                                  }
                                },
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      snapshot.data()['userimage']),
                                ),
                              ),
                              title: Text(
                                snapshot.data()['username'],
                                style: theme.textTheme.bodyText1
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                Provider.of<PostFunctions>(context,
                                        listen: false)
                                    .getImageTimePosted
                                    .toString(),
                                style: theme.textTheme.bodyText1
                                    .copyWith(color: textGrey, fontSize: 11),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // Image.asset(
                                  //   'assets/Icons/ic_share.png',
                                  //   scale: 3,
                                  // ),
                                  // SizedBox(width: 20),
                                  IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: Icon(
                                        Icons.bookmark_border,
                                        size: 20,
                                        color: grey,
                                      ),
                                      onPressed: () {}),
                                  IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: Icon(
                                        Icons.more_vert,
                                        size: 20,
                                        color: grey,
                                      ),
                                      onPressed: () {
                                        if (snapshot.data()['useruid'] ==
                                            Provider.of<Authentication>(context,
                                                    listen: false)
                                                .getUserUid) {
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (context) => Container(
                                              height: 70,
                                              color: theme.primaryColor,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  UpdatePostScreen(
                                                                      snapshot)));
                                                    },
                                                    child: FaIcon(
                                                      FontAwesomeIcons.edit,
                                                      size: 20,
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                      onTap: () {
                                                        showModalBottomSheet(
                                                          context: context,
                                                          builder: (context) =>
                                                              Container(
                                                            height: 70,
                                                            color: theme
                                                                .primaryColor,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                GestureDetector(
                                                                    onTap: () {
                                                                      Provider.of<FirebaseOperations>(
                                                                              context,
                                                                              listen:
                                                                                  false)
                                                                          .deleteUserData(
                                                                              snapshot.data()['caption'],
                                                                              'posts')
                                                                          .whenComplete(() {
                                                                        Navigator.pop(
                                                                            context);
                                                                        Navigator.pop(
                                                                            context);
                                                                      });
                                                                    },
                                                                    child:
                                                                        FaIcon(
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
                                                      child:
                                                          Icon(Icons.delete)),
                                                ],
                                              ),
                                            ),
                                          );
                                        }
                                      })
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Container(
                                    child: Text(snapshot.data()['caption']),
                                  ),
                                ],
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child:
                                  Image.network(snapshot.data()['postimage']),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                          icon: Icon(
                                            Icons.favorite_border,
                                            color: grey,
                                            size: 20,
                                          ),
                                          onPressed: () {
                                            Provider.of<PostFunctions>(context,
                                                    listen: false)
                                                .addLike(
                                                    context,
                                                    snapshot.data()['caption'],
                                                    Provider.of<Authentication>(
                                                            context,
                                                            listen: false)
                                                        .getUserUid);
                                          }),
                                      // SizedBox(width: 8.5),
                                      StreamBuilder<QuerySnapshot>(
                                          stream: FirebaseFirestore.instance
                                              .collection('posts')
                                              .doc(snapshot.data()['caption'])
                                              .collection('likes')
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return Text(
                                                '0',
                                                style: TextStyle(
                                                    color: grey,
                                                    fontSize: 12,
                                                    letterSpacing: 1),
                                              );
                                            } else
                                              return Text(
                                                snapshot.data.docs.length
                                                    .toString(),
                                                style: TextStyle(
                                                    color: grey,
                                                    fontSize: 12,
                                                    letterSpacing: 1),
                                              );
                                          }),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                          icon: Icon(
                                            Icons.remove_red_eye,
                                            size: 20,
                                            color: grey,
                                          ),
                                          onPressed: () {}),
                                      // SizedBox(width: 8.5),
                                      StreamBuilder<QuerySnapshot>(
                                          stream: FirebaseFirestore.instance
                                              .collection('posts')
                                              .doc(snapshot.data()['caption'])
                                              .collection('views')
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return Text(
                                                '0',
                                                style: TextStyle(
                                                    color: grey,
                                                    fontSize: 12,
                                                    letterSpacing: 1),
                                              );
                                            } else
                                              return Text(
                                                snapshot.data.docs.length
                                                    .toString(),
                                                style: TextStyle(
                                                    color: grey,
                                                    fontSize: 12,
                                                    letterSpacing: 1),
                                              );
                                          }),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                          icon: Icon(
                                            Icons.chat_bubble_outline,
                                            color: grey,
                                            size: 20,
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CommentScreen(
                                                            snapshot)));
                                          }),
                                      // SizedBox(width: 8.5),
                                      StreamBuilder<QuerySnapshot>(
                                          stream: FirebaseFirestore.instance
                                              .collection('posts')
                                              .doc(snapshot.data()['caption'])
                                              .collection('comments')
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return Text(
                                                '0',
                                                style: TextStyle(
                                                    color: grey,
                                                    fontSize: 12,
                                                    letterSpacing: 1),
                                              );
                                            } else
                                              return Text(
                                                snapshot.data.docs.length
                                                    .toString(),
                                                style: TextStyle(
                                                    color: grey,
                                                    fontSize: 12,
                                                    letterSpacing: 1),
                                              );
                                          }),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              }
            }),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
