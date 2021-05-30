import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:bubblez/auth/authMethods/Authentication.dart';
import 'package:bubblez/auth/authMethods/FirebaseOperations.dart';
import 'package:bubblez/home/components/postOperations/postFunctions.dart';
import 'package:bubblez/style/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CommentScreen extends StatefulWidget {
  DocumentSnapshot snapshot;
  CommentScreen(this.snapshot);
  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  TextEditingController _commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final bHeight = mediaQuery.size.height - mediaQuery.padding.top;
    return Scaffold(
      body: FadedSlideAnimation(
        SafeArea(
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: (bHeight - 60) * 0.4,
                        child: Image.network(
                          widget.snapshot.data()['postimage'],
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.chevron_left),
                      ),
                    ],
                  ),
                  FadedSlideAnimation(
                    Container(
                      height: (bHeight - 60) * 0.6,
                      // color: Color.fromRGBO(27, 77, 42, 1),
                      // decoration: BoxDecoration(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: lightGrey,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                              ),
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        CircleAvatar(
                                          radius: 25,
                                          backgroundImage: NetworkImage(widget
                                              .snapshot
                                              .data()['userimage']),
                                        ),
                                        SizedBox(width: 10),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(widget.snapshot
                                                .data()['username']),
                                            // Text("today",
                                            //     style: theme.textTheme.bodyText1
                                            //         .copyWith(
                                            //             color: Colors.grey,
                                            //             fontSize: 11)),
                                          ],
                                        ),
                                        Spacer(),
                                        Icon(
                                          Icons.bookmark_outline,
                                          size: 20,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(width: 10),
                                        FaIcon(
                                          Icons.repeat_rounded,
                                          size: 20,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(width: 10),
                                        Icon(
                                          Icons.favorite_border,
                                          size: 20,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(width: 10),
                                        StreamBuilder<QuerySnapshot>(
                                            stream: FirebaseFirestore.instance
                                                .collection('posts')
                                                .doc(widget.snapshot
                                                    .data()['caption'])
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
                                        SizedBox(width: 10),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 10, 0, 9),
                                    child: Text(
                                      widget.snapshot.data()['caption'],
                                      textAlign: TextAlign.left,
                                      style: theme.textTheme.headline6.copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('posts')
                                  .doc(widget.snapshot.data()['caption'])
                                  .collection('comments')
                                  .orderBy('time')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  return ListView(
                                    shrinkWrap: true,
                                    children: snapshot.data.docs.map(
                                        (DocumentSnapshot documentSnapshot) {
                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        color: Colors.white,
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                documentSnapshot
                                                    .data()['userimage']),
                                          ),
                                          title: RichText(
                                            text: TextSpan(
                                              style: theme.textTheme.bodyText1
                                                  .copyWith(fontSize: 17),
                                              children: [
                                                TextSpan(
                                                  text: documentSnapshot
                                                      .data()['username'],
                                                  style: theme
                                                      .textTheme.headline6
                                                      .copyWith(fontSize: 14),
                                                ),
                                                TextSpan(
                                                    text: '   ' + "today",
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.grey)),
                                              ],
                                            ),
                                          ),
                                          subtitle: Text(
                                            documentSnapshot.data()['comment'],
                                            style: theme.textTheme.subtitle2
                                                .copyWith(
                                              fontSize: 12,
                                            ),
                                          ),
                                          trailing: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                  icon: Icon(
                                                    Icons.favorite_border,
                                                    size: 20,
                                                  ),
                                                  onPressed: () {}),
                                              Text('0',
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.grey)),
                                              IconButton(
                                                  icon: Icon(
                                                    Icons.reply,
                                                    size: 20,
                                                  ),
                                                  onPressed: () {}),
                                              Text('0',
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.grey)),
                                              Provider.of<Authentication>(
                                                              context,
                                                              listen: false)
                                                          .getUserUid ==
                                                      widget.snapshot
                                                          .data()['useruid']
                                                  ? IconButton(
                                                      icon: Icon(
                                                        Icons.delete,
                                                        color: Colors.red,
                                                        size: 20,
                                                      ),
                                                      onPressed: () {})
                                                  : SizedBox.shrink()
                                            ],
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  );
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    beginOffset: Offset(0, 0.3),
                    endOffset: Offset(0, 0),
                    slideCurve: Curves.linearToEaseOut,
                  ),
                  Container(
                    decoration: BoxDecoration(color: white, boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 0.8,
                        spreadRadius: 0.5,
                      ),
                    ]),
                    height: 60,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            Provider.of<FirebaseOperations>(context,
                                    listen: false)
                                .getInitUserImage),
                      ),
                      title: TextField(
                        controller: _commentController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Write your Comment",
                          hintStyle: TextStyle(fontSize: 14),
                        ),
                      ),
                      trailing: IconButton(
                          icon: Icon(Icons.send, color: theme.primaryColor),
                          onPressed: () {
                            print("Adding Comment");
                            Provider.of<PostFunctions>(context, listen: false)
                                .addComment(
                                    context,
                                    widget.snapshot.data()['caption'],
                                    _commentController.text);
                            _commentController.clear();
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
