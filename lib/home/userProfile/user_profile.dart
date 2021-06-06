import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:bubblez/auth/authMethods/Authentication.dart';
import 'package:bubblez/auth/authMethods/FirebaseOperations.dart';
import 'package:bubblez/home/components/post/editPost.dart';
import 'package:bubblez/home/components/postOperations/postFunctions.dart';
import 'package:bubblez/home/follow/follow.dart';
import 'package:bubblez/style/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../comments.dart';

class UserProfileScreen extends StatefulWidget {
  final String useruid;
  UserProfileScreen(this.useruid);
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
        body: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(widget.useruid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                return FadedSlideAnimation(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Follow(widget.useruid)));
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          StreamBuilder<QuerySnapshot>(
                                              stream: FirebaseFirestore.instance
                                                  .collection('users')
                                                  .doc(snapshot.data
                                                      .data()['useruid'])
                                                  .collection('followers')
                                                  .snapshots(),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return Text(
                                                    '0',
                                                    style: theme
                                                        .textTheme.headline6,
                                                  );
                                                } else
                                                  return Text(
                                                    snapshot.data.docs.length
                                                        .toString(),
                                                    style: theme
                                                        .textTheme.headline6,
                                                  );
                                              }),
                                          Text(
                                            'Followers',
                                            style: theme.textTheme.subtitle2
                                                .copyWith(
                                              color: theme.hintColor,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    FadedScaleAnimation(
                                      CircleAvatar(
                                        radius: 40,
                                        backgroundImage: NetworkImage(
                                            snapshot.data.data()['userimage']),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Follow(
                                                    widget.useruid, true)));
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          StreamBuilder<QuerySnapshot>(
                                              stream: FirebaseFirestore.instance
                                                  .collection('users')
                                                  .doc(snapshot.data
                                                      .data()['useruid'])
                                                  .collection('following')
                                                  .snapshots(),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return Text(
                                                    '0',
                                                    style: theme
                                                        .textTheme.headline6,
                                                  );
                                                } else
                                                  return Text(
                                                    snapshot.data.docs.length
                                                        .toString(),
                                                    style: theme
                                                        .textTheme.headline6,
                                                  );
                                              }),
                                          Text(
                                            "following",
                                            style: theme.textTheme.subtitle2
                                                .copyWith(
                                              color: theme.hintColor,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Text(
                                snapshot.data.data()['username'],
                                style: theme.textTheme.headline6,
                              ),
                              Text(
                                snapshot.data.data()['useremail'],
                                style: theme.textTheme.subtitle2.copyWith(
                                  color: theme.hintColor,
                                  fontSize: 12,
                                ),
                              ),
                              Spacer(),
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: white),
                                        padding:
                                            EdgeInsets.fromLTRB(10, 10, 10, 10),
                                        child: Text(
                                          "Message",
                                          style: theme.textTheme.subtitle2
                                              .copyWith(
                                            color: theme.primaryColor,
                                            fontSize: 12,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Provider.of<FirebaseOperations>(context,
                                                listen: false)
                                            .followUser(
                                              widget.useruid,
                                              Provider.of<Authentication>(
                                                      context,
                                                      listen: false)
                                                  .getUserUid,
                                              {
                                                'username': Provider.of<
                                                            FirebaseOperations>(
                                                        context,
                                                        listen: false)
                                                    .getInitUserName,
                                                'userimage': Provider.of<
                                                            FirebaseOperations>(
                                                        context,
                                                        listen: false)
                                                    .getInitUserImage,
                                                'useruid':
                                                    Provider.of<Authentication>(
                                                            context,
                                                            listen: false)
                                                        .getUserUid,
                                                'useremail': Provider.of<
                                                            FirebaseOperations>(
                                                        context,
                                                        listen: false)
                                                    .getInitUserEmail,
                                                'time': Timestamp.now()
                                              },
                                              Provider.of<Authentication>(
                                                      context,
                                                      listen: false)
                                                  .getUserUid,
                                              widget.useruid,
                                              {
                                                'username': snapshot.data
                                                    .data()['username'],
                                                'userimage': snapshot.data
                                                    .data()['userimage'],
                                                'useremail': snapshot.data
                                                    .data()['useremail'],
                                                'useruid': snapshot.data
                                                    .data()['useruid'],
                                                'time': Timestamp.now()
                                              },
                                            )
                                            .whenComplete(() {});
                                      },
                                      child: Container(
                                        width: constraints.maxWidth * 0.35,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: theme.primaryColor,
                                                style: BorderStyle.solid,
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: theme.primaryColor),
                                        padding:
                                            EdgeInsets.fromLTRB(10, 10, 10, 10),
                                        child: Text(
                                          'Follow',
                                          textAlign: TextAlign.center,
                                          style: theme.textTheme.subtitle2
                                              .copyWith(
                                            color:
                                                theme.scaffoldBackgroundColor,
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
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('users')
                              .doc(widget.useruid)
                              .collection('posts')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else {
                              return ListView(
                                children: snapshot.data.docs.map(
                                  (DocumentSnapshot documentSnapshot) {
                                    return Card(
                                      elevation: 0,
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          children: [
                                            ListTile(
                                              contentPadding: EdgeInsets.all(0),
                                              leading: CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    documentSnapshot
                                                        .data()['userimage']),
                                              ),
                                              title: Text(
                                                documentSnapshot
                                                    .data()['username'],
                                                style: theme.textTheme.bodyText1
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                              subtitle: Text(
                                                Provider.of<PostFunctions>(
                                                        context,
                                                        listen: false)
                                                    .getImageTimePosted
                                                    .toString(),
                                                style: theme.textTheme.bodyText1
                                                    .copyWith(
                                                        color: textGrey,
                                                        fontSize: 11),
                                              ),
                                              trailing: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
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
                                                        if (documentSnapshot
                                                                    .data()[
                                                                'useruid'] ==
                                                            Provider.of<Authentication>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .getUserUid) {
                                                          showModalBottomSheet(
                                                            context: context,
                                                            builder:
                                                                (context) =>
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
                                                                      Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (context) => UpdatePostScreen(documentSnapshot)));
                                                                    },
                                                                    child:
                                                                        FaIcon(
                                                                      FontAwesomeIcons
                                                                          .edit,
                                                                      size: 20,
                                                                    ),
                                                                  ),
                                                                  GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        showModalBottomSheet(
                                                                          context:
                                                                              context,
                                                                          builder: (context) =>
                                                                              Container(
                                                                            height:
                                                                                70,
                                                                            color:
                                                                                theme.primaryColor,
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                              children: [
                                                                                GestureDetector(
                                                                                    onTap: () {
                                                                                      Provider.of<FirebaseOperations>(context, listen: false).deleteUserData(documentSnapshot.data()['caption'], 'posts').whenComplete(() {
                                                                                        Navigator.pop(context);
                                                                                        Navigator.pop(context);
                                                                                      });
                                                                                    },
                                                                                    child: FaIcon(
                                                                                      FontAwesomeIcons.check,
                                                                                      size: 20,
                                                                                    )),
                                                                                GestureDetector(
                                                                                  onTap: () {
                                                                                    Navigator.pop(context);
                                                                                  },
                                                                                  child: FaIcon(
                                                                                    FontAwesomeIcons.times,
                                                                                    size: 22,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                      child: Icon(
                                                                          Icons
                                                                              .delete)),
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    child: Text(documentSnapshot
                                                        .data()['caption']),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: Image.network(
                                                  documentSnapshot
                                                      .data()['postimage']),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Row(
                                                    children: [
                                                      IconButton(
                                                          icon: Icon(
                                                            Icons
                                                                .favorite_border,
                                                            color: grey,
                                                            size: 20,
                                                          ),
                                                          onPressed: () {
                                                            Provider.of<PostFunctions>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .addLike(
                                                                    context,
                                                                    documentSnapshot
                                                                            .data()[
                                                                        'caption'],
                                                                    Provider.of<Authentication>(
                                                                            context,
                                                                            listen:
                                                                                false)
                                                                        .getUserUid);
                                                          }),
                                                      // SizedBox(width: 8.5),
                                                      StreamBuilder<
                                                              QuerySnapshot>(
                                                          stream: FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'posts')
                                                              .doc(documentSnapshot
                                                                      .data()[
                                                                  'caption'])
                                                              .collection(
                                                                  'likes')
                                                              .snapshots(),
                                                          builder: (context,
                                                              snapshot) {
                                                            if (snapshot
                                                                    .connectionState ==
                                                                ConnectionState
                                                                    .waiting) {
                                                              return Text(
                                                                '0',
                                                                style: TextStyle(
                                                                    color: grey,
                                                                    fontSize:
                                                                        12,
                                                                    letterSpacing:
                                                                        1),
                                                              );
                                                            } else
                                                              return Text(
                                                                snapshot.data
                                                                    .docs.length
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    color: grey,
                                                                    fontSize:
                                                                        12,
                                                                    letterSpacing:
                                                                        1),
                                                              );
                                                          }),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      IconButton(
                                                          icon: Icon(
                                                            Icons
                                                                .remove_red_eye,
                                                            size: 20,
                                                            color: grey,
                                                          ),
                                                          onPressed: () {}),
                                                      // SizedBox(width: 8.5),
                                                      StreamBuilder<
                                                              QuerySnapshot>(
                                                          stream: FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'posts')
                                                              .doc(documentSnapshot
                                                                      .data()[
                                                                  'caption'])
                                                              .collection(
                                                                  'views')
                                                              .snapshots(),
                                                          builder: (context,
                                                              snapshot) {
                                                            if (snapshot
                                                                    .connectionState ==
                                                                ConnectionState
                                                                    .waiting) {
                                                              return Text(
                                                                '0',
                                                                style: TextStyle(
                                                                    color: grey,
                                                                    fontSize:
                                                                        12,
                                                                    letterSpacing:
                                                                        1),
                                                              );
                                                            } else
                                                              return Text(
                                                                snapshot.data
                                                                    .docs.length
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    color: grey,
                                                                    fontSize:
                                                                        12,
                                                                    letterSpacing:
                                                                        1),
                                                              );
                                                          }),
                                                    ],
                                                  ),
                                                  // Row(
                                                  //   children: [
                                                  //     FaIcon(
                                                  //       Icons.repeat_rounded,
                                                  //       color: grey,
                                                  //       size: 20,
                                                  //     ),
                                                  //     SizedBox(width: 8.5),
                                                  //     Text(
                                                  //       '287',
                                                  //       style: TextStyle(
                                                  //           color: grey,
                                                  //           fontSize: 12,
                                                  //           letterSpacing: 0.5),
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                  Row(
                                                    children: [
                                                      IconButton(
                                                          icon: Icon(
                                                            Icons
                                                                .chat_bubble_outline,
                                                            color: grey,
                                                            size: 20,
                                                          ),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .push(MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        CommentScreen(
                                                                            documentSnapshot)));
                                                          }),
                                                      // SizedBox(width: 8.5),
                                                      StreamBuilder<
                                                              QuerySnapshot>(
                                                          stream: FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'posts')
                                                              .doc(documentSnapshot
                                                                      .data()[
                                                                  'caption'])
                                                              .collection(
                                                                  'comments')
                                                              .snapshots(),
                                                          builder: (context,
                                                              snapshot) {
                                                            if (snapshot
                                                                    .connectionState ==
                                                                ConnectionState
                                                                    .waiting) {
                                                              return Text(
                                                                '0',
                                                                style: TextStyle(
                                                                    color: grey,
                                                                    fontSize:
                                                                        12,
                                                                    letterSpacing:
                                                                        1),
                                                              );
                                                            } else
                                                              return Text(
                                                                snapshot.data
                                                                    .docs.length
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    color: grey,
                                                                    fontSize:
                                                                        12,
                                                                    letterSpacing:
                                                                        1),
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
                                  },
                                ).toList(),
                              );
                            }
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
                );
              }
            }));
  }
}
