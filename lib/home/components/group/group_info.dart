import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:bubblez/auth/authMethods/Authentication.dart';
import 'package:bubblez/home/userProfile/user_profile.dart';
import 'package:bubblez/style/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupInfoScreen extends StatefulWidget {
  DocumentSnapshot documentSnapshot;
  GroupInfoScreen(this.documentSnapshot);
  @override
  _GroupInfoScreenState createState() => _GroupInfoScreenState();
}

class GroupItems {
  String image;
  String name;

  GroupItems(this.image, this.name);
}

class _GroupInfoScreenState extends State<GroupInfoScreen> {
  bool _muteNotiVal = true;

  @override
  Widget build(BuildContext context) {
    List<GroupItems> _groupItems = [
      GroupItems('assets/images/Layer949.png', 'Emili'),
      GroupItems('assets/images/Layer946.png', 'Harsh'),
      GroupItems('assets/images/Layer946.png', 'David'),
      GroupItems('assets/images/Layer948.png', 'Whie'),
      GroupItems('assets/images/Layer949.png', 'Marie'),
      GroupItems('assets/images/Layer949.png', 'Marie'),
    ];
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final myAppBar = AppBar(
      titleSpacing: 0,
      backgroundColor: white,
      title: Text("Group Info",
          style: theme.textTheme.button.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          )),
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.chevron_left),
      ),
      actions: [
        FlatButton(
          onPressed: () {},
          child: Text(
            "Edit",
            style: theme.textTheme.button.copyWith(color: theme.primaryColor),
          ),
        ),
      ],
    );
    final bheight = mediaQuery.size.height -
        mediaQuery.padding.top -
        myAppBar.preferredSize.height;
    return Scaffold(
      appBar: myAppBar,
      body: FadedSlideAnimation(
        Container(
          height: bheight,
          width: mediaQuery.size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FadedScaleAnimation(
                  Container(
                    margin: EdgeInsets.only(top: 40),
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: Hero(
                      tag: 'roomAvatar',
                      child: CircleAvatar(
                        radius: bheight * 0.1,
                        backgroundImage: NetworkImage(
                            widget.documentSnapshot.data()['roomavatar']),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: bheight * 0.15,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          widget.documentSnapshot.data()['roomname'],
                          style: theme.textTheme.headline6.copyWith(
                              fontWeight: FontWeight.w500, fontSize: 20),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          widget.documentSnapshot.data()['roomdescription'],
                          style: theme.textTheme.headline6.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: grey,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: grey[350],
                  thickness: 2,
                ),
                Container(
                  height: bheight * 0.05,
                  padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                  child: Row(
                    children: [
                      Text(
                        "Mute Notification",
                        style: theme.textTheme.headline6.copyWith(
                            fontWeight: FontWeight.normal, fontSize: 14),
                      ),
                      Spacer(),
                      CupertinoSwitch(
                        value: _muteNotiVal,
                        onChanged: (val) {
                          setState(() {
                            _muteNotiVal = val;
                          });
                        },
                        activeColor: theme.primaryColor,
                      )
                    ],
                  ),
                ),
                Divider(
                  color: grey[350],
                  thickness: 2,
                ),
                Container(
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(
                            left: 20, bottom: 10, right: 10, top: 12),
                        child: Text(
                          "Media Shared",
                          style: theme.textTheme.bodyText1
                              .copyWith(color: grey[400], fontSize: 12),
                        ),
                      ),
                      Container(
                        width: mediaQuery.size.width,
                        margin: EdgeInsets.fromLTRB(20, 0, 10, 20),
                        height: 70,
                        child: Row(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  decoration:
                                      BoxDecoration(color: Colors.grey[300]),
                                ),
                                Text(
                                  "View all",
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 1),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('chatrooms')
                      .doc(widget.documentSnapshot.id)
                      .collection('members')
                      .snapshots(),
                  builder: (context, snapshot) {
                    return snapshot.connectionState == ConnectionState.waiting
                        ? Container(
                            width: double.infinity,
                            color: Colors.grey[350],
                            padding: EdgeInsets.all(15),
                            child: Text(""),
                          )
                        : Container(
                            width: double.infinity,
                            color: Colors.grey[350],
                            padding: EdgeInsets.all(15),
                            child: Text(
                              "${snapshot.data.docs.length.toString()} members",
                              style: theme.textTheme.headline6.copyWith(
                                  fontWeight: FontWeight.normal,
                                  color: theme.hintColor,
                                  fontSize: 14),
                            ),
                          );
                  },
                ),
                Container(
                  alignment: Alignment.center,
                  height: bheight * 0.4,
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('chatrooms')
                          .doc(widget.documentSnapshot.id)
                          .collection('members')
                          .snapshots(),
                      builder: (context, snapshot) {
                        return snapshot.connectionState ==
                                ConnectionState.waiting
                            ? CircularProgressIndicator()
                            : ListView(
                                children: snapshot.data.docs.map<Widget>(
                                    (DocumentSnapshot documentSnapshot) {
                                return ListTile(
                                  onTap: () {
                                    if (Provider.of<Authentication>(context)
                                            .getUserUid !=
                                        documentSnapshot.data()['useruid'])
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UserProfileScreen(
                                                      documentSnapshot
                                                          .data()['useruid'])));
                                  },
                                  leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(40),
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        child: Image.network(
                                          documentSnapshot.data()['userimage'],
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                                  title: Text(
                                    documentSnapshot.data()['username'],
                                    style: theme.textTheme.subtitle2.copyWith(
                                      fontSize: 14,
                                    ),
                                  ),
                                  subtitle: Text(
                                    "Member",
                                    style: theme.textTheme.subtitle2.copyWith(
                                      color: theme.hintColor,
                                      fontSize: 10,
                                    ),
                                  ),
                                );
                              }).toList());
                      }),
                ),
              ],
            ),
          ),
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: theme.primaryColor,
        child: Icon(
          Icons.add,
          color: theme.iconTheme.color,
        ),
      ),
    );
  }
}
